//
//  ViewController.m
//  GlobalJSExampleAppExtension
//
//  Created by Yiming Liu on 12/24/18.
//  Copyright © 2018 Yiming Liu. All rights reserved.
//

#import "ViewController.h"
#import <SafariServices/SFSafariApplication.h>

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appNameLabel.stringValue = @"GlobalJSExampleAppExtension";
}

- (IBAction)openSafariExtensionPreferences:(id)sender {
    [SFSafariApplication showPreferencesForExtensionWithIdentifier:@"com.yimingliu.GlobalJSExampleAppExtension-Extension" completionHandler:^(NSError * _Nullable error) {
        if (error) {
            // Insert code to inform the user something went wrong.
        }
    }];
}

@end
