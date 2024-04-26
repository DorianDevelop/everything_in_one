<template>
  <div class="wrapper">
    <div class="btn_icons">
      <v-btn icon="mdi-arrow-left" variant="elevated" to="/notes" @click="saveNote">
      </v-btn>
      <v-btn icon="mdi-trash-can" bg-color="red" variant="elevated" color="red-darken-4" to="/notes"
        @click="deleteNote">
      </v-btn>
    </div>
    <v-text-field hide-details="auto" placeholder="Titre" v-model="note.title"></v-text-field>
    <v-textarea placeholder="Titre" :clearable="true" :no-resize="true" rounded="0" rows="19"
      v-model="note.description"></v-textarea>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "NotesDetails",
  data: () => ({
    note: { title: "", description: "" },
    saving: false,
  }),
  mounted() {
    const id = this.$route.params.id;
    if (id == -1) return;

    axios
      .get("http://localhost:3000/note/" + id)
      .then((response) => response.data)
      .then((data) => (this.note = data[0]))
      .catch((error) => {
        console.error("Error getting note:", error);
      });
  },
  methods: {
    async saveNote() {
      if (this.note.id == undefined) {
        this.createNote();
        return;
      }
      const data = {
        title: this.note.title,
        description: this.note.description,
      };

      await axios
        .put("http://localhost:3000/note/" + this.note.id, data)
        .then((response) => {
          console.log("Note updated successfully:", response.data);
          this.saving = true;
        })
        .catch((error) => {
          console.error("Error updating note:", error);
        });
    },
    async createNote() {
      if (this.note.title == "" || this.note.title == undefined) return;
      const data = {
        title: this.note.title,
        description: this.note.description,
      };

      await axios
        .post("http://localhost:3000/note/1", data)
        .then((response) => {
          console.log("Note updated successfully:", response.data);
          this.saving = true;
        })
        .catch((error) => {
          console.error("Error updating note:", error);
        });
    },
    async deleteNote() {
      if (this.note.id == undefined) {
        return;
      }

      await axios
        .delete("http://localhost:3000/note/" + this.note.id)
        .then((response) => {
          console.log("Note updated successfully:", response.data);
          this.saving = true;
        })
        .catch((error) => {
          console.error("Error updating note:", error);
        });
    }
  },
  beforeRouteLeave(to, from, next) {
    if (this.saving) {
      next(false);
    } else {
      next();
    }
  },
};
</script>

<style>
.wrapper {
  padding: 0 5px;
}

.wrapper .btn_icons {
  padding: 10px 50px;
  width: 100%;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>
