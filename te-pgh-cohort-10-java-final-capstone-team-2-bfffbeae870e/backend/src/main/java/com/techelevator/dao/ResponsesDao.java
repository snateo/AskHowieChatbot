package com.techelevator.dao;

import com.techelevator.model.Link;
import com.techelevator.model.Responses;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface ResponsesDao {

    List<Responses> getAllResponses();
    List<String> getAllTitles();
    List<String> getAllKeywords();
    Responses scanStringForKeyword(String userInput);
    Responses getASingleResponse(String userInput);
    List<Link> getLinks(String userInput);
    List<String> getAllTitlesAndKeywords();

}
