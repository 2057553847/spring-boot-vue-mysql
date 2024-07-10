<template>
  <div>
    <div style="margin-bottom: 10px">
      <el-input v-model="params.name" placeholder="请输入权限名称" prefix-icon="el-icon-search" style="width: 200px"></el-input>
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
        <el-table-column align="center" label="编号" prop="id"></el-table-column>
        <el-table-column align="center" label="权限名称" prop="name"></el-table-column>
        <el-table-column align="center" label="权限路由" prop="routing"></el-table-column>
        <el-table-column align="center" label="权限代码" prop="code"></el-table-column>
        <el-table-column align="center" label="权限状态" prop="state">
          <template slot-scope="scope">
            <i v-if="scope.row.state === '1'" class="el-icon-check" style="color: #13ce66"></i>
            <i v-if="scope.row.state === ''" class="el-icon-close" style="color: #ff4949"></i>
            <span>{{scope.row.state === '1' ? '启用' : '禁用' }}</span>
          </template>
        </el-table-column>
        <el-table-column align="center" label="权限方法" prop="role_prm"></el-table-column>
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
      <el-dialog title="填写权限" :visible.sync="dialogFormVisible" width="30%">
        <el-form :model="form">
          <el-form-item label="权限名称:" label-width="25%" style="margin-left: 10%">
            <div style="width: 100px">
              <el-select v-model="form.name" >
                <el-option v-for="item in name" :key="item.value" :label="item.label" :value="item.value"></el-option>
              </el-select>
            </div>
          </el-form-item>
          <el-form-item label="权限路由:" label-width="25%" style="margin-left: 10%">
            <el-input v-model="form.routing" placeholder="请输入内容" style="width: 60%;margin-right: 200px"></el-input>
          </el-form-item>
          <el-form-item label="权限代码:" label-width="25%" style="margin-left: 10%">
            <el-input v-model="form.code" placeholder="请输入内容" style="width: 60%;margin-right: 200px"></el-input>
          </el-form-item>
          <el-form-item label="权限状态:" label-width="25%" style="margin-left: 10%">
            <div style="width: 100px">
              <el-select v-model="form.state" placeholder="请选择">
                <el-option v-for="item in state" :key="item.value" :label="item.label" :value="item.value"></el-option>
              </el-select>
            </div>
          </el-form-item>
          <el-form-item label="权限方法:" label-width="25%" style="margin-left: 10%">
            <div style="width: 100px">
              <el-select v-model="form.role_prm" >
                <el-option v-for="item in role_prm" :key="item.value" :label="item.label" :value="item.value"></el-option>
              </el-select>
            </div>
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
import axios from "axios";

export default {
  data() {
    return {
      name:[
        {value: '系统管理', label: '系统管理'},
        {value: '新增权限', label: '新增权限'},
        {value: '修改权限', label: '修改权限'},
        {value: '删除权限', label: '删除权限'},
        {value: '查询权限', label: '查询权限'},
      ],
      role_prm:[
        {value: 'os', label: '系统方法'},
        {value: 'add', label: '添加方法'},
        {value: 'update', label: '修改方法'},
        {value: 'del', label: '删除方法'},
        {value: 'select', label: '查询方法'},
      ],
      state: [
        {value: '1', label: '启用'},
        {value: '', label: '禁用'},
      ],
      params: {
        name: "",
        pageNum: 1,
        pageSize: 5,
      },
      total: 0,
      tableData: [],
      dialogFormVisible:false,
      multipleSelection: [],
      form:{},
      admin: localStorage.getItem("admin") ? JSON.parse(localStorage.getItem("admin")) : {}
    }
  },
  // 页面加载做的一些事情
  created() {
    this.findBySearch()
  },
  // 定义页面上的控件触发的时间
  methods: {
    handleCurrentChange(pageNum){
      this.params.pageNum = pageNum;
      this.findBySearch()
    },
    handleSizeChange(pageSize){
      this.params.pageSize = pageSize;
      this.findBySearch()
    },
    findBySearch(){
      request.get("/permissions/pageSelect",{
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
      request.put("/permissions/delBatch",this.multipleSelection).then(res => {
        if (res.code === '0'){
          this.$message.success("批量删除成功")
          this.findBySearch();
        }else {
          his.$message.error(res.msg)
        }
      })
    },
    getRowKeys(row){
      return row.id;
    },
    del(id){
      request.delete("/permissions/" + id).then(res => {
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
    exit(){
      this.dialogFormVisible = false
    },
    edit(obj){
      this.form = obj;
      this.dialogFormVisible = true;
    },
    submit(){
      request.post("/permissions",this.form).then(res => {
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