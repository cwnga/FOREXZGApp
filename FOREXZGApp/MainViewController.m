//
//  MainViewController.m
//  FOREXZGApp
//
//  Created by  Anson Ng on 20/04/2017.
//  Copyright © 2017 TestWeb. All rights reserved.
//

#import "MainViewController.h"
#import <WebKit/WebKit.h>
@interface MainViewController () <WKNavigationDelegate, WKUIDelegate>
@property (strong, nonatomic) WKWebView *wkWebView;
@end

@implementation MainViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    self.wkWebView = [self createWkWebViewWithRect:self.view.bounds configuration:nil closeButton:NO];
    [self.view addSubview:self.wkWebView];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://web88.def777.com/wm/pr198/"]];
    [self.wkWebView loadRequest:request];

}

- (WKWebView *)createWkWebViewWithRect:(CGRect)rect configuration:(WKWebViewConfiguration *)config closeButton:(BOOL)closeButton
{
    if (!config) {
        config = [[WKWebViewConfiguration alloc] init];
    }
    WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:rect configuration:config];
    wkWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    wkWebView.UIDelegate = self;
    wkWebView.navigationDelegate = self;
    if (closeButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(wkWebView.bounds.size.width - 24 - 20,20, 24, 24)];
        [wkWebView addSubview:button];
        [button setImage:[UIImage imageNamed:@"Img-Close"] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        button.layer.cornerRadius = CGRectGetHeight(button.bounds) / 2;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(wkViewRemoveFromSuperView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return wkWebView;
}

- (void)wkViewRemoveFromSuperView:(UIButton *)button
{
    [button.superview removeFromSuperview];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - <WKNavigationDelegate>
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    if (error) {
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://web89.def777.com/wm/pr198/"]]];
    }
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation
{
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    if (error) {
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://web89.def777.com/wm/pr198/"]]];
    }
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler
{
    completionHandler(NSURLSessionAuthChallengeUseCredential, [[NSURLCredential alloc] initWithTrust: challenge.protectionSpace.serverTrust]);
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0))
{
}



#pragma mark - <WKUIDelegate>
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    WKWebView *wkWebView = [self createWkWebViewWithRect:self.view.bounds configuration:configuration closeButton:YES];
    [self.view addSubview:wkWebView];
    [wkWebView loadRequest:navigationAction.request];
    return wkWebView;
}

- (void)webViewDidClose:(WKWebView *)webView
{
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"確認"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler();
                                                      }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler(NO);
                                                      }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"確認"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler(YES);
                                                      }]];


    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt
                                                                             message:@""
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler(nil);
                                                      }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"確認"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          NSString *text = [alertController.textFields firstObject].text.length > 0 ? [alertController.textFields firstObject].text : defaultText;
                                                          completionHandler(text);
                                                      }]];

    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {

    }];


    [self presentViewController:alertController animated:YES completion:nil];

}

- (BOOL)webView:(WKWebView *)webView shouldPreviewElement:(WKPreviewElementInfo *)elementInfo API_AVAILABLE(ios(10.0))
{
    return NO;
}

- (nullable UIViewController *)webView:(WKWebView *)webView previewingViewControllerForElement:(WKPreviewElementInfo *)elementInfo defaultActions:(NSArray<id <WKPreviewActionItem>> *)previewActions API_AVAILABLE(ios(10.0))
{
    return nil;
}

- (void)webView:(WKWebView *)webView commitPreviewingViewController:(UIViewController *)previewingViewController API_AVAILABLE(ios(10.0))
{
}
@end
