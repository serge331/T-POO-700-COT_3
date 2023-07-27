import { createRouter, createWebHistory } from "vue-router";
import LoginView from "../components/Login.vue";
import RegisteryView from "../components/Registery.vue";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "login",
      component: LoginView,
    },
    {
      path: "/registery",
      name: "registery",
      component: RegisteryView,
    },
    {
      path: "/dashboard",
      component: () => import('@/layout/dashboard.vue'),
      children: [
        {
          path: "/dashboard",
          component: () => import('@/components/ChartManager.vue'),
          name: "ChartManager"
        },
        {
          path: "/dashboard/teams",
          component: () => import('@/components/User.vue'),
          name: "user"
        },
        {
          path: "/dashboard/history",
          component: () => import('@/components/WorkingTime.vue'),
          name: "WorkingTime"
        },
        {
          path: "/dashboard/times",
          component: () => import('@/components/ClockManager.vue'),
          name: "ClockManager"
        },
        {
          path: "/dashboard/account",
          component: () => import('@/components/Account.vue'),
          name: "account"
        },
        {
          path: "/dashboard/settings",
          component: () => import('@/components/'),
          name: "settings"
        }
      ] 

    }
  
  ],
});

export default router;
