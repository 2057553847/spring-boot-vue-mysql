<template>
  <div>
    <div style="margin-bottom: 10px">
      <el-input v-model="params.name" placeholder="请输入公告标题" prefix-icon="el-icon-search"
                style="width: 200px"></el-input>
      <el-button icon="el-icon-search" style="margin-left: 5px" type="primary" @click="findBySearch()">搜索
      </el-button>
      <el-button icon="el-icon-refresh-left" style="margin-left: 5px" type="info" @click="reset()">清空</el-button>
      <el-button icon="el-icon-plus" style="margin-left: 5px" type="success" @click="add()" v-if="admin.state === 'root'">新增</el-button>
      <el-popconfirm title="确定删除这些数据吗？" @confirm="delBatch()">
        <el-button slot="reference" icon="el-icon-delete" style="margin-right: 5px;margin-left: 5px" type="danger" v-if="admin.state === 'root'">批量删除</el-button>
      </el-popconfirm>
    </div>
    <div class="regional_table">
      <el-table :data="tableData" border style="width: 100%;height: 100%;text-align: center"
                :row-key="getRowKeys"
                @selection-change="handleSelectionChange">
        <el-table-column align="center" type="selection" :reserve-selection="true" width="55" v-if="admin.state === 'root'"></el-table-column>
        <el-table-column align="center" label="编号" prop="id" v-if="admin.state === 'root'"></el-table-column>
        <el-table-column align="center" label="公告标题" prop="name"></el-table-column>
          <el-table-column align="center" label="公告内容" prop="content"></el-table-column>
        <el-table-column align="center" label="发布时间" prop="time"></el-table-column>
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
          <el-form-item label="公告标题" label-width="25%" style="margin-left: 10%">
            <el-input v-model="form.name" autocomplete="off" style="width: 50%;margin-right: 300px"></el-input>
          </el-form-item>
          <el-form-item label="公告内容" label-width="25%" style="margin-left: 10%">
            <el-input  type="textarea" v-model="form.content" autocomplete="off" style="width: 50%;margin-right: 300px"></el-input>
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
          :total="total"
          layout="total, prev, pager, next"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange">
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
      params: {
        name: "",
        pageNum: 1,
        pageSize: 2,
      },
      total: 0,
      tableData: [],
      dialogFormVisible: false,
      form: {},
      multipleSelection: [],
      admin: localStorage.getItem("admin") ? JSON.parse(localStorage.getItem("admin")) : {}
    }
  },
  // 页面加载做的一些事情
  created() {
    this.findBySearch()
    // 进行对role表的查询所有字段
  },
  // 定义页面上的控件触发的时间
  methods: {

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
      request.put("/notice/delBatch", this.multipleSelection).then(res => {
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
      request.delete("/notice/" + id).then(res => {
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
      request.post("/notice", this.form).then(res => {
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
    },
    findBySearch(){
      request.get("/notice/pageSelect",{
        params:this.params
      }).then(res => {
        if (res.code === '0'){
          this.tableData = res.data.list;
          this.total = res.data.total;
        }
      })
    },
    reset() {
      this.params = {
        name: '',
        pageNum: 1,
        pageSize: 2,
      }
      this.findBySearch();
    },
  }
}
</script>
<style scoped>
.el-table {
  color: black;
  font-size: 13px;
}
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
