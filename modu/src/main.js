// Plugins
import { registerPlugins } from "@/plugins";

// Components
import App from "./App.vue";

// Composables
import { createApp } from "vue";
import router from "./router";
import "@/assets/global.css";

const app = createApp(App);

registerPlugins(app);

app.use(router).mount("#app");
