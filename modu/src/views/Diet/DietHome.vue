<template>
  <div class="wrapper">
    <div class="header">
      <div class="date">
        <v-btn
          class="ma-2"
          color="white"
          @click="getPreviousDate"
          icon="mdi-arrow-left"
          variant="text"
        >
        </v-btn>
        <p>{{ formatDate(selectedDate) }}</p>
        <v-btn
          class="ma-2"
          color="white"
          @click="getNextDate"
          icon="mdi-arrow-right"
          variant="text"
        >
        </v-btn>
      </div>

      <v-btn color="red-darken-1" size="small" @click="createNewWorkoutOpen()">
        Ajouter repas
      </v-btn>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "DietHome",
  data() {
    return {
      selectedDate: new Date(),
      allMeals: [],
      allFoods: [],

      selected: {
        show: false,
        id: null,
        allExTODO: [],
        newWorkout: false,
      },
    };
  },
  async mounted() {
    this.getCurentDateMeals();
    this.createArraysForHoursAndDuration();
    await axios
      .get("https://modu-api.dorian-faure.fr/exercices")
      .then((response) => response.data)
      .then((data) => {
        this.allExercices = data;
      });
  },
  methods: {
    async getCurentDateMeals() {
      this.allMeals = [];
      await axios
        .get(
          `https://modu-api.dorian-faure.fr/meals?id_user=${this.$cookies.get(
            "id_user"
          )}&the_date=${this.formatDateToYYYYMMDD(this.selectedDate)}`
        )
        .then((response) => response.data)
        .then((data) => {
          this.allMeals = data;
          console.log(this.allMeals);
        });
    },
    createArraysForHoursAndDuration() {
      for (let i = 0; i < 24 * 6; i++) {
        this.listHours.push({
          time: i * 10,
          display: this.minutesToHour(i * 10, " heures "),
        });
      }
      for (let i = 0; i < 4 * 6; i++) {
        this.listDuration.push({
          time: i * 10,
          display: this.minutesToHour(i * 10, " heures "),
        });
      }
    },
    minutesToHour(integer, between) {
      // Calculate hours
      var hours = Math.floor(parseInt(integer) / 60);
      // Calculate minutes
      var minutes = integer % 60;

      // Format hours and minutes
      var hourString = hours < 10 ? "0" + hours : hours.toString();
      var minuteString = minutes < 10 ? "0" + minutes : minutes.toString();

      // Concatenate hours and minutes
      var timeString = hourString + between + minuteString;

      return timeString;
    },
    formatDateToYYYYMMDD(date) {
      const year = date.getFullYear();
      const month = String(date.getMonth() + 1).padStart(2, "0"); // Adding 1 because getMonth() returns zero-based index
      const day = String(date.getDate()).padStart(2, "0");
      return `${year}-${month}-${day}`;
    },
    getPreviousDate() {
      const newDate = new Date(this.selectedDate);
      newDate.setDate(newDate.getDate() - 1);
      this.selectedDate = newDate;
      this.getCurentDateMeals();
      //this.closeWorkout();
    },
    getNextDate() {
      const newDate = new Date(this.selectedDate);
      newDate.setDate(newDate.getDate() + 1);
      this.selectedDate = newDate;
      this.getCurentDateMeals();
      //this.closeWorkout();
    },
    formatDate(date) {
      const daysOfWeek = [
        "Dimanche",
        "Lundi",
        "Mardi",
        "Mercredi",
        "Jeudi",
        "Vendredi",
        "Samedi",
      ];
      const months = [
        "Janvier",
        "Février",
        "Mars",
        "Avril",
        "Mai",
        "Juin",
        "Juillet",
        "Août",
        "Septembre",
        "Octobre",
        "Novembre",
        "Décembre",
      ];

      const day = daysOfWeek[date.getDay()];
      const d = date.getDate();
      const month = months[date.getMonth()];

      return `${day} - ${d} ${month}`;
    },
  },
};
</script>

<style scoped>
.wrapper {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: flex-start;
  gap: 1rem;
}

.header {
  width: 100%;
  background: #d53737;

  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  padding: 0 0 10px 0;
}

.date {
  display: flex;
  width: 300px;
  margin-bottom: -15px;
  margin-top: -15px;
  justify-content: space-between;
  align-items: center;
  font-size: 1.2rem;
}
</style>
