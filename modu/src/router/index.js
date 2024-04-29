import { createRouter, createWebHistory } from "vue-router";

import * as Views from "@/views";

const routes = [
  {
    path: "/",
    name: "Home",
    component: Views.LoginHome,
  },
  {
    path: "/diet",
    name: "Diet",
    children: [
      { path: "home", name: "DietHome", component: Views.DietHome },
      {
        path: "schedules",
        name: "DietSchedules",
        component: Views.DietSchedules,
      },
      { path: "stats", name: "DietStats", component: Views.DietStats },
    ],
  },
  {
    path: "/workouts",
    name: "Workouts",
    children: [
      { path: "home", name: "WorkoutsHome", component: Views.WorkoutsHome },
      {
        path: "schedules",
        name: "WorkoutsSchedules",
        component: Views.WorkoutsSchedules,
      },
      { path: "stats", name: "WorkoutsStats", component: Views.WorkoutsStats },
      {
        path: "exercices",
        name: "WorkoutsExercices",
        component: Views.WorkoutsExercices,
      },
    ],
  },
  {
    path: "/hours",
    name: "Hours",
    children: [{ path: "", name: "HoursMenu", component: Views.HoursMenu }],
  },
  {
    path: "/notes",
    name: "Notes",
    children: [
      { path: "", name: "NotesList", component: Views.NotesList },
      {
        path: "details/:id",
        name: "NotesDetails",
        component: Views.NotesDetails,
      },
    ],
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

function getCookie(cname) {
  let name = cname + "=";
  let decodedCookie = decodeURIComponent(document.cookie);
  let ca = decodedCookie.split(";");
  for (let i = 0; i < ca.length; i++) {
    let c = ca[i];
    while (c.charAt(0) == " ") {
      c = c.substring(1);
    }
    if (c.indexOf(name) == 0) {
      return c.substring(name.length, c.length);
    }
  }
  return "";
}

router.beforeEach((to, from, next) => {
  const id_user = getCookie("id_user"); // Assuming you have a function to get cookies
  console.log(id_user);

  if (to.path !== "/" && (!id_user || id_user === "null")) {
    next({ path: "/" }); // Redirect to "/" if id_user cookie is not defined or null
  } else {
    next(); // Proceed to the next route
  }
});

export default router;
