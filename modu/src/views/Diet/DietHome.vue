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
    <div class="list-meals" v-if="!selected.show">
      <v-card
        v-for="meal in allMeals"
        :key="meal.id"
        class="mx-auto"
        width="380"
        hover
        @click="selectMeal(meal)"
      >
        <v-card-item>
          <v-card-title class="mb-2">
            {{ meal.name }}
          </v-card-title>

          <v-card-subtitle class="card-sub">
            <span>{{ minutesToHour(meal.start_min, "H") }} </span>
          </v-card-subtitle>
        </v-card-item>
      </v-card>
    </div>
    <div class="meal-details" v-else>
      <div class="all-btns">
        <v-btn class="ma-2" color="green-darken-2" size="small"> SAVE </v-btn>
        <v-btn class="ma-2" color="primary" size="small" @click="closeMeal()">
          <v-icon icon="mdi-arrow-up" size="small" start></v-icon>
          CLOSE
          <v-icon icon="mdi-arrow-up" size="small" end></v-icon>
        </v-btn>
        <v-btn class="ma-2" color="red-darken-2" size="small"> DELETE </v-btn>
      </div>
      <div class="add-food">
        <v-autocomplete
          label="Nourritures"
          :items="allFoods"
          item-title="name"
          item-value="id"
          v-model="newFood"
          variant="outlined"
        ></v-autocomplete>
        <v-btn color="green-darken-4" @click="addFoodToMeal">
          <v-icon icon="mdi-plus"></v-icon>
        </v-btn>
      </div>
      <div class="foodDetails">
        <p class="prot">
          {{ getSumOfDetails(0) }}
          P
        </p>
        <p class="fat">
          {{ getSumOfDetails(2) }}
          F
        </p>
        <p class="carbs">
          {{ getSumOfDetails(1) }}
          C
        </p>
      </div>
      <div
        v-for="food in selected.allSelectedFood"
        :key="food.id"
        class="listFood"
      >
        <p class="foodName" v-if="food.serving_quantity == 100">
          {{ food.name }} ({{
            (food.quantity / food.serving_quantity).toFixed(1)
          }}
          servings)
        </p>
        <p class="foodName" v-else>
          {{ food.name }} ({{ food.serving_quantity }}g serving)
        </p>
        <v-slider
          v-model="food.quantity"
          :max="food.serving_quantity * 3"
          :min="0"
          :step="1"
          hide-details
        >
          <template v-slot:append>
            <v-text-field
              v-model="food.quantity"
              :max="999"
              :min="0"
              density="compact"
              style="width: 80px"
              type="number"
              hide-details
              single-line
            ></v-text-field>
          </template>
        </v-slider>
        <div class="foodDetails">
          <p class="prot">
            {{
              Math.round((food.quantity / food.serving_quantity) * food.protein)
            }}
            P
          </p>
          <p class="fat">
            {{ Math.round((food.quantity / food.serving_quantity) * food.fat) }}
            F
          </p>
          <p class="carbs">
            {{
              Math.round((food.quantity / food.serving_quantity) * food.carbs)
            }}
            C
          </p>
        </div>
      </div>
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
        allSelectedFood: [],
      },
      allDetails: null,
      newFood: null,

      listHours: [],
      listDuration: [],
      selectedHour: 1160,
      selectedDuration: 90,
    };
  },
  async mounted() {
    this.getCurentDateMeals();
    this.createArraysForHoursAndDuration();
    await axios
      .get("https://modu-api.dorian-faure.fr/foods")
      .then((response) => response.data)
      .then((data) => {
        this.allFoods = data;
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
        });
    },
    getSumOfDetails(type) {
      let sum = {
        fat: 0,
        carbs: 0,
        prot: 0,
      };
      this.selected.allSelectedFood.forEach((e) => {
        sum.fat += Math.round((e.quantity / e.serving_quantity) * e.fat);
        sum.carbs += Math.round((e.quantity / e.serving_quantity) * e.carbs);
        sum.prot += Math.round((e.quantity / e.serving_quantity) * e.protein);
      });
      this.allDetails = sum;
      switch (type) {
        case 0:
          return sum.prot;
        case 1:
          return sum.carbs;
        case 2:
          return sum.fat;
        default:
          return -1;
      }
    },
    getFoodById(id) {
      return this.allFoods.find((f) => f.id === id);
    },
    addFoodToMeal() {
      let newFood = this.getFoodById(this.newFood);
      newFood.quantity = 0;
      this.selected.allSelectedFood.push(newFood);
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
      this.closeMeal();
    },
    getNextDate() {
      const newDate = new Date(this.selectedDate);
      newDate.setDate(newDate.getDate() + 1);
      this.selectedDate = newDate;
      this.getCurentDateMeals();
      this.closeMeal();
    },
    async selectMeal(meal) {
      this.selected.show = true;
      this.selected.id = meal.id;
      await axios
        .get("https://modu-api.dorian-faure.fr/foodsPerMeal/" + meal.id)
        .then((response) => response.data)
        .then((data) => {
          this.selected.allSelectedFood = data;
        });
    },
    closeMeal() {
      this.selected.show = false;
      this.selected.id = null;
      this.selected.allSelectedFood = [];
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

.list-meals {
  overflow-y: auto;

  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  align-items: center;
  gap: 1rem;
}

.card-sub {
  display: flex;
  justify-content: space-between;
}

.meals-details {
  overflow-y: auto;

  display: flex;
  flex-direction: column;
  justify-content: start;
  align-items: center;
  gap: 0.5rem;
}

.all-btns .v-btn {
  width: 100px;
}

.add-food {
  width: 100%;
  display: flex;
  gap: 0.5rem;

  margin-top: 0px;
  padding-top: 10px;
  position: relative;
}

.add-food .v-number-input,
.add-food .v-btn {
  width: 80px !important;
  height: 56px;
}

.actions {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 15px;
}

.foodName {
  font-size: 0.9rem;
  margin: 15px 0 -3px 0;
}

.foodDetails {
  width: 100%;
  margin-top: 10px;
  display: flex;
  justify-content: space-evenly;
}

.foodDetails p {
  width: 100px;
  font-size: 1rem;
  text-align: center;
  border: 1px solid;
  border-radius: 5px;
}

.foodDetails .fat {
  color: #039be5;
  border-color: #039be5;
}
.foodDetails .carbs {
  color: #fdd835;
  border-color: #fdd835;
}
.foodDetails .prot {
  color: #e53935;
  border-color: #e53935;
}

.listFood p {
  font-size: 0.8rem !important;
  opacity: 0.75;
}
</style>
