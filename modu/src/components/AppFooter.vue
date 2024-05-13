<template>
  <v-layout class="overflow-visible">
    <v-bottom-navigation
      mode="shift"
      v-if="value == 1"
      class="alternate-menu"
      :bg-color="color"
      :elevation="0"
    >
      <v-btn to="/diet/home">
        <v-icon size="small">mdi-home</v-icon>

        <span>Home</span>
      </v-btn>

      <v-btn to="/diet/schedules">
        <v-icon size="small">mdi-calendar-month</v-icon>

        <span>Schedules</span>
      </v-btn>

      <v-btn to="/diet/stats">
        <v-icon size="small">mdi-chart-line</v-icon>

        <span>Stats</span>
      </v-btn>
    </v-bottom-navigation>
    <v-bottom-navigation
      mode="shift"
      v-if="value == 2"
      class="alternate-menu"
      :bg-color="color"
      :elevation="0"
    >
      <v-btn to="/workouts/home">
        <v-icon size="small">mdi-home</v-icon>

        <span>Home</span>
      </v-btn>

      <v-btn to="/workouts/schedules">
        <v-icon size="small">mdi-calendar-month</v-icon>

        <span>Schedules</span>
      </v-btn>

      <v-btn to="/workouts/stats">
        <v-icon size="small">mdi-chart-line</v-icon>

        <span>Stats</span>
      </v-btn>
      <v-btn to="/workouts/exercices">
        <v-icon size="small">mdi-dumbbell</v-icon>

        <span>Exercices</span>
      </v-btn>
    </v-bottom-navigation>
    <v-bottom-navigation
      v-model="value"
      :bg-color="color"
      :elevation="0"
      mode="shift"
    >
      <v-btn to="/">
        <v-icon size="small">mdi-login</v-icon>

        <span>Login</span>
      </v-btn>

      <v-btn to="/diet/home">
        <v-icon size="small">mdi-food</v-icon>

        <span>Diet</span>
      </v-btn>

      <v-btn to="/workouts/home">
        <v-icon size="small">mdi-dumbbell</v-icon>

        <span>Workouts</span>
      </v-btn>

      <v-btn to="/hours">
        <v-icon size="small">mdi-clock-time-eight</v-icon>

        <span>Hours</span>
      </v-btn>

      <v-btn to="/notes">
        <v-icon size="small">mdi-note</v-icon>

        <span>Notes</span>
      </v-btn>
    </v-bottom-navigation>
  </v-layout>
</template>
<script>
export default {
  data: () => ({ value: 1 }),

  computed: {
    color() {
      switch (this.value) {
        case 1:
          return "red-darken-2";
        case 2:
          return "blue-darken-2";
        case 3:
          return "green-darken-2";
        case 4:
          return "grey-darken-2";
        default:
          return "black";
      }
    },
  },
  mounted() {
    let path = window.location.pathname.split("/");
    switch (path[1]) {
      case "diet":
        this.value = 1;
        break;
      case "workouts":
        this.value = 2;
        break;
      case "hours":
        this.value = 3;
        break;
      case "notes":
        this.value = 4;
        break;
      default:
        this.value = 0;
        break;
    }
  },
};
</script>

<style scoped>
.v-bottom-navigation {
  position: initial !important;
  height: 40px !important;
}

.v-layout {
  display: flex;
  flex-direction: column;
}

.v-bottom-navigation .v-bottom-navigation__content > .v-btn {
  max-width: 20%;
  min-width: 20%;
}
</style>
