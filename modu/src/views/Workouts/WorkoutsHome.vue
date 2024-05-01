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
        </div>
        <p>{{ allWorkouts }}</p>
    </div>
</template>

<script>
export default {
    name: "WorkoutsHome",
    data() {
        return {
            selectedDate: new Date(),
            allWorkouts: [],
        };
    },
    mounted() {
        this.getCurentDateWorkouts();
    },
    methods: {
        async getCurentDateWorkouts() {

            this.allWorkouts = [];
            await axios
                .get(
                    `https://modu-api.dorian-faure.fr/exercice_muscles?id_user=${this.$cookies.get("id_user")}&the_date=${this.selectedDate}`
                )
                .then((response) => response.data)
                .then((data) => {
                    this.allWorkouts = data;
                });
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
    justify-content: space-between;
    gap: 1rem;
}

.header {
    height: 100px;
    width: 100%;
    background: #1976D2;

    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
}

.date {
    display: flex;
    width: 300px;
    justify-content: space-between;
    align-items: center;
    font-size: 1.2rem;
}
</style>
