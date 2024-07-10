import Vue from 'vue'
import VueRouter from 'vue-router'
import HomeView from '../views/HomeView.vue'
import LoginView from "@/views/LoginView.vue";
import RoleView from "@/views/RoleView.vue";
import AdminView from "@/views/AdminView.vue";
import LayoutView from "@/views/Layout.vue";
import LogView from "@/views/LogView.vue";
import PermissionView from "@/views/PermissionView.vue";
import NoticeView from "@/views/NoticeView.vue";

Vue.use(VueRouter)

const routes = [

  {
    path: '/login',
    name: 'Login',
    component: LoginView
  },
  {
    path: '/',
    name: '',
    component: LayoutView,
    redirect: '/login',
    meta:{title:''},
    children: [
      {
        path: '',
        name: 'home',
        component: HomeView,
        meta:{title:'系统首页'},
      },
      {
        path: '/role',
        name: 'role',
        component: RoleView,
        meta: {title: '角色管理'}
      },
      {
        path: '/admin',
        name: 'admin',
        component: AdminView,
        meta: {title: '用户管理'}
      },
      {
        path: '/permission',
        name: 'permission',
        component: PermissionView,
        meta: {title: '权限管理'}
      },
      {
        path: '/log',
        name: 'log',
        component: LogView,
        meta: {title: '日志管理'}
      },
      {
        path: '/notice',
        name: 'notice',
        component: NoticeView,
        meta: {title: '系统公告'}
      },
    ]
  },
]
const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

// 在每次路由跳转之前都会执行这个函数
router.beforeEach((to,from,next) => {
  // 如果目标路径是登录页面，则直接跳过
  if (to.path === 'login') {
    next();
  }
  // 从本地存储中获取管理员身份
  const admin = localStorage.getItem("admin");
  // 如果admin身份不存在，并且不是登录页面，则跳转到登录页面
  if(!admin && to.path !== '/login') {
    return next("/login");
  }
  // 如果 admin 数据存在，或者即将跳转的路径是 '/login'，则放行
  next();
})

export default router
