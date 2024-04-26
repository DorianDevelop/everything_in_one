<template>
  <v-layout class="overflow-visible">
    <v-bottom-navigation mode="shift" v-if="value == 0" class="alternate-menu" :bg-color="color" :elevation="0">
      <v-btn to="/diet/home" value="recent">
        <v-icon>mdi-home</v-icon>

        <span>Home</span>
      </v-btn>

      <v-btn to="/diet/schedules" value="favorites">
        <v-icon>mdi-calendar-month</v-icon>

        <span>Schedules</span>
      </v-btn>

      <v-btn to="/diet/stats" value="nearby">
        <v-icon>mdi-chart-line</v-icon>

        <span>Stats</span>
      </v-btn>
    </v-bottom-navigation>
    <v-bottom-navigation mode="shift" v-if="value == 1" class="alternate-menu" :bg-color="color" :elevation="0">
      <v-btn to="/workouts/home" value="recent">
        <v-icon>mdi-home</v-icon>

        <span>Home</span>
      </v-btn>

      <v-btn to="/workouts/schedules" value="favorites">
        <v-icon>mdi-calendar-month</v-icon>

        <span>Schedules</span>
      </v-btn>

      <v-btn to="/workouts/stats" value="nearby">
        <v-icon>mdi-chart-line</v-icon>

        <span>Stats</span>
      </v-btn>
    </v-bottom-navigation>
    <v-bottom-navigation v-model="value" :bg-color="color" :elevation="0" mode="shift">
      <v-btn to="/diet/home">
        <v-icon>mdi-food</v-icon>

        <span>Diet</span>
      </v-btn>

      <v-btn to="/workouts/home">
        <v-icon>mdi-dumbbell</v-icon>

        <span>Workouts</span>
      </v-btn>

      <v-btn to="/hours">
        <v-icon>mdi-clock-time-eight</v-icon>

        <span>Hours</span>
      </v-btn>

      <v-btn to="/notes">
        <v-icon>mdi-note</v-icon>

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
        case 0:
          return "red-darken-2";
        case 1:
          return "blue-darken-2";
        case 2:
          return "green-darken-2";
        case 3:
          return "black";
        default:
          return "black";
      }
    },
  },
};
</script>

<style scoped>
.v-bottom-navigation {
  position: initial !important;
}

.v-layout {
  display: flex;
  flex-direction: column;
}

.v-bottom-navigation .v-bottom-navigation__content>.v-btn {
  max-width: 25%;
  min-width: 25%;
}

.alternate-menu {
  height: 44px !important;
}

.alternate-menu .v-bottom-navigation__content>.v-btn {
  max-width: 33% !important;
  min-width: 33% !important;
}
</style>