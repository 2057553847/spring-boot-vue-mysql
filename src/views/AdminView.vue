<template>
  <div>
    <div style="margin-bottom: 10px">
      <el-input v-model="params.username" placeholder="请输入用户名" prefix-icon="el-icon-search"
                style="width: 200px"></el-input>
      <el-button icon="el-icon-search" style="margin-left: 5px" type="primary" @click="findBySearch()">搜索
      </el-button>
      <el-button icon="el-icon-refresh-left" style="margin-left: 5px" type="info" @click="reset()">清空</el-button>
      <el-button icon="el-icon-plus" style="margin-left: 5px" type="success" @click="add()" v-if="admin.state === 'root'">新增</el-button>
      <el-popconfirm title="确定删除这些数据吗？" @confirm="delBatch()">
        <el-button slot="reference" icon="el-icon-delete" style="margin-right: 5px;margin-left: 5px" type="danger" v-if="admin.state === 'root'">批量删除</el-button>
      </el-popconfirm>
      <el-button icon="el-icon-bottom" type="success" plain v-if="admin.state === 'root'" @click="Exp()">导出用户数据</el-button>
      <el-upload action="http://localhost:8082/api/admin/upload" style="display: inline-block;margin-left: 5px" :show-file-list="false" :on-success="successUpload">
        <el-button type="primary" plain v-if="admin.state === 'root'">上传用户数据<i class="el-icon-upload el-icon--right"></i></el-button>
      </el-upload>
    </div>
    <div class="regional_table">
      <el-table :data="tableData" border style="width: 100%;height: 100%;text-align: center"
                :row-key="getRowKeys"
                @selection-change="handleSelectionChange">
        <el-table-column align="center" type="selection" :reserve-selection="true" width="55" v-if="admin.state === 'root'"></el-table-column>
        <el-table-column align="center" label="编号" prop="id" v-if="admin.state === 'root'"></el-table-column>
        <el-table-column align="center" label="用户名" prop="username"></el-table-column>
        <el-table-column align="center" label="姓名" prop="name"></el-table-column>
        <el-table-column align="center" label="注册时间" width="180">
          <template slot-scope="scope">
            <i class="el-icon-time"></i>
            <span style="margin-left: 10px">{{ scope.row.time }}</span>
          </template>
        </el-table-column>
        <el-table-column align="center" label="权限状态" prop="state">
        </el-table-column>
        <el-table-column align="center" label="角色分类" prop="roleName"></el-table-column>
        <el-table-column align="center" label="操作" v-if="admin.state === 'root'">
          <template slot-scope="scope">
            <el-popconfirm title="确定删除吗？" @confirm="del(scope.row.id)">
              <el-button slot="reference" icon="el-icon-delete" style="margin-right: 5px" type="danger">删除</el-button>
            </el-popconfirm>
            <el-button icon="el-icon-edit" type="primary" @click="edit(scope.row)">修改</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <div style="text-align: center">
      <el-dialog :visible.sync="dialogFormVisible" title="填写用户" width="30%">
        <el-form :model="form">
          <el-form-item label="用户名：" label-width="25%" style="margin-left: 10%">
            <el-input v-model="form.username" autocomplete="off" style="width: 50%;margin-right: 300px"></el-input>
          </el-form-item>
          <el-form-item label="姓名：" label-width="25%" style="margin-left: 10%">
            <el-input v-model="form.name" autocomplete="off" style="width: 50%;margin-right: 300px"></el-input>
          </el-form-item>
          <el-form-item label="权限状态：" label-width="25%" style="margin-left: 10%">
            <div style="width: 100px">
              <el-select v-model="form.state" placeholder="请选择">
                <el-option label="组长" value="supervisor"></el-option>
                <el-option label="用户" value="user"></el-option>
              </el-select>
            </div>
          </el-form-item>
          <el-form-item label="角色分类：" label-width="25%" style="margin-left: 10%">
            <el-select v-model="form.roleId" placeholder="请选择" style="margin-right: 260px;width: 50%">
              <el-option v-for="item in roleObjs" :key="item.id" :label="item.name" :value="item.id">
              </el-option>
            </el-select>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer" style="text-align: center">
          <el-button @click="exit()">取 消</el-button>
          <el-button type="primary" @click="submit()">确 定</el-button>
        </div>
      </el-dialog>
    </div>
    <div class="block" style="margin-top: 10px">
      <el-pagination
          :current-page="params.pageNum"
          :page-size="params.pageSize"
          :page-sizes="[5, 10, 15, 20]"
          :total="total"
          layout="total, sizes, prev, pager, next"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange">
      </el-pagination>
    </div>
  </div>
</template>
<script>
import request from "@/utils/request";
export default {
  data() {
    return {
      params: {
        username: "",
        pageNum: 1,
        pageSize: 5,
      },
      total: 0,
      tableData: [],
      dialogFormVisible: false,
      form: {},
      multipleSelection: [],
      // 定义一个数组来存储角色分类
      roleObjs: [],
      admin: localStorage.getItem("admin") ? JSON.parse(localStorage.getItem("admin")) : {},
    }
  },
  // 页面加载做的一些事情
  created() {
    this.findBySearch()
    // 进行对role表的查询所有字段
    this.findRoles()
  },
  // 定义页面上的控件触发的时间
  methods: {
    findRoles() {
      // 获取所有role的字段值 res接收
      request.get("/role").then(res => {
        if (res.code === '0') {
          // 把roleObjs数组赋值给res.data
          this.roleObjs = res.data;
          console.log(this.roleObjs)
        } else {
          this.$message.error(res.msg);
        }
      })
    },

    handleCurrentChange(pageNum) {
      this.params.pageNum = pageNum;
      this.findBySearch()
    },
    handleSizeChange(pageSize) {
      this.params.pageSize = pageSize;
      this.findBySearch()
    },
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    delBatch() {
      if (this.multipleSelection.length === 0) {
        this.$message.warning("请选择数据")
        return
      }
      request.put("/admin/delBatch", this.multipleSelection).then(res => {
        if (res.code === '0') {
          this.$message.success("批量删除成功")
          this.findBySearch();
        } else {
          his.$message.error(res.msg)
        }
      })
    },
    getRowKeys(row){
      return row.id;
    },
    del(id) {
      request.delete("/admin/" + id).then(res => {
        if (res.code === '0') {
          this.$message({
            message: '删除成功',
            type: 'success'
          })
          this.findBySearch();
        } else {
          this.$message({
            message: res.msg,
            type: 'success'
          });
        }
      })
    },
    exit() {
      this.dialogFormVisible = false
    },
    edit(obj) {
      this.form = obj;
      this.dialogFormVisible = true;
    },
    submit() {
      request.post("/admin", this.form).then(res => {
        if (res.code === '0') {
          this.$message({
            message: '操作成功',
            type: 'success',
          });
          this.dialogFormVisible = false;
          this.findBySearch()
        } else {
          this.$message({
            message: res.msg,
            type: 'error'
          });
        }
      })
    },
    add() {
      this.form = {};
      this.dialogFormVisible = true;
      this.$message({
        showClose: true,
        message: '角色新增时无需填写密码，默认为123哦！',
        type: 'success'
      });
    },
    findBySearch() {
      request.get("/admin/pageSelect", {
        params: this.params
      }).then(res => {
        if (res.code === '0') {
          this.tableData = res.data.list;
          this.total = res.data.total;
        }
      })
    },
    reset() {
      this.params = {
        username: '',
        pageNum: 1,
        pageSize: 5,
      }
      this.findBySearch();
    },
    Exp(){
      let admin = localStorage.getItem("admin");
      location.href = 'http://8.138.143.221:8081/api/admin/export?token=' + JSON.parse(admin).token;
    },
    successUpload(res){
      if (res.code === '0'){
        this.$message.success("上传成功")
        this.findBySearch()
      }else {
        this.$message.error(res.msg)
      }
    }
  }
}
</script>
<style scoped>
div{
  font-weight: bold;
  font-size: 13px;
}

.regional_table /deep/ .el-table,
.regional_table /deep/ .el-table__expanded-cell {
  background-color: transparent;
  color: #606266;
}

.regional_table /deep/ .el-table th,
.regional_table /deep/ .el-table tr,
.regional_table /deep/ .el-table td {
  background-color: transparent !important;
  color: black;
}
.el-collapse,.el-collapse-item__wrap {
  border: none;
}

</style>