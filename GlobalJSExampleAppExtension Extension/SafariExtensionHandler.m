//
//  SafariExtensionHandler.m
//  GlobalJSExampleAppExtension Extension
//
//  Created by Yiming Liu on 12/24/18.
//  Copyright © 2018 Yiming Liu. All rights reserved.
//

#import "SafariExtensionHandler.h"
#import "SafariExtensionViewController.h"
#import "GlobalConfig.h"

@interface SafariExtensionHandler ()

@end

@implementation SafariExtensionHandler

- (void)messageReceivedWithName:(NSString *)messageName fromPage:(SFSafariPage *)page userInfo:(NSDictionary *)userInfo {
    // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
//    [page getPagePropertiesWithCompletionHandler:^(SFSafariPageProperties *properties) {
//        NSLog(@"The extension received a message (%@) from a script injected into (%@) with userInfo (%@)", messageName, properties.url, userInfo);
//    }];
    if ([messageName isEqualToString:@"init-world"])
    {
        // create a webview and load global.html/global.js
        GlobalConfig *sharedConfig = [GlobalConfig sharedConfig];
        if (!sharedConfig.webview)
        {
            NSString* filePath = [[NSBundle mainBundle] pathForResource:@"global" ofType:@"html"];
            NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
            sharedConfig.webview = [[WKWebView alloc] initWithFrame:CGRectZero];
            sharedConfig.webview.navigationDelegate = self;
            [sharedConfig.webview loadFileURL:[NSURL fileURLWithPath:filePath] allowingReadAccessToURL:[NSURL fileURLWithPath:bundlePath]];
        }
    }
}

- (void)toolbarItemClickedInWindow:(SFSafariWindow *)window {
    // This method will be called when your toolbar item is clicked.
    NSLog(@"The extension's toolbar item was clicked");
    // find and load the global.html file from the extension bundle
    GlobalConfig *sharedConfig = [GlobalConfig sharedConfig];
    if (sharedConfig.webview)
    {
        // call a function from global.html
        [sharedConfig.webview evaluateJavaScript:@"test2(\"hello from global\");" completionHandler:^(id Result, NSError * error) {
            NSLog(@"%@",[NSString stringWithFormat:@"%@", Result]);
            NSLog(@"Error -> %@", error);
            [SFSafariApplication getActiveWindowWithCompletionHandler:^(SFSafariWindow * _Nullable activeWindow) {
                [activeWindow getActiveTabWithCompletionHandler:^(SFSafariTab * _Nullable activeTab) {
                    [activeTab getActivePageWithCompletionHandler:^(SFSafariPage * _Nullable activePage) {
                        // this is deliberately complex, to test out dictionary return values from JS.  You can also just return simple strings
                        [activePage dispatchMessageToScriptWithName:@"global-js-message" userInfo:@{@"value":[(NSDictionary *)Result objectForKey:@"result"]}];
                    }];
                }];
            }];
        }];
    }
    
}

- (void)validateToolbarItemInWindow:(SFSafariWindow *)window validationHandler:(void (^)(BOOL enabled, NSString *badgeText))validationHandler {
    validationHandler(YES, nil);
}

- (SFSafariExtensionViewController *)popoverViewController {
    return [SafariExtensionViewController sharedController];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"Succesfully loaded global.html");
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"Navigation error %@", error);
}

@end
