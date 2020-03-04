function goBackDialog(result) {
    let btnArray = ['返回'];
    mui.confirm("", "操作" + result, btnArray, function (e) {
        if (e.index == 1) {
            window.location.href = "index.jsp";
        } else {
            window.location.replace("index.jsp");
        }
    });
}

Date.prototype.Format = function (fmt) {
    var o = {
        "M+": this.getMonth() + 1, //月份
        "d+": this.getDate(), //日
        "H+": this.getHours(), //小时
        "m+": this.getMinutes(), //分
        "s+": this.getSeconds(), //秒
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度
        "S": this.getMilliseconds() //毫秒
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
};

var validate = {
    isNumber : function(value) {
        var reg = /^[0-9]+\.?[0-9]*$/;
        if(value!=""&&reg.test(value)) {
            return true;
        }
        return false;
    },

    length : function(value,len) {
        value = value || "";
        if (value.length > len) {
            return false;
        }
        return true;
    },

    isEmpty : function(value) {
        value = value || "";
        if (value.length == 0) {
            return false;
        }
        return true;
    }
};

function initSideMenu($,doc) {
    //侧滑容器父节点
    let offCanvasWrapper = $('#offCanvasWrapper');
    //菜单界面，‘关闭侧滑菜单’按钮的点击事件
    doc.getElementById('offCanvasHide').addEventListener('tap', function () {
        offCanvasWrapper.offCanvas('close');
    });
    //主界面和侧滑菜单界面均支持区域滚动；
    $('#offCanvasSideScroll').scroll();
    $('#offCanvasContentScroll').scroll();

    //主列表点击事件
    offCanvasWrapper.on('tap', 'a', function () {
        location.href = this.getAttribute('href');
    })
}