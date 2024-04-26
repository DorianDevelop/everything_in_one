<template>
    <div class="wrapper">
        <div class="hours">
            <h1>{{ minutesToHour(totalHours) }}</h1>
            <h3>{{ minutesToHour(hourDone) }}</h3>
            <div class="list">
                <p v-for="h in listHours" :key="h">{{ minutesToHour(h) }}</p>
            </div>
        </div>
        <v-btn color="green-darken-2" size="large" variant="outlined" @click="addNewHour(-1)">
            Badger
        </v-btn>
        <v-btn color="green-darken-2" size="small" @click="deleteLastHour">
            Supprimer
        </v-btn>
        <div class="inputs">
            <v-number-input :reverse="false" controlVariant="stacked" :hideInput="false" inset variant="outlined"
                :max="36" :min="-1" v-model="newTimeHour"></v-number-input>
            <v-number-input :reverse="true" controlVariant="stacked" :hideInput="false" inset variant="outlined"
                :max="60" :min="-1" v-model="newTimeMinute"></v-number-input>
        </div>
        <v-btn color="green-darken-2" size="small" variant="outlined"
            @click="addNewHour(newTimeHour * 60 + newTimeMinute)">
            Ajouter
        </v-btn>
        <v-btn color="green-darken-2" size="small" @click="deleteAllHours">
            Reinitialiser
        </v-btn>
    </div>
</template>

<script>
import axios from "axios";

export default {
    name: "HoursMenu",
    data: () => ({
        totalHours: 2160,
        hourDone: 0,
        listHours: [],
        newTimeHour: 0,
        newTimeMinute: 0
    }),
    async mounted() {
        await axios
            .get("http://localhost:3000/hours/1")
            .then((response) => response.data)
            .then((data) => {
                data.forEach(e => {
                    this.listHours.push(e.input_hour)
                });
            }).finally(
                () => {
                    this.refreshHours();
                }
            );
    },
    methods: {
        minutesToHour(integer) {
            // Calculate hours
            var hours = Math.floor(integer / 60);
            // Calculate minutes
            var minutes = integer % 60;

            // Format hours and minutes
            var hourString = hours < 10 ? '0' + hours : hours.toString();
            var minuteString = minutes < 10 ? '0' + minutes : minutes.toString();

            // Concatenate hours and minutes
            var timeString = hourString + ':' + minuteString;

            return timeString;
        },
        addNewHour(time) {
            if (this.listHours.length >= 20) return;
            if (time !== -1) {
                if ((this.listHours.length - 2) % 4 == 0 && time - this.listHours[this.listHours.length - 1] < 45) {
                    this.listHours.push(this.listHours[this.listHours.length - 1] + 45)
                    this.saveNewHour(this.listHours[this.listHours.length - 1] + 45)
                    return;
                } else {
                    this.listHours.push(Math.round(time))
                    this.saveNewHour(Math.round(time))
                    return;
                }
            } else {
                this.listHours.push(this.getCurrentTimeInMinutes());
                this.saveNewHour(this.getCurrentTimeInMinutes())
                return;
            }
        }, getCurrentTimeInMinutes() {
            var currentDate = new Date();
            var currentHour = currentDate.getHours();
            var currentMinutes = currentDate.getMinutes();
            var totalMinutes = currentHour * 60 + currentMinutes;
            return totalMinutes;
        },
        refreshHours() {
            let sum = 0;
            for (let i = 1; i < this.listHours.length; i++) {
                if (i % 2 == 1) {
                    let t = (this.listHours[i] - this.listHours[i - 1]);
                    sum += t > 0 ? t : 0;
                }
            }
            this.hourDone = sum;
        },
        async saveNewHour(hour) {
            const data = {
                input_hour: hour,
            };

            await axios
                .post("http://localhost:3000/hour/1", data)
                .then((response) => {
                    console.log("Note updated successfully:", response.data);
                    this.saving = true;
                })
                .catch((error) => {
                    console.error("Error updating note:", error);
                });
            this.refreshHours()
        },
        async deleteLastHour() {
            this.listHours.pop();

            await axios
                .delete("http://localhost:3000/hour/1")
                .then((response) => {
                    console.log("Note updated successfully:", response.data);
                    this.saving = true;
                })
                .catch((error) => {
                    console.error("Error updating note:", error);
                });

            this.refreshHours()
        },
        async deleteAllHours() {
            this.listHours = [];

            await axios
                .delete("http://localhost:3000/hours/1")
                .then((response) => {
                    console.log("Note updated successfully:", response.data);
                    this.saving = true;
                })
                .catch((error) => {
                    console.error("Error updating note:", error);
                });
            this.refreshHours()
        }
    }
}
</script>

<style scoped>
.wrapper {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 1rem;
}

.wrapper .v-btn {
    width: 70%;
}

.hours {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start;
    min-height: 250px;
}

h1 {
    font-size: 3rem;
}

h3 {
    font-size: 1.6rem;
}

.inputs {
    width: 80%;
    display: flex;
    justify-content: space-evenly;
    align-items: center;
    gap: 5px;
    margin-bottom: -20px;

}

.list {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    column-gap: 10px;
    margin-top: 10px;
    color: #388E3C;
}

.list>p:nth-child(odd) {
    color: #D32F2F;
}
</style>