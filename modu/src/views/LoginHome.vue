<template>
    <div class="wrapper">
        <v-card class="mx-auto px-6 py-8" v-if="!connected">
            <v-form>
                <v-text-field v-model="pseudo_name" class="mb-2" label="Nom / Pseudo" clearable
                    :messages="user_message"></v-text-field>

                <br>

                <v-btn color="success" type="submit" size="large" variant="elevated" block @click="login">
                    Se connecter
                </v-btn>
            </v-form>
        </v-card>
        <v-btn color="warning" class="mt-15" variant="elevated" @click="signup" v-if="!connected">
            Créer compte
        </v-btn>
        <p v-if="connected">Bonjour, <br /> <span>{{ pseudo_name }}</span></p>

        <v-btn color="red-accent-4" class="mt-15" variant="elevated" @click="logout" v-if="connected">
            Se déconnecter
        </v-btn>
    </div>
</template>

<script>
import axios from "axios";

export default {
    name: "LoginHome",
    data: () => ({ pseudo_name: '', user_message: "", connected: false }),
    mounted() {
        let id = this.$cookies.get("id_user");
        if (id === undefined || id === null || id < 0) {
            this.logout();
        } else {
            this.pseudo_name = this.$cookies.get("pseudo");
            this.connected = true;
        }
    },
    methods: {
        async login() {
            if (this.pseudo_name === '' || this.pseudo_name === undefined || this.pseudo_name.length <= 0) return;

            await axios
                .get("https://modu-api.dorian-faure.fr/login/" + this.pseudo_name)
                .then((response) => {
                    if (response.data.length === 0) {
                        this.user_message = "L'utilisateur n'exsite pas.";
                        return;
                    }
                    this.user_message = "";
                    this.connected = true;
                    this.$cookies.set("pseudo", this.pseudo_name);
                    this.$cookies.set("id_user", response.data[0].id);
                })
        },

        async signup() {
            if (this.pseudo_name === '' || this.pseudo_name === undefined || this.pseudo_name.length <= 0) return;
            const result = confirm("Es-tu sure de vouloir créer un compte ?");
            if (!result) return;

            await axios
                .get("https://modu-api.dorian-faure.fr/login/" + this.pseudo_name)
                .then((response) => {
                    if (response.data.length !== 0) {
                        this.user_message = "L'utilisateur existe déjà.";
                        return;
                    }
                    this.user_message = "";

                    const data = {
                        pseudo: this.pseudo_name
                    }

                    axios
                        .post("https://modu-api.dorian-faure.fr/signup", data)
                        .then((response) => {
                            console.log("User successfully created:", response.data);
                        })
                        .catch((error) => {
                            console.error("Error creating user:", error);
                        });
                })
        },

        async logout() {
            this.pseudo_name = "";
            this.connected = false;
            this.user_message = "";
            this.$cookies.remove("pseudo")
            this.$cookies.remove("id_user")
        },
    }
}
</script>

<style scoped>
.wrapper {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
}

p {
    font-size: 2.5rem;
    text-align: center;
}

p span {
    font-size: 3rem;
    font-weight: bold;
    color: #673AB7;
}
</style>