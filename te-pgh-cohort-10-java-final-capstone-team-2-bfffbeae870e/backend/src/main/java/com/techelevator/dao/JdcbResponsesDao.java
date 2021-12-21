package com.techelevator.dao;

import com.techelevator.model.Link;
import com.techelevator.model.Responses;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Component
public class JdcbResponsesDao implements ResponsesDao{

    private final JdbcTemplate jdbcTemplate;

    public JdcbResponsesDao(JdbcTemplate jdbcTemplate){
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<Responses> getAllResponses() {
        String sql = "select * from responses;";
        SqlRowSet rowSet = jdbcTemplate.queryForRowSet(sql);
        List<Responses> responses = new ArrayList<>();
        while (rowSet.next()) {
            Responses response = mapRowToTransfers(rowSet);
            responses.add(response);
        }
        return responses;
    }

    @Override
    public List<String> getAllTitles() {
        String sql = "select title from responses;";
        SqlRowSet rowSet = jdbcTemplate.queryForRowSet(sql);
        List<String> responses = new ArrayList<>();
        while (rowSet.next()) {
            responses.add(rowSet.getString("title"));
        }
        return responses;
    }

    @Override
    public List<String> getAllKeywords() {
        List<String> keywords = new ArrayList<>();
        String sql = "SELECT keyword FROM keywords";
        SqlRowSet rowSet = jdbcTemplate.queryForRowSet(sql);
        while (rowSet.next()){
            keywords.add(rowSet.getString("keyword").toLowerCase());
        }
        return keywords;
    }

    @Override
    public List<String> getAllTitlesAndKeywords() {
        List<String> result = getAllKeywords();
        for (String word : getAllTitles()) {
            word = word.toLowerCase();
            if (!result.contains(word)) {
                result.add(word);
            }
        }
        return result;
    }

    @Override
    public Responses scanStringForKeyword(String userInput) {
        Set<String> titleMatch = new HashSet<>();
        String lowerCase = userInput.toLowerCase();
        List<String> keywords = getAllKeywords();
        Responses response = new Responses();
        String lastKeyword = "";

        for(String word : keywords) {
            if (lowerCase.contains(word)) {
                titleMatch.add(getTitleFromKeyword(word));
                lastKeyword = word;
            }
        }
        if (titleMatch.size() == 0) {
            response.setDescription("Sorry, I can't process that request +_+");
        }else if (titleMatch.size() == 1){
            return getASingleResponse(lastKeyword);
        }else{
            response.setMatches(new ArrayList<>(titleMatch));
        }
        return response;
    }

    private String getTitleFromKeyword(String keyword) {
        String sql = "select title from responses join keywords using(r_id) where keyword ilike ?";
        return jdbcTemplate.queryForObject(sql, String.class, keyword);
    }

    @Override
    public Responses getASingleResponse(String userInput){
        Responses singleResponse = new Responses();
        String sql = "SELECT description, img_text, img_url FROM responses JOIN keywords ON keywords.r_id = responses.r_id WHERE keyword ilike ?;";
        SqlRowSet rowSet = jdbcTemplate.queryForRowSet(sql, userInput);
        if (!rowSet.isBeforeFirst()){
            sql = "SELECT description, img_text, img_url FROM responses WHERE title ilike ?;";
            rowSet = jdbcTemplate.queryForRowSet(sql, userInput);
        }
        if(rowSet.next()) {
            singleResponse.setDescription(rowSet.getString("description"));
            singleResponse.setImg_text(rowSet.getString("img_text"));
            singleResponse.setImg_url(rowSet.getString("img_url"));
        }else{
            singleResponse.setDescription("Sorry, I can't process that request +_+");
        }
        List<Link> links = getLinks(userInput);
        singleResponse.setLinks(links);
        return singleResponse;
    }

    @Override
    public List<Link> getLinks(String userInput){
        List<Link> links = new ArrayList<>();
        Link link = new Link();
        String sql = "SELECT txt, url FROM links JOIN responses_links ON responses_links.l_id = links.l_id JOIN responses ON responses.r_id = responses_links.r_id JOIN keywords ON keywords.r_id = responses.r_id WHERE keyword ilike ?;";
        SqlRowSet rowSet = jdbcTemplate.queryForRowSet(sql, userInput);
        if (!rowSet.isBeforeFirst()){
            sql = "SELECT txt, url FROM links JOIN responses_links ON responses_links.l_id = links.l_id JOIN responses ON responses.r_id = responses_links.r_id WHERE title ilike ?;";
            rowSet = jdbcTemplate.queryForRowSet(sql, userInput);
        }
        while (rowSet.next()) {
            link = new Link();
            link.setTxt(rowSet.getString("txt"));
            link.setUrl(rowSet.getString("url"));
            links.add(link);
        }
        return links;
    }

    private Responses mapRowToTransfers(SqlRowSet rowSet) {
        Responses responses = new Responses();
        responses.setR_id(rowSet.getLong("r_id"));
        responses.setTitle(rowSet.getString("title"));
        responses.setDescription(rowSet.getString("description"));
        return responses;
    }

}
