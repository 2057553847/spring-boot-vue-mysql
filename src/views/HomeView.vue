<template>
  <div>
    <div style="text-align: center">
      <H1 style="font-size: 30px">欢迎登录企业系统快速开发平台</H1>
    </div>
    <div style="text-align: center;width: 50%;margin-left: 570px">
      <el-carousel indicator-position="outside">
        <el-carousel-item v-for="item in carouselData" :key="item">
          <img :src="item" alt="">
        </el-carousel-item>
      </el-carousel>
    </div>
    <div style="width: 100%">
      <div style="margin-bottom: 20px;font-weight: bold;font-size: 40px;margin-top: 50px;text-align: center">系统公告</div>
      <el-collapse v-model="activeName" accordion style="border: none">
        <el-collapse-item  v-for="item in date" :title="item.name" :name="item.id">
          <div>{{ item.content }}</div>
        </el-collapse-item>
      </el-collapse>
    </div>
  </div>
</template>

<script>
import request from "@/utils/request";
import * as echarts from 'echarts';
import "@/assets/css/collapse.css";

export default {
  data() {
    return {
      carouselData:[
          require('../../public/vue/img/走马灯1.png'),
          require('../../public/vue/img/走马灯2.png'),
          require('../../public/vue/img/走马灯3.png'),
          require('../../public/vue/img/qq.gif')
      ],
      activeName: '1',
      date:[]
    };
  },
  mounted() {
    this.selectNotice()
    this.Bie()
  },
  created() {
    this.selectNotice()
  },
  methods:{
    selectNotice(){
      request.get("/notice").then(res => {
        if (res.code === '0'){
          this.date = res.data;
          this.activeName = res.data[0].id
        }else {
          this.$message.error(res.msg)
        }
      })
    },
    Bie(){
      var chartDom = document.getElementById('chart');
      var myChart = echarts.init(chartDom);
      var option;

      option = {
        xAxis: {
          type: 'category',
          data: ['用户数量', '管理人员', '系统性能']
        },
        yAxis: {
          type: 'value'
        },
        series: [
          {
            data: [120, 20, 150],
            type: 'bar'
          }
        ]
      };

      option && myChart.setOption(option);

    },
  }
}
</script>
<style scoped>
div{
  font-weight: bold;
  font-size: 13px;
}
</style>
