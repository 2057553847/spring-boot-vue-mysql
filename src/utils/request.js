import axios from "axios";

const request = axios.create({
    //后端接口
    baseURL: "http://localhost:8082/api",
    timeout: 5000
})

// request拦截器
// 可以自请求发送前对请求做一些处理
// 比如统一加token，对请求参数统一加密
request.interceptors.request.use(config => {
    config.headers['Content-Type'] = 'application/json;charset=utf-8';

    const admin = localStorage.getItem("admin");
    if(admin){
        config.headers['token'] = JSON.parse(admin).token;
    }
    return config
}, error => {
    return Promise.reject(error)
});

// 响应拦截器
// 可以在接口处理完毕后统一处理返回数据
request.interceptors.response.use(
    response => {

        let res = response.data;
        // 如果是返回的是字符串，则返回字符串
        if (typeof res === 'string') {
            res = res ? JSON.parse(res) : res
        }
        return res;
    },
    error => {
        console.log('err' + error)
        return Promise.reject(error)
    }
)

export default request;