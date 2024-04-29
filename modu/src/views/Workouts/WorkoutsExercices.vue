<template>
    <div class="wrapper">
        <v-col v-for="exercice in allExercices" :key="exercice.id">
            <v-card color="blue-darken-2" variant="tonal" class="card">
                <v-card-item>
                    <div>
                        <img :src="exercice.online_image !== 'UUUUUUUUUUUUUU' && exercice.online_image !== '' ? exercice.online_image : 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Blank_Square.svg/1024px-Blank_Square.svg.png'"
                            :alt="exercice.online_image">

                        <div class="text-overline mb-1">
                            {{ exercice.name }}
                        </div>
                    </div>
                </v-card-item>
                <v-dialog max-width="600">
                    <template v-slot:activator="{ props: activatorProps }">
                        <v-btn v-bind="activatorProps" color="blue-darken-2" text="Open Dialog"
                            variant="outlined"></v-btn>
                    </template>

                    <template v-slot:default="{ isActive }">
                        <v-card>
                            <div class="dialog-details">
                                <v-text-field hide-details="auto" placeholder="Développé couché" label="Exercice Name"
                                    rounded="0" v-model="exercice.name"></v-text-field>
                                <v-text-field placeholder="https://image_exercice.jpg" label="Exercice Image URL"
                                    rounded="0" v-model="exercice.online_image"></v-text-field>
                            </div>
                            <v-card-actions class="actions">
                                <v-btn text="Save" color="green-darken-2" @click="isActive.value = false"></v-btn>
                                <v-btn text="Close" color="gray-darken-2" @click="isActive.value = false"></v-btn>
                                <v-btn text="Delete" color="red-darken-2" @click="isActive.value = false"></v-btn>
                            </v-card-actions>
                        </v-card>
                    </template>
                </v-dialog>
            </v-card>

        </v-col>

    </div>

</template>

<script>
import axios from 'axios';

export default {
    name: "WorkoutsExercices",
    data: () => ({
        allExercices: [],
    }),
    async mounted() {
        await axios
            .get(
                "https://modu-api.dorian-faure.fr/exercices"
            )
            .then((response) => response.data)
            .then((data) => {
                data.forEach((e) => {
                    let temp = e;
                    temp['isActive'] = false;
                    this.allExercices.push(temp)
                });
            })
    },
    getImageLink(exercice) {
        return exercice.onlie_image;
    }
}
</script>
<style scoped>
.wrapper {
    display: flex;
    gap: 1rem;
    justify-content: space-evenly;
    align-items: center;
    flex-direction: row;
    flex-wrap: wrap;

    padding: 1rem 5rem;
    max-height: calc(100vh - 100px);
    overflow-y: auto;
}

.dialog-details {
    padding: 0 0 1rem 0;
}

.actions {
    display: flex;
    width: 100%;
    justify-content: space-evenly;
}

.actions .v-btn {
    width: 25%;
}

.card {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: space-between;
    padding: 0.5rem;
    padding-bottom: 1rem;
    width: 200px;
    height: 230px;
    font-size: 14px;
    text-align: center;
}

.card .text-overline {
    line-height: 1.5;
    max-height: 40px;
    margin: 5px 0;
}


.card img {
    max-height: 100px;
    max-width: 100px;
}
</style>