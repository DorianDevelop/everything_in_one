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

      <v-btn color="primary"> Ajouter workout </v-btn>
    </div>
    <div class="list-workouts" v-if="!selected.show">
      <v-card
        v-for="workout in allWorkouts"
        :key="workout.id"
        class="mx-auto"
        width="380"
        hover
        @click="selectWorkout(workout)"
      >
        <v-card-item>
          <v-card-title class="mb-2">
            {{ workout.name }}
          </v-card-title>

          <v-card-subtitle class="card-sub">
            <span
              >{{ minutesToHour(workout.start_min) }} -
              {{
                minutesToHour(workout.start_min + workout.duration_min)
              }}</span
            >{{ workout.type }}
          </v-card-subtitle>
        </v-card-item>
      </v-card>
    </div>
    <div class="workout-details" v-else>
      <div class="all-btns">
        <v-btn class="ma-2" color="green-darken-2"> SAVE </v-btn>
        <v-btn class="ma-2" color="primary" @click="closeWorkout()">
          <v-icon icon="mdi-arrow-up" start></v-icon>
          CLOSE
          <v-icon icon="mdi-arrow-up" end></v-icon>
        </v-btn>
        <v-btn class="ma-2" color="red-darken-2"> DELETE </v-btn>
      </div>
      <div class="add-workout">
        <v-autocomplete
          label="Exercices"
          :items="allExercices"
          item-title="name"
          item-value="id"
          v-model="newEx"
          variant="outlined"
        ></v-autocomplete>
        <div class="number-add">
          <v-number-input
            control-variant="split"
            inset
            :min="0"
            v-model="newExSets"
          ></v-number-input>
          <v-btn @click="addExToWorkout">
            <v-icon icon="mdi-plus"></v-icon>
          </v-btn>
        </div>
      </div>
      <v-data-table-virtual
        :headers="[
          {
            title: 'Exercice',
            key: 'id_exercice',
            value: (item) => `${getExerciceByName(item.id_exercice).name}`,
          },
          { title: 'Sets', key: 'sets_number' },
          { title: 'Order', key: 'the_order' },
          { title: 'Actions', key: 'actions', sortable: false },
        ]"
        :items="selected.allExTODO"
        :sort-by="[{ key: 'the_order', order: 'asc' }]"
      >
        <template v-slot:item.actions="{ item }">
          <div class="actions">
            <div class="change-order">
              <v-icon size="small" @click="console.log('move up')">
                mdi-arrow-up
              </v-icon>
              <v-icon size="small" @click="console.log('move down')">
                mdi-arrow-down
              </v-icon>
            </div>
            <v-icon
              size="small"
              @click="console.log('delete')"
              color="red-darken-2"
            >
              mdi-delete
            </v-icon>
          </div>
        </template>
      </v-data-table-virtual>
      <p>Edit nom workout, temps, etc..</p>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "WorkoutsHome",
  data() {
    return {
      selectedDate: new Date(),
      allWorkouts: [],
      allExercices: [],

      selected: {
        show: false,
        id: null,
        allExTODO: [],
      },

      newEx: null,
      newExSets: 3,
    };
  },
  async mounted() {
    this.getCurentDateWorkouts();
    await axios
      .get("https://modu-api.dorian-faure.fr/exercices")
      .then((response) => response.data)
      .then((data) => {
        this.allExercices = data;
      });
  },
  methods: {
    async getCurentDateWorkouts() {
      this.allWorkouts = [];
      await axios
        .get(
          `https://modu-api.dorian-faure.fr/workouts?id_user=${this.$cookies.get(
            "id_user"
          )}&the_date=${this.formatDateToYYYYMMDD(this.selectedDate)}`
        )
        .then((response) => response.data)
        .then((data) => {
          this.allWorkouts = data;
        });
    },
    async addExToWorkout() {
      if (this.newExSets === null || this.newExSets < 1) return;
      if (this.newEx === null || this.newEx === undefined) return;

      await axios
        .get("https://modu-api.dorian-faure.fr/next_workout_exercices_id")
        .then((response) => response.data)
        .then((data) => {
          console.log(data);
          let exo = this.getExerciceByName(this.newEx);
          let order =
            this.selected.allExTODO[this.selected.allExTODO.length - 1]
              .the_order + 1;

          this.selected.allExTODO.push({
            id_exercice: exo.id,
            sets_number: this.newExSets,
            the_order: order,
          });

          let data = {
            id_exercice: this.newEx,
            id_workout: this.selected.id,
            sets_number: this.newExSets,
            notes: "nothing for now",
            the_order: order,
          };

          axios
            .post("https://modu-api.dorian-faure.fr/workout_exercices", data)
            .then((response) => {
              console.log("Exercice linked successfully:", response.data);
            })
            .catch((error) => {
              console.error("Error linking exercice:", error);
            });
        });
    },
    async removeExToWorkout(id) {
      if (id === undefined || id === null) {
        return;
      }

      await axios
        .delete(`https://modu-api.dorian-faure.fr/workout_exercices/` + id)
        .then((response) => {
          console.log("Link deleted successfully:", response.data);
        })
        .catch((error) => {
          console.error("Error deleting link:", error);
        });

      let updated = this.selected.allExTODO.filter((x) => {
        return x.id != id;
      });
      this.selected.allExTODO = updated;
    },

    async selectWorkout(workout) {
      this.selected.show = true;
      this.selected.id = workout.id;

      await axios
        .get("https://modu-api.dorian-faure.fr/workout_exercices/" + workout.id)
        .then((response) => response.data)
        .then((data) => {
          this.selected.allExTODO = data;
        });
    },
    getExerciceByName(id) {
      return this.allExercices.find((ex) => ex.id === id);
    },
    closeWorkout() {
      this.selected.show = false;
      this.selected.id = null;
      this.selected.allExTODO = [];
    },
    minutesToHour(integer) {
      // Calculate hours
      var hours = Math.floor(parseInt(integer) / 60);
      // Calculate minutes
      var minutes = integer % 60;

      // Format hours and minutes
      var hourString = hours < 10 ? "0" + hours : hours.toString();
      var minuteString = minutes < 10 ? "0" + minutes : minutes.toString();

      // Concatenate hours and minutes
      var timeString = hourString + ":" + minuteString;

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
      this.getCurentDateWorkouts();
      this.closeWorkout();
    },
    getNextDate() {
      const newDate = new Date(this.selectedDate);
      newDate.setDate(newDate.getDate() + 1);
      this.selectedDate = newDate;
      this.getCurentDateWorkouts();
      this.closeWorkout();
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

.list-workouts {
  overflow-y: auto;
  height: 485px;

  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  align-items: center;
  gap: 1rem;
}

.header {
  width: 100%;
  background: #1976d2;

  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  padding: 0 0 10px 0;
}

.date {
  display: flex;
  width: 300px;
  justify-content: space-between;
  align-items: center;
  font-size: 1.2rem;
}

.card-sub {
  display: flex;
  justify-content: space-between;
}

.workout-details {
  overflow-y: auto;
  height: 485px;

  display: flex;
  flex-direction: column;
  justify-content: start;
  align-items: center;
  gap: 1rem;
}

.all-btns .v-btn {
  width: 120px;
}

.add-workout {
  width: 100%;
}

.number-add {
  width: 100%;
  display: flex;
  gap: 1rem;

  padding-top: 10px;
  position: relative;
  border-top: 1px solid #6c6c6c;
}

.number-add::before {
  content: "Nombre de sets et ajout";
  display: block;
  position: absolute;
  top: -12px;
  left: 50%;
  transform: translateX(-50%);
  font-size: 0.85rem;
  background: #121212;
  padding: 0 15px;
}

.number-add .v-number-input,
.number-add .v-btn {
  width: 150px !important;
  height: 56px;
}

.actions {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 15px;
}

.change-order {
  display: flex;
  flex-direction: column;
  gap: 7px;
}
</style>
