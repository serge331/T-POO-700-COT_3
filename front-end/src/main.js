import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
import "./style.css"
import axios from 'axios'
import VueAxios from 'vue-axios'


const app = createApp(App);

app.use(router);
/*app.use(axios, {
    baseURL: "http://localhost:4000/api",
    headers: {
                "session": "session_token=" + localStorage.getItem("session_token")
            }
})*/

app.mount("#app");

// import 'mdb-vue-ui-kit/css/mdb.min.css';
