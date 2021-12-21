import axios from 'axios';

const http = axios.create({
    baseURL: "https://v2.jokeapi.dev/joke/Programming?blacklistFlags=nsfw,religious,political,racist,sexist,explicit",
    });

export default {

    getJoke() {
        return http.get();
    }
    
}