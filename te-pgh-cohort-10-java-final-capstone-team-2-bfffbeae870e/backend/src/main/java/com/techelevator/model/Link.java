package com.techelevator.model;

public class Link {

    private String name;
    private String txt;
    private String url;

    public Link (){}

    public Link(String txt, String url) {
        this.txt = txt;
        this.url = url;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTxt() {
        return txt;
    }

    public void setTxt(String txt) {
        this.txt = txt;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
