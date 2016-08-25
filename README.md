# WebViewJSContext
利用原生的js来实现OC和JS交互

 iOS和JS交互(含OC、html、js)代码不使用第三方库(二)

>在上一篇文章中我们说了用`WebViewJavascriptBridge`实现oc和js的交互，今天我来说说利用原生`JSContext`库来实现交互。

`如果对`WebViewJavascriptBridge`不数据可以看看《iOS和JS交互(含OC、html、js)代码》`

直接看代码！！！

`今天的实例说明一下:`
1：今天说了一个利用JS实现打电话的功能。
2：并且也实现了点击一个button的登陆功能。
3：oc给js传值。

#### 1. 创建`index.html`代码
```html
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>js/oc互动</title>
	<script src="js/jquery-1.10.1.min.js"></script>
	<link rel="stylesheet" type="text/css" href="css/style.css" />
	<script src="js/docment.js"></script>
</head>
<body>
<div id="console">
<br><br><br>
	<input name="value" id="userName">
    <button type="submit" id="Call">打电话</button>
    <br><br>
    <input type="input" name="" id="zhanghao">账号<br>
    <input type="input" name="" id="mima">密码
    <button type="submit" id="AppGoBack">登陆</button>
</div>
</body>
</html>
```
#### 2. 创建`document.js`代码
```js
$(document).ready(function() {
    viewDidLoad();
    /**点击打电话*/
    $("#Call").click(function(){
      var numberText = $("#userName").val();
      window.location.href = 'tel://' + numberText;
    });
     /**跳转方法*/
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
```
我用Jquery写js事件，看官要是不太明白，大概知道一下就可以了。
到了这里我的`前端`的代码已经写完了。下面开始`oc代码`
#### 3. 创建`oc`代码
1. 创建一个`WebView`
```objc
@property (nonatomic, strong) UIWebView * webView;
```
2. 实例化代码
```objc
self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
[self.view addSubview:self.webView];

NSString * loaclStr = @"http://192.168.1.139:3000";
NSURLRequest * quest = [NSURLRequest requestWithURL:[NSURL URLWithString:loaclStr]];
[self.webView loadRequest:quest];
//demo
JSContext * context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
```
#### 4. `js调用电话功能`代码实现
首先在js函数是这样写的
```objc
/**点击打电话*/
$("#Call").click(function(){
  var numberText = $("#userName").val();
  window.location.href = 'tel://' + numberText;
});
```
这样写就不用去用`JS调用oc代码去打电话了`，我们直接用js调用连接打电话了。
#### 5. `js调用登陆功能`代码实现
* 看看JS端函数
```objc
 /**登陆*/
$("#AppGoBack").click(function(){
  AppTrancelate();
}); 
```
* 看OC端代码实现
```objc
/**js调用oc*/
context[@"sendTextStr"] = ^(){
    NSLog(@"js调用");
    NSArray *args = [JSContext currentArguments];
    for (JSValue *jsVal in args) {
    NSLog(@"%@", jsVal);
    }
};
```
`NOTICE:`这里要注意，登陆按钮执行的单击事件里的函数，我们要执行函数中的`SendeData`的函数，这里就是`sendTextStr`

#### 5. `js调用OC代码`然后`oc代码给js传值`代码实现
* 这里的js代码如下
```objc
function viewDidLoad() {
  didViewLoad("js给OC传入传出");
}
要在ready（）的函数里要执行该函数。
```
* oc里的代码
```objc
context[@"didViewLoad"] = ^(){
    NSLog(@"js调用--ViewdidLoad");
    NSArray *args = [JSContext currentArguments];
    for (JSValue *jsVal in args) {
        NSLog(@"%@", jsVal);
    }
    /**接受完传值之后，oc给js传入函数值，带参数的*/
    NSString * func = [NSString stringWithFormat:@"show('%@');",@"OC后台传入数据"];
    [self.webView stringByEvaluatingJavaScriptFromString:func];
};
```

## 更多消息
 更多信iOS开发信息 请以关注洲洲哥 的微信公众号，不定期有干货推送：
 
 ![这里写图片描述](http://upload-images.jianshu.io/upload_images/1416781-0f0cc08cfd424a54?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

