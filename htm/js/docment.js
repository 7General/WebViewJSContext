$(document).ready(function() {
    viewDidLoad();
    /**点击打电话*/
    $("#Call").click(function(){
      var numberText = $("#userName").val();
      window.location.href = 'tel://' + numberText;
    });
     /**登陆*/
    $("#AppGoBack").click(function(){
      AppTrancelate();
    }); 
});
/*发送按钮事件*/
function AppTrancelate(){
  var sendData = [$("#zhanghao").val(),$("#mima").val()]
  alert(sendData);
  sendTextStr(sendData);
} 


function viewDidLoad() {
  didViewLoad("js给OC传入传出");
}

function show(str1){
  alert("-----------------str1");
}