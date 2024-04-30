<template>
  <div class="wrapper">
    <v-col v-for="exercice in allExercices" :key="exercice.id">
      <v-card color="blue-darken-2" variant="tonal" class="card">
        <v-card-item>
          <div>
            <img
              :src="
                exercice.online_image !== 'UUUUUUUUUUUUUU' &&
                exercice.online_image !== ''
                  ? exercice.online_image
                  : 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Blank_Square.svg/1024px-Blank_Square.svg.png'
              "
              :alt="exercice.online_image"
            />

            <div class="text-overline mb-1">
              {{ exercice.name }}
            </div>
          </div>
        </v-card-item>
        <v-dialog max-width="600">
          <template v-slot:activator="{ props: activatorProps }">
            <v-btn
              v-bind="activatorProps"
              color="blue-darken-2"
              :text="exercice.id === -1 ? 'CRÉER' : 'MODIFIER'"
              variant="outlined"
              @click="getExerciceMuscleLink(exercice.id)"
            ></v-btn>
          </template>

          <template v-slot:default="{ isActive }">
            <v-card>
              <div class="dialog-details">
                <v-text-field
                  hide-details="auto"
                  placeholder="Développé couché"
                  label="Exercice Name"
                  rounded="0"
                  v-model="exercice.name"
                ></v-text-field>
                <v-text-field
                  placeholder="https://image_exercice.jpg"
                  label="Exercice Image URL"
                  rounded="0"
                  v-model="exercice.online_image"
                ></v-text-field>
                <div class="selects">
                  <v-select
                    label="Groupes musculaires"
                    :items="allMuscles"
                    item-title="muscle_group"
                    item-value="id"
                    multiple
                    v-model="newLink.muscles"
                    variant="outlined"
                    :disabled="exercice.id === -1"
                  ></v-select>
                  <v-select
                    label="Rôles"
                    :items="allRoles"
                    item-title="label"
                    item-value="value"
                    v-model="newLink.role"
                    variant="outlined"
                    :disabled="exercice.id === -1"
                  ></v-select>
                </div>
                <v-btn
                  :disabled="exercice.id === -1"
                  text="Ajout groupe"
                  color="green-darken-2"
                  class="ajout-btn"
                  @click="saveExerciceMuscleLink(exercice.id)"
                ></v-btn>
                <v-data-table
                  :headers="[
                    {
                      title: 'Muscles',
                      key: 'id_muscle',
                      value: (item) =>
                        `${muscleById(item.id_muscle).muscle_group}`,
                    },
                    { title: 'Role', key: 'role' },
                    { title: 'Actions', key: 'actions', sortable: false },
                  ]"
                  :items="allExerciceMuscles"
                  :sort-by="[{ key: 'role', order: 'desc' }]"
                  v-if="allExerciceMuscles.length > 0"
                >
                  <template v-slot:item.actions="{ item }">
                    <v-icon
                      size="small"
                      @click="
                        deleteExerciceMuscleLink(
                          item.id_exercice,
                          item.id_muscle
                        )
                      "
                    >
                      mdi-delete
                    </v-icon>
                  </template>
                </v-data-table>
              </div>
              <v-card-actions class="actions">
                <v-btn
                  text="Save"
                  color="green-darken-2"
                  @click="
                    () => {
                      isActive.value = false;
                      saveExercice(exercice);
                    }
                  "
                ></v-btn>
                <v-btn
                  text="Close"
                  color="gray-darken-2"
                  @click="isActive.value = false"
                ></v-btn>
                <v-btn
                  text="Delete"
                  color="red-darken-2"
                  @click="
                    () => {
                      isActive.value = false;
                      deleteExercice(exercice.id);
                    }
                  "
                ></v-btn>
              </v-card-actions>
            </v-card>
          </template>
        </v-dialog>
      </v-card>
    </v-col>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "WorkoutsExercices",
  data: () => ({
    allExercices: [],
    allMuscles: [],
    selectedExercice: null,
    allExerciceMuscles: [],
    allRoles: [
      { label: "4 : Isolation", value: 4 },
      { label: "3 : Principalement entrainé", value: 3 },
      { label: "2 : Entrainé avec", value: 2 },
      { label: "1 : Un peu touché", value: 1 },
      { label: "0 : Aucune idée", value: 0 },
    ],
    newLink: {
      muscles: [],
      role: 0,
    },
  }),
  async mounted() {
    await this.loadAllExercices();
    await axios
      .get("https://modu-api.dorian-faure.fr/muscles")
      .then((response) => response.data)
      .then((data) => {
        this.allMuscles = data;
      });
  },
  methods: {
    async loadAllExercices() {
      this.allExercices = [];
      await axios
        .get("https://modu-api.dorian-faure.fr/exercices")
        .then((response) => response.data)
        .then((data) => {
          this.allExercices.push({
            id: -1,
            name: "NEW",
            online_image: "",
          });
          data.forEach((e) => {
            this.allExercices.push(e);
          });
        });
    },
    async saveExercice(exercice) {
      if (exercice.id === undefined) return;
      if (exercice.id === -1) {
        this.createExercice(exercice);
        return;
      }
      let data = {
        name: exercice.name,
        online_image: exercice.online_image,
      };

      await axios
        .put("https://modu-api.dorian-faure.fr/exercice/" + exercice.id, data)
        .then((response) => {
          console.log("Exercice updated successfully:", response.data);
        })
        .catch((error) => {
          console.error("Error updating exercice:", error);
        });
    },
    async createExercice(exercice) {
      let data = {
        name: exercice.name,
        online_image: exercice.online_image,
      };

      await axios
        .post("https://modu-api.dorian-faure.fr/exercice", data)
        .then((response) => {
          console.log("Exercice created successfully:", response.data);
          this.loadAllExercices();
        })
        .catch((error) => {
          console.error("Error creating exercice:", error);
        });
    },
    async getExerciceMuscleLink(exercice_id) {
      await axios
        .get("https://modu-api.dorian-faure.fr/exercice_muscles/" + exercice_id)
        .then((response) => response.data)
        .then((data) => {
          this.allExerciceMuscles = data;
        });
    },
    async saveExerciceMuscleLink(exercice_id) {
      if (exercice_id === undefined || exercice_id === -1) return;
      await this.newLink.muscles.forEach((muscle) => {
        let data = {
          id_exercice: exercice_id,
          id_muscle: muscle,
          role: this.newLink.role,
        };
        axios
          .post("https://modu-api.dorian-faure.fr/exercice_muscles/", data)
          .then((response) => {
            console.log("Link created successfully:", response.data);
          })
          .catch((error) => {
            console.error("Error updating links:", error);
          });
        this.allExerciceMuscles.push(data);
      });
      this.newLink.muscles = [];
      this.newLink.role = 0;
    },
    muscleById(id) {
      return this.allMuscles.find((item) => item.id === id);
    },
    async deleteExerciceMuscleLink(id_exercice, id_muscle) {
      if (id_exercice == undefined || id_muscle == undefined) {
        return;
      }

      await axios
        .delete(
          `https://modu-api.dorian-faure.fr/exercice_muscles?id_exercice=${id_exercice}&id_muscle=${id_muscle}`
        )
        .then((response) => {
          console.log("Link deleted successfully:", response.data);
        })
        .catch((error) => {
          console.error("Error deleting link:", error);
        });

      this.getExerciceMuscleLink(id_exercice);
    },
    async deleteExercice(exercice_id) {
      await axios
        .delete("https://modu-api.dorian-faure.fr/exercice/" + exercice_id)
        .then((response) => {
          console.log("Exercice deleted successfully:", response.data);
          this.loadAllExercices();
        })
        .catch((error) => {
          console.error("Error deleting ex:", error);
        });
    },
  },
};
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
  width: 100px;
  height: 100px;
  object-fit: cover;
}

.selects {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 0.5rem;
}

.selects .v-select {
  width: 45%;
}

.ajout-btn {
  display: block;
  margin: 0.5rem auto 1rem auto;
}

.dialog-details {
  padding: 0.8rem;
}
</style>
