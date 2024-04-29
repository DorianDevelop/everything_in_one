<template>
  <div class="list">
    <v-btn icon="mdi-plus" variant="elevated" to="/notes/details/-1"> </v-btn>
    <v-card
      v-for="i in notes"
      :key="i.id"
      :title="i.title"
      :subtitle="i.description"
      :to="'/notes/details/' + i.id"
    ></v-card>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "NotesList",
  data: () => ({
    notes: [],
  }),
  async mounted() {
    await setTimeout(() => {
      axios
        .get(
          "https://modu-api.dorian-faure.fr/notes/" +
            this.$cookies.get("id_user")
        )
        .then((response) => response.data)
        .then((data) => (this.notes = data));
    }, 100); // Wait for 100 milliseconds (i.e., 0.1 second)
  },
};
</script>

<style scoped>
.list {
  display: flex;
  flex-direction: column;
  gap: 5px;
  padding: 5px 10px;
}

.list .v-btn {
  align-self: center;
  margin: 5px 0;
}
</style>
