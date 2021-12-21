package com.techelevator.model;

import java.util.List;

public class Responses {

    private long r_id;
    private String title;
    private String description;
    private String img_text;
    private String img_url;
    private List<Link> links;
    private boolean containsKeyword;
    private List<String> matches;

    public Responses(){}

    public Responses(long r_id, String title, String description, String img_text, String img_url, List<Link> links, List<String> matches){
    this.r_id = r_id;
    this.title = title;
    this.description = description;
    this.img_text = img_text;
    this.img_url = img_url;
    this.links = links;
    this.matches = matches;
    }

    public boolean isContainsKeyword() {
        return containsKeyword;
    }

    public void setContainsKeyword(boolean containsKeyword) {
        this.containsKeyword = containsKeyword;
    }

    public long getR_id() {
        return r_id;
    }

    public void setR_id(long r_id) {
        this.r_id = r_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImg_text() {
        return img_text;
    }

    public void setImg_text(String img_text) {
        this.img_text = img_text;
    }

    public String getImg_url() {
        return img_url;
    }

    public void setImg_url(String img_url) {
        this.img_url = img_url;
    }

    public List<Link> getLinks() {
        return links;
    }

    public void setLinks(List<Link> links) {
        this.links = links;
    }

    public List<String> getMatches() {
        return matches;
    }

    public void setMatches(List<String> matches) {
        this.matches = matches;
    }
}
