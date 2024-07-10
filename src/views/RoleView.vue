<template>
  <div>
    <div style="margin-bottom: 10px">
      <el-input v-model="params.name" placeholder="请输入角色名称" prefix-icon="el-icon-search" style="width: 200px"></el-input>
      <el-input v-model="params.description" placeholder="请输入角色描述" prefix-icon="el-icon-search" style="width: 200px;margin-left: 5px"></el-input>
      <el-button icon="el-icon-search" style="margin-left: 5px" type="primary" @click="findBySearch()">搜索</el-button>
      <el-button icon="el-icon-refresh-left" style="margin-left: 5px" type="info" @click="reset()">清空</el-button>
      <el-button icon="el-icon-plus" style="margin-left: 5px" type="success" @click="add()" v-if="admin.state === 'root'">新增</el-button>
      <el-popconfirm title="确定删除这些数据吗？" @confirm="delBatch()">
        <el-button slot="reference" icon="el-icon-delete" type="danger" style="margin-right: 5px;margin-left: 5px" v-if="admin.state === 'root'">批量删除</el-button>
      </el-popconfirm>
    </div>
    <div class="regional_table">
      <el-table :data="tableData" :row-key="getRowKeys" style="width: 100%;text-align: center" @selection-change="handleSelectionChange" border>
        <el-table-column align="center" type="selection" :reserve-selection="true" width="55" v-if="admin.state === 'root'"></el-table-column>
        <el-table-column align="center" label="编号" prop="id" v-if="admin.state === 'root'"></el-table-column>
        <el-table-column align="center" label="角色名称" prop="name"></el-table-column>
        <el-table-column align="center" label="角色描述" prop="description"></el-table-column>
        <el-table-column align="center" label="权限代码" prop="code"></el-table-column>
        <el-table-column align="center" label="权限等级" prop="permissions"></el-table-column>
        <el-table-column align="center" label="拥有权限" prop="permName"></el-table-column>
        <el-table-column align="center" label="操作" v-if="admin.state === 'root'">
          <template slot-scope="scope">
            <el-popconfirm title="确定删除吗？" @confirm="del(scope.row.id)">
              <el-button slot="reference" icon="el-icon-delete" type="danger" style="margin-right: 5px">删除</el-button>
            </el-popconfirm>
            <el-button icon="el-icon-edit" type="primary" @click="edit(scope.row)">修改</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <div style="text-align: center">
      <el-dialog title="填写角色" :visible.sync="dialogFormVisible" width="30%">
        <el-form :model="form">
          <el-form-item label="角色名称:" label-width="25%" style="margin-left: 10%">
            <el-input v-model="form.name" placeholder="请输入内容" style="width: 60%;margin-right: 200px"></el-input>
          </el-form-item>
          <el-form-item label="角色描述:" label-width="25%" style="margin-left: 10%">
            <el-input v-model="form.description" placeholder="请输入内容" style="width: 60%;margin-right: 200px"></el-input>
          </el-form-item>
          <el-form-item label="权限代码:" label-width="25%" style="margin-left: 10%">
            <el-input v-model="form.code" placeholder="请输入内容" style="width: 60%;margin-right: 200px"></el-input>
          </el-form-item>
          <el-form-item label="权限等级:" label-width="25%" style="margin-left: 10%">
            <div style="margin-right: 280px">
              <el-radio v-model="form.permissions" label="组长级">组长</el-radio>
              <el-radio v-model="form.permissions" label="用户级">用户</el-radio>
            </div>
          </el-form-item>
          <el-form-item label="拥有权限:" label-width="25%" style="margin-left: 10%">
            <el-select v-model="form.permissionsId" placeholder="请选择" style="margin-right: 300px">
              <el-option v-for="item in PermissionsObjs" :key="item.id" :label="item.name" :value="item.id"></el-option>
            </el-select>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer" style="text-align: center">
          <el-button @click="exit()">取 消</el-button>
          <el-button type="primary" @click="submit()">确 定</el-button>
        </div>
      </el-dialog>
    </div>
    <div style="margin-top: 10px" class="block">
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="params.pageNum"
          :page-sizes="[5, 10, 15, 20]"
          :page-size="params.pageSize"
          layout="total, sizes, prev, pager, next"
          :total="total">
      </el-pagination>
    </div>
  </div>
</template>
<script>
import request from "@/utils/request";

export default {
  data() {
    return {
      adminRules:[
        { required: true, message: '请选择用户权限', trigger: 'change' }
      ],
      params: {
        name: "",
        description:"",
        pageNum: 1,
        pageSize: 5,
      },
      total: 0,
      tableData: [],
      dialogFormVisible:false,
      multipleSelection: [],
      form:{},
      PermissionsObjs:[],
      admin: localStorage.getItem("admin") ? JSON.parse(localStorage.getItem("admin")) : {}
    }
  },
  // 页面加载做的一些事情
  created() {
    this.findBySearch()
    this.findPermissions()
  },
  // 定义页面上的控件触发的时间
  methods: {
    findPermissions(){
      request.get("/permissions").then(res => {
        if (res.code === '0'){
          this.PermissionsObjs = res.data;
          console.log(this.PermissionsObjs);
        }else {
          this.$message.error(res.msg);
        }
      })
    },
    handleCurrentChange(pageNum){
      this.params.pageNum = pageNum;
      this.findBySearch()
    },
    handleSizeChange(pageSize){
      this.params.pageSize = pageSize;
      this.findBySearch()
    },
    findBySearch(){
      request.get("/role/pageSelect",{
        params:this.params
      }).then(res => {
        if (res.code === '0'){
          this.tableData = res.data.list;
          this.total = res.data.total;
        }
      })
    },
    handleSelectionChange(val){
      this.multipleSelection = val;
    },
    delBatch(){
      if(this.multipleSelection.length === 0){
        this.$message.warning("请选择数据")
        return
      }
      request.put("/role/delBatch",this.multipleSelection).then(res => {
        if (res.code === '0'){
          this.$message.success("批量删除成功")
          this.findBySearch();
        }else {
          his.$message.error(res.msg)
        }
      })
    },
    del(id){
      request.delete("/role/" + id).then(res => {
        if (res.code === '0'){
          this.$message({
            message:'删除成功',
            type:'success'
          })
          this.findBySearch();
        }else {
          this.$message({
            message: res.msg,
            type:'success'
          });
        }
      })
    },
    getRowKeys(row){
      return row.id;
    },
    exit(){
      this.dialogFormVisible = false
    },
    edit(obj){
      this.form = obj;
      this.dialogFormVisible = true;
    },
    submit(){
      request.post("/role",this.form).then(res => {
        if (res.code === '0'){
          this.$message({
            message:'操作成功',
            type:'success',
          });
          this.dialogFormVisible = false;
          this.findBySearch()
        } else {
          this.$message({
            message: res.msg,
            type:'error'
          });
        }
      })
    },
    add(){
      this.form = {};
      this.dialogFormVisible = true;
    },
    reset() {
      this.params = {
        name: '',
        description:'',
        pageNum: 1,
        pageSize: 5,
      }
      this.findBySearch();
    },
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
</style>