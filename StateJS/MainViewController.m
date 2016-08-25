//
//  MainViewController.m
//  StateJS
//
//  Created by 王会洲 on 16/8/24.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "MainViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface MainViewController ()

@property (nonatomic, strong) UIWebView * webView;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"。。。";
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    
    NSString * loaclStr = @"http://192.168.1.139:3000";
    NSURLRequest * quest = [NSURLRequest requestWithURL:[NSURL URLWithString:loaclStr]];
    [self.webView loadRequest:quest];
    //demo
    JSContext * context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    /**js调用oc*/
    context[@"sendTextStr"] = ^(){
        NSLog(@"js调用");
        NSArray *args = [JSContext currentArguments];
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal);
        }
    };
    
    
    context[@"didViewLoad"] = ^(){
        NSLog(@"js调用--ViewdidLoad");
        NSArray *args = [JSContext currentArguments];
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal);
        }
        /**oc给js传入函数值*/
        NSString * func = [NSString stringWithFormat:@"show('%@');",@"OC后台传入数据"];
        [self.webView stringByEvaluatingJavaScriptFromString:func];
    };
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
}

@end
