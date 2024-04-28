<template>
  <div class="list">
    <v-btn icon="mdi-plus" variant="elevated" to="/notes/details/-1"> </v-btn>
    <v-card v-for="i in notes" :key="i.id" :title="i.title" :subtitle="i.description"
      :to="'/notes/details/' + i.id"></v-card>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "NotesList",
  data: () => ({
    notes: [],
  }),
  mounted() {
    axios
      .get("http://modu-api:3001/notes/" + this.$cookies.get("id_user"))
      .then((response) => response.data)
      .then((data) => (this.notes = data));
  },
};
</script>

<style scoped>
.list {
  display: flex;
  flex-direction: column;
  gap: 5px;
  padding: 5px;
}

.list .v-btn {
  align-self: center;
  margin: 5px 0;
}
</style>