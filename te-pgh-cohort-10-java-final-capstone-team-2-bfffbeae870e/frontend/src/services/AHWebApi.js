import axios from 'axios';

export default {

    getKeywords() {
        return axios.get("/keywords");
    },

    getKeywordsAndTitles() {
        return axios.get("/titlesandkeys");
    },
    
    submitQuery(input) {
        return axios.post("/search", {content: input});
    }
}