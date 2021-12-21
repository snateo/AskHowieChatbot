import axios from 'axios';

const http = axios.create({
    baseURL: "https://catfact.ninja/fact"
});

export default {
    
    getCatFact() {
        return http.get();
    }
}