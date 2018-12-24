//
//  GlobalConfig.m
//  GlobalJSExampleAppExtension Extension
//
//  Created by Yiming Liu on 12/24/18.
//  Copyright © 2018 Yiming Liu. All rights reserved.
//

#import "GlobalConfig.h"

@implementation GlobalConfig

@synthesize webview;

#pragma mark Singleton Methods

+ (id)sharedConfig {
    static GlobalConfig *sharedConfig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedConfig = [[self alloc] init];
    });
    return sharedConfig;
}

- (id)init {
    if (self = [super init]) {
        webview = nil;
    }
    return self;
}

- (void)dealloc {
    
}

@end
