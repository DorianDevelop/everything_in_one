<template>
    <div class="wrapper">
        <div class="header">
            <div class="date">
                <v-btn class="ma-2" color="white" @click="getPreviousDate" icon="mdi-arrow-left" variant="text">
                </v-btn>
                <p>{{ formatDate(selectedDate) }}</p>
                <v-btn class="ma-2" color="white" @click="getNextDate" icon="mdi-arrow-right" variant="text">
                </v-btn>
            </div>

            <v-btn color="primary">
                Ajouter workout
            </v-btn>
        </div>
        <div class="list-workouts" v-if="!selected.show">
            <v-card v-for="workout in allWorkouts" :key="workout.id" class="mx-auto" width="380" hover
                @click="selectWorkout(workout)">
                <v-card-item>
                    <v-card-title class="mb-2">
                        {{ workout.name }}
                    </v-card-title>

                    <v-card-subtitle class="card-sub">
                        <span>{{ minutesToHour(workout.start_min) }} - {{ minutesToHour(workout.start_min +
                            workout.duration_min)
                            }}</span>{{ workout.type }}
                    </v-card-subtitle>
                </v-card-item>
            </v-card>
        </div>
        <div class="workout-details" v-else>
            <div class="all-btns">
                <v-btn class="ma-2" color="green-darken-2">
                    SAVE
                </v-btn>
                <v-btn class="ma-2" color="primary" @click="closeWorkout()">
                    <v-icon icon="mdi-arrow-up" start></v-icon>
                    CLOSE
                    <v-icon icon="mdi-arrow-up" end></v-icon>
                </v-btn>
                <v-btn class="ma-2" color="red-darken-2">
                    DELETE
                </v-btn>
            </div>
            <div class="add-workout">

                <v-autocomplete label="Exercices" :items="allExercices" item-title="name" item-value="id"
                    v-model="newExercices" variant="outlined"></v-autocomplete>
                <div class="number-add">
                    <v-number-input control-variant="split" inset></v-number-input>
                    <v-btn>
                        <v-icon icon="mdi-plus"></v-icon>
                    </v-btn>
                </div>
            </div>
            <p>Liste des exos</p>
            <p>Edit nom workout, temps, etc..</p>
        </div>
    </div>
</template>

<script>
import axios from 'axios';

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
            },

            newExercices: []
        };
    },
    async mounted() {
        this.getCurentDateWorkouts();
        await axios
            .get("https://modu-api.dorian-faure.fr/exercices")
            .then((response) => response.data)
            .then((data) => {
                this.allExercices = data
            });
    },
    methods: {
        async getCurentDateWorkouts() {

            this.allWorkouts = [];
            console.log(`https://modu-api.dorian-faure.fr/workouts?id_user=${this.$cookies.get("id_user")}&the_date=${this.formatDateToYYYYMMDD(this.selectedDate)}`);
            await axios
                .get(
                    `https://modu-api.dorian-faure.fr/workouts?id_user=${this.$cookies.get("id_user")}&the_date=${this.formatDateToYYYYMMDD(this.selectedDate)}`
                )
                .then((response) => response.data)
                .then((data) => {
                    console.log(data);
                    this.allWorkouts = data;
                });
        },
        selectWorkout(workout) {
            this.selected.show = true;
            this.selected.id = workout.id;
        },
        closeWorkout() {
            this.selected.show = false;
            this.selected.id = null;
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
            const month = String(date.getMonth() + 1).padStart(2, '0'); // Adding 1 because getMonth() returns zero-based index
            const day = String(date.getDate()).padStart(2, '0');
            return `${year}-${month}-${day}`;
        },
        getPreviousDate() {
            const newDate = new Date(this.selectedDate);
            newDate.setDate(newDate.getDate() - 1);
            this.selectedDate = newDate;
            this.getCurentDateWorkouts();
        },
        getNextDate() {
            const newDate = new Date(this.selectedDate);
            newDate.setDate(newDate.getDate() + 1);
            this.selectedDate = newDate;
            this.getCurentDateWorkouts();
        },
        formatDate(date) {
            const daysOfWeek = ["Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi"];
            const months = ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"];

            const day = daysOfWeek[date.getDay()];
            const d = date.getDate();
            const month = months[date.getMonth()];

            return `${day} - ${d} ${month}`;
        }
    }
}
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
    background: #1976D2;

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
}

.number-add .v-number-input,
.number-add .v-btn {
    width: 150px !important;
    height: 56px;
}
</style>
