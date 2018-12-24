//
//  SafariExtensionViewController.m
//  GlobalJSExampleAppExtension Extension
//
//  Created by Yiming Liu on 12/24/18.
//  Copyright © 2018 Yiming Liu. All rights reserved.
//

#import "SafariExtensionViewController.h"

@interface SafariExtensionViewController ()

@end

@implementation SafariExtensionViewController

+ (SafariExtensionViewController *)sharedController {
    static SafariExtensionViewController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [[SafariExtensionViewController alloc] init];
        sharedController.preferredContentSize = NSMakeSize(320, 240);
    });
    return sharedController;
}

@end
