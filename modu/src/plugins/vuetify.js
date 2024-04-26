import "@mdi/font/css/materialdesignicons.css";
import "vuetify/styles";

import { VNumberInput } from "vuetify/labs/VNumberInput";

// Composables
import { createVuetify } from "vuetify";

export default createVuetify({
  components: {
    VNumberInput,
  },
  icons: {
    defaultSet: "mdi",
  },
  theme: {
    defaultTheme: "dark",
  },
});
