/* 封装ajax函数
* @param {string}opt.type http连接的方式，包括POST和GET两种方式，默认使用GET
* @param {string}opt.url 发送请求的url
* @param {boolean}opt.async 是否为异步请求，true为异步的，false为同步的
* @param {int}opt.timer 请求超时时间
* @param {object}focus 当前触发异步请求的元素
* @param {object}opt.data 发送的参数，格式为对象类型
* @param {function}opt.success ajax发送并接收成功调用的回调函数
* @param {function}opt.error ajax发送并接收失败调用的回调函数
*/
function ajax($) {
    let xmlHttp = null;
    let timerID,dataStr;

    //检查并初始化参数对象
    (function($) {
        $ = $ || {};
        $.method = $.method || 'GET';
        $.method = $.method.toUpperCase() || 'GET';
        $.url = $.url || '';
        $.async = $.async || true;
        $.timeout = $.timeout || 0;
        $.focus = $.focus || {};
        $.success = $.success || function () {};
        $.fail = $.fail || function () {};
    })($);

    if (XMLHttpRequest) {
        xmlHttp = new XMLHttpRequest();
    } else {
        xmlHttp = new ActiveXObject('Microsoft.XMLHTTP');
    }

    dataStr = obj2str($.data);
    if ($.method === 'POST') {
        xmlHttp.open($.method, $.url, $.async);
        xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded;charset=utf-8');
        xmlHttp.send(dataStr);
    } else {
        xmlHttp.open($.method, $.url + '?' + dataStr, $.async);
        xmlHttp.send(null);
    }

    xmlHttp.onreadystatechange = function () {
        if (xmlHttp.readyState === 4){
            $.timeout && clearInterval(timerID);

            //判断是否请求成功(Http状态码大于等于200，且小于300，和状态码等于304为请求成功)
            if (xmlHttp.status>=200 && xmlHttp.status<300|| xmlHttp.status===304) {
                $.success(xmlHttp.responseText,$.focus);
            }else{
                $.fail(xmlHttp.responseText,$.focus);
            }
        }
    };

    if ($.timeout){
        timerID = setInterval(function () {
            console.log("中断请求");
            xmlHttp.abort();
            clearInterval(timerID);
        },$.timeout);
    }
}

function obj2str(data) {
    data = data || {}; // 如果没有传参, 为了添加随机因子,必须自己创建一个对象
    //data.t = new Date().getTime();
    var res = [];
    for (var key in data){
        //在URL中是不可以出现中文的，如果出现了中文需要转码，可以调用encodeURIComponent方法，URL中只可以出现字母、数字、下划线、ASCII码
        res.push(encodeURIComponent(key)+"="+encodeURIComponent(data[key]));
    }
    return res.join("&");
}
