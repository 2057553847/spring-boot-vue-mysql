<template>
  <div>
    <!--    头部容器-->
    <el-container>
      <!--      头部-->
      <el-header style="background-color: #0b0c0c;height: 70px">
        <img src="../../public/vue/img/mylogo.png" style="width: 50px;position: relative;top: 10px">
        <span style="font-size: 20px;margin-left: 15px;color: white">企业系统快速管理平台</span>
        <el-dropdown style="float: right;height: 60px;line-height: 60px;">
          <span class="el-dropdown-link" style="font-size: 15px;color: white">
            <span style="margin-right: 5px;color: white">欢迎您</span><i class="el-icon-user-solid"></i>{{ admin.username }}<i class="el-icon-arrow-down el-icon--right"></i>
          </span>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item>
              <div @click="update()"><i class="el-icon-edit"></i>修改信息</div>
            </el-dropdown-item>
            <el-dropdown-item>
              <div @click="edit()"><i class="el-icon-edit"></i>修改密码</div>
            </el-dropdown-item>
            <el-dropdown-item>
              <div @click="logout()"><i class="el-icon-switch-button"></i>退出登录</div>
            </el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </el-header>
      <div style="text-align: center">
        <el-dialog :visible.sync="dialogFormVisible" title="填写新密码" width="30%">
          <el-form ref="fromRef" :model="admin" :rules="rules">
            <el-form-item label="你的密码：" label-width="35%" prop="password">
              <el-input v-model="admin.password" :disabled="true" autocomplete="off" placeholder="旧密码" show-password
                        style="width: 300px;margin-right: 155px"></el-input>
            </el-form-item>
            <el-form-item label="你的新密码：" label-width="35%" prop="newPassword">
              <el-input v-model="admin.newPassword" autocomplete="off" placeholder="新密码" show-password
                        style="width: 300px;margin-right: 155px"></el-input>
            </el-form-item>
            <el-form-item label="确认你的新密码：" label-width="35%" prop="confirmPassword">
              <el-input v-model="admin.confirmPassword" autocomplete="off" placeholder="确认密码" show-password
                        style="width: 300px;margin-right: 155px"></el-input>
            </el-form-item>
          </el-form>
          <div>
            <el-button type="primary" @click="submit()">提交</el-button>
            <el-button @click="dialogFormVisible = false">取消</el-button>
          </div>
        </el-dialog>
      </div>
      <div>
        <el-dialog :visible.sync="centerDialogVisible" center title="修改你的信息" width="30%">
          <span slot="footer" class="dialog-footer">
            <el-form :model="admin">
          <el-form-item label="用户名" label-width="25%" style="margin-left: 10%">
            <el-input v-model="admin.username" autocomplete="off" style="width: 80%;margin-right: 100px"></el-input>
          </el-form-item>
          <el-form-item label="姓名" label-width="25%" style="margin-left: 10%">
            <el-input v-model="admin.name" autocomplete="off" style="width: 80%;margin-right: 100px"></el-input>
          </el-form-item>
        </el-form>
           <el-button @click="centerDialogVisible = false">取 消</el-button>
           <el-button type="primary" @click="sure()">确 定</el-button>
          </span>
        </el-dialog>
      </div>
    </el-container>
    <!--    主体容器-->
    <el-container>
      <!--      侧边栏-->
        <el-aside style="min-height: calc(100vh - 70px);overflow: hidden;" width="250px">
        <el-menu
            default-active="2"
            class="el-menu-vertical-demo"
            @open="handleOpen"
            @close="handleClose"
            background-color="#e4aaaa"
            text-color="#000000"
            active-text-color="#ffffff"
            :style="{ height: menuHeight }"
            :default-active="$route.path"
            router>
          <el-menu-item index="/">
            <img src="/vue/img/系统首页.png" style="width: 20px;margin-right: 9px">
            <span slot="title">系统首页</span>
          </el-menu-item>
          <el-submenu index="1">
            <template slot="title">
              <img src="/vue/img/用户管理.png" style="width: 20px;margin-right: 9px">
              <span>用户管理</span>
            </template>
            <el-menu-item-group>
              <el-menu-item index="/admin">用户列表</el-menu-item>
              <el-menu-item index="/log" v-if="admin.state === 'root'">系统日志</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
          <el-submenu index="2">
            <template slot="title">
              <img src="/vue/img/角色管理.png" style="width: 20px;margin-right: 9px">
              <span>角色管理</span>
            </template>
            <el-menu-item-group>
              <el-menu-item index="/role">角色列表</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
          <el-submenu index="3" v-if="admin.state === 'root'">
            <template slot="title">
              <img src="/vue/img/权限.png" style="width: 20px;margin-right: 9px">
              <span>权限管理</span>
            </template>
            <el-menu-item-group>
              <el-menu-item index="/permission">权限列表</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
          <el-submenu index="4" v-if="admin.state === 'root'">
            <template slot="title">
              <img src="/vue/img/公告.png" style="width: 20px;margin-right: 9px">
              <span>公告管理</span>
            </template>
            <el-menu-item-group>
              <el-menu-item index="/notice">系统公告</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
        </el-menu>
      </el-aside>
      <!--      主体-->
        <div class="card">
          <el-main>
            <div style="margin-bottom: 10px;">
              <el-breadcrumb style="font-size: 16px;font-weight: bold">
                <el-breadcrumb-item v-for="(item, index) in breadcrumbs" :key="index">
                  <router-link :to="item.to">{{ item.label }}</router-link>
                </el-breadcrumb-item>
              </el-breadcrumb>
            </div>
            <router-view/>
          </el-main>
        </div>
    </el-container>
  </div>
</template>
<script>
import request from "@/utils/request";
import "@/assets/css/background.css"
import "@/assets/css/svg.css"

export default {
  name: "Layout",
  computed: {
    breadcrumbs() {
      // 获取当前路由的 matched 数组，生成面包屑
      let routes = this.$route.matched;
      let breadcrumbs = routes.map(route => {
        return {
          label: route.meta.title || route.name,
          to: route.path
        };
      });
      return breadcrumbs;
    }
  },
  data() {
    const validatePassword = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('请确认密码'))
      } else if (value !== this.admin.newPassword) {
        callback(new Error('确认的密码有误'))
      } else {
        callback()
      }
    }
    return {
      roleObjs: [],
      rules: {
        password: [
          {required: true, message: '请输入原密码', trigger: 'blur'},
        ],
        newPassword: [
          {required: true, message: '请输入新密码', trigger: 'blur'},
        ],
        confirmPassword: [
          {validator: validatePassword, required: true, trigger: 'blur'},
        ],
      },
      dialogFormVisible: false,
      centerDialogVisible: false,
      admin: localStorage.getItem("admin") ? JSON.parse(localStorage.getItem("admin")) : {},
      menuHeight: 'calc(100vh - 70px)'
    }
  },
  methods: {
    sure() {
      request.post("/admin", this.admin).then(res => {
        if (res.code === '0') {
          this.$message({
            message: '信息修改成功',
            type: 'success'
          });
          this.$router.push("/login");
        } else {
          this.$message({
            message: '信息修改失败',
            type: 'error'
          })
        }
      })
    },
    update() {
      this.centerDialogVisible = true
    },
    edit() {
      this.dialogFormVisible = true;

    },
    submit() {
      this.$refs.fromRef.validate((valid) => {
        if (valid) {
          this.admin.password = this.admin.newPassword
          request.post("/admin", this.admin).then(res => {
            if (res.code === '0') {
              this.$message({
                message: '修改密码成功',
                type: 'success',
              });
              this.dialogFormVisible = false;
              this.logout()
            } else {
              this.$message({
                message: res.msg,
                type: 'error'
              });
            }
          })
        }
      })
    },
    logout() {
      localStorage.removeItem("admin");
      this.$router.push("/login");
    }
  }
}
</script>

<style scoped>
.el-menu {
  border-right: none !important;

}
div{
  font-weight: bold;
  font-size: 13px;
}
.card {
  height: calc(100vh - 70px);
}

</style>