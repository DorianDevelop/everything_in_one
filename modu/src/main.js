// Plugins
import { registerPlugins } from "@/plugins";

// Components
import App from "./App.vue";

// Composables
import { createApp } from "vue";
import router from "./router";
import VueCookies from "vue-cookies";

import "@/assets/global.css";

const app = createApp(App);

registerPlugins(app);

app.use(VueCookies, { expires: "7d" }).use(router).mount("#app");
