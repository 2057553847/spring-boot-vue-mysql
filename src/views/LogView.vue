<template>
  <div>
    <div style="margin-bottom: 10px">
      <el-input v-model="params.name" placeholder="请输入系统行为" prefix-icon="el-icon-search" style="width: 200px"></el-input>
      <el-button icon="el-icon-search" style="margin-left: 5px" type="primary" @click="findBySearch()">搜索
      </el-button>
      <el-button icon="el-icon-refresh-left" style="margin-left: 5px" type="info" @click="reset()">清空</el-button>
      <el-popconfirm title="确定删除这些数据吗？" @confirm="delBatch()">
        <el-button slot="reference" icon="el-icon-delete" style="margin-right: 5px;margin-left: 5px" type="danger" v-if="admin.state === 'root'">批量删除</el-button>
      </el-popconfirm>
    </div>
    <div class="regional_table">
      <el-table :data="tableData" border style="width: 100%;height: 100%;text-align: center;"
                :row-key="getRowKeys"
                @selection-change="handleSelectionChange">
        <el-table-column align="center" type="selection" :reserve-selection="true" width="55" v-if="admin.state === 'root'"></el-table-column>
        <el-table-column align="center" label="编号" prop="id"></el-table-column>
        <el-table-column align="center" label="系统行为" prop="name"></el-table-column>
        <el-table-column align="center" label="系统时间" prop="time"></el-table-column>
        <el-table-column align="center" label="操作用户" prop="username"></el-table-column>
        <el-table-column align="center" label="系统设备" prop="ip"></el-table-column>
        <el-table-column align="center" label="操作" v-if="admin.state === 'root'">
          <template slot-scope="scope">
            <el-popconfirm title="确定删除吗？" @confirm="del(scope.row.id)">
              <el-button slot="reference" icon="el-icon-delete" style="margin-right: 5px" type="danger">删除</el-button>
            </el-popconfirm>
          </template>
        </el-table-column>
      </el-table>
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
        name: "",
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
      admin: localStorage.getItem("admin") ? JSON.parse(localStorage.getItem("admin")) : {}
    }
  },
  // 页面加载做的一些事情
  created() {
    this.findBySearch()
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
    del(id) {
      request.delete("/log/" + id).then(res => {
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
    delBatch() {
      if (this.multipleSelection.length === 0) {
        this.$message.warning("请选择数据")
        return
      }
      request.put("/log/delBatch", this.multipleSelection).then(res => {
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
    findBySearch() {
      request.get("/log/pageSelect", {
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
        name: '',
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