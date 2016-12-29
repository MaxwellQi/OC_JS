//
//  FirstWebViewController.m
//  UIWebViewDemo
//
//  Created by zhangqi on 6/12/2016.
//  Copyright © 2016 MaxwellQi. All rights reserved.
//

#import "FirstWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

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
//    NSString *urlStr = request.URL.absoluteString;
//    // 判断请求是否是自定义的，如果是自定义的，则进行处理
//    NSRange range = [urlStr rangeOfString:@"dz://"];
//    NSUInteger loc = range.location;
//    if (loc != NSNotFound) {
//        NSString *method = [urlStr substringFromIndex:loc + range.length]; // 取出JS方法的方法名
//        NSLog(@"qizhang----debug-----%@",method);
//        self.tipLabel.hidden = NO;
//        self.tipLabel.text = [NSString stringWithFormat:@"JS 函数为：%@",method];
//        
//        SEL sel = NSSelectorFromString(method); // 将JS方法名转化为OC的方法名
//        [self performSelector:sel withObject:nil];
//
//    }
//    return YES;
    
    
    NSString *schem = @"xmg://";
    NSString *urlStr = request.URL.absoluteString;
    if ([urlStr hasPrefix:schem]) {
        // 1.从URL中获取方法名称
        // xmg://sendMessageWithNumber_andContent_?10086&love
        NSString *subPath = [urlStr substringFromIndex:schem.length];
         // 注意: 如果指定的用于切割的字符串不存在, 那么就会返回整个字符串
        NSArray *subPaths = [subPath componentsSeparatedByString:@"?"];
        // 2.获取方法名称
         NSString *methodName = [subPaths firstObject];
        methodName = [methodName stringByReplacingOccurrencesOfString:@"_" withString:@":"];
        NSLog(@"%@", methodName);
        // 2.调用方法
        SEL sel = NSSelectorFromString(methodName);
        // 3.处理参数
                 NSString *parma = nil;
                 if (subPaths.count == 2) {
                    parma = [subPaths lastObject];
                    // 3.截取参数
                    NSArray *parmas = [parma componentsSeparatedByString:@"&"];
                    [self performSelector:sel withObject:[parmas firstObject] withObject:[parmas lastObject]];
                     return NO;
            
                     }
         //这里处理参数很麻烦，我们可以自己实现一个类去将苹果自带的方法进行优化，其实就是可以传递不同的参数（多个）去处理相应的事件
                 [self performSelector:sel withObject:parma];
        
                 return NO;
             }
        return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{

}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
     [webView stringByEvaluatingJavaScriptFromString:@"showTitle();"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

- (void)click {
    NSLog(@"点击了btn");
}

- (void)call
{
    NSLog(@"%s", __func__);
}

// callWithNumber:
- (void)callWithNumber:(NSString *)number
{
        NSLog(@"打电话给%@", number);
}

- (void)sendMessageWithNumber:(NSString *)number andContent:(NSString *)content
{
     NSLog(@"发信息给%@, 内容是%@", number, content);
}

- (void)sendMessageWithNumber:(NSString *)number andContent:(NSString *)content status:(NSString *)status
{
     NSLog(@"发信息给%@, 内容是%@, 发送的状态是%@", number, content, status);
}
@end
