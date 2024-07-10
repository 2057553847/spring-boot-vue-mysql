<template>
  <div>
    <div style="width: 380px;height: 300px;margin: 150px auto; border-radius: 10px;margin-top: 300px" >
      <div style="margin-top: 25px;text-align: center;height: 320px">
        <div>
          <el-form :model="admin" class="form">
            <p class="form-title">登录您的账号</p>
            <div class="input-container">
              <input v-model="admin.username" placeholder="用户名" type="email">
              <span>
            <svg stroke="currentColor" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
            </svg>
          </span>
            </div>
            <div class="input-container">
              <input v-model="admin.password" placeholder="密码" type="password">
              <span>
            <svg stroke="currentColor" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" stroke-width="2" stroke-linejoin="round" stroke-linecap="round"></path>
              <path d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" stroke-width="2" stroke-linejoin="round" stroke-linecap="round"></path>
            </svg>
          </span>
            </div>
            <button @click="login()" class="submit">登录</button>
            <p class="signup-link">
              没有账号?来注册吧
              <a href="#" @click="enroll()">注册</a>
            </p>
          </el-form>
        </div>
      </div>
    </div>
    <div style="text-align: center">
      <el-dialog :visible.sync="dialogFormVisible" title="注册新用户" width="20%" style="margin-top: 120px">
        <el-form :model="admin">
          <el-form-item label="用户名：" label-width="25%" style="margin-left: 10%">
            <el-input v-model="form.username" autocomplete="off" style="width: 80%;margin-right: 100px"></el-input>
          </el-form-item>
          <el-form-item label="密码：" label-width="25%" style="margin-left: 10%">
            <el-input show-password v-model="form.password" autocomplete="off" style="width: 80%;margin-right: 100px"></el-input>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer" style="text-align: center">
          <el-button @click="exit()">返回</el-button>
          <el-button type="primary" @click="submit()">注册用户</el-button>
          <el-button type="primary" @click="reset()">重置</el-button>
        </div>
      </el-dialog>
    </div>
  </div>
</template>

<script>
import request from "@/utils/request";
import "@/assets/css/login.css"
export default {
  name:"Login",
  data(){
    return{
      admin:{},
      dialogFormVisible:false,
      form:{},
    }
  },
  created() {

  },
  methods:{
    login(){
      request.post("/admin/login",this.admin).then(res => {
        if(res.code === '0'){
          this.$message({
            message: '登录成功',
            type: 'success'
          });
          localStorage.setItem("admin",JSON.stringify(res.data));
          this.$router.push("/")
        }else {
          this.$message({
            message: res.msg,
            type: 'error'
          });
        }
      })
    },
    enroll(){
      this.dialogFormVisible = true
      this.form = {}
    },
    submit(){
      request.post("/admin/enroll",this.form).then(res => {
        if (res.code === '0') {
          this.$message({
            message: '注册成功',
            type: 'success',
          });
          this.dialogFormVisible = false;
        }else {
          this.$message({
            message: res.msg,
            type: 'error'
          });
        }
      })
    },
    exit(){
      this.dialogFormVisible = false;
    },
    reset(){
      this.form = this.$options.data().form
    }
  }
}
</script>
<style scoped>
div{
  font-weight: bold;
  font-size: 13px;
}
</style>>