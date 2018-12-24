//
//  GlobalConfig.h
//  GlobalJSExampleAppExtension Extension
//
//  Created by Yiming Liu on 12/24/18.
//  Copyright © 2018 Yiming Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GlobalConfig : NSObject
{
    WKWebView* webview;
    
}

@property (nonatomic, retain) WKWebView *webview;

+ (id)sharedConfig;

@end

NS_ASSUME_NONNULL_END
