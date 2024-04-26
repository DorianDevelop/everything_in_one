import { createRouter, createWebHistory } from "vue-router";

import * as Views from "@/views";

const routes = [
  {
    path: "/",
    name: "Home",
    component: Views.HomePage,
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

export default router;
