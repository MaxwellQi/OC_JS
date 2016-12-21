//
//  FirstWebViewController.m
//  UIWebViewDemo
//
//  Created by zhangqi on 6/12/2016.
//  Copyright © 2016 MaxwellQi. All rights reserved.
//

#import "FirstWebViewController.h"

@interface FirstWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *firstWebView;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@end

@implementation FirstWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.firstWebView.delegate = self;
    [self.firstWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://w66g.com/first.html"]]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlStr = request.URL.absoluteString;
    // 判断请求是否是自定义的，如果是自定义的，则进行处理
    NSRange range = [urlStr rangeOfString:@"dz://"];
    NSUInteger loc = range.location;
    if (loc != NSNotFound) {
        NSString *method = [urlStr substringFromIndex:loc + range.length]; // 取出JS方法的方法名
        NSLog(@"qizhang----debug-----%@",method);
        self.tipLabel.hidden = NO;
        self.tipLabel.text = [NSString stringWithFormat:@"JS 函数为：%@",method];
        
        SEL sel = NSSelectorFromString(method); // 将JS方法名转化为OC的方法名
        [self performSelector:sel withObject:nil];
        
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{

}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{

}

- (void)click {
    NSLog(@"点击了btn");
}

@end
