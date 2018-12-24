//
//  SafariExtensionViewController.h
//  GlobalJSExampleAppExtension Extension
//
//  Created by Yiming Liu on 12/24/18.
//  Copyright © 2018 Yiming Liu. All rights reserved.
//

#import <SafariServices/SafariServices.h>

@interface SafariExtensionViewController : SFSafariExtensionViewController

+ (SafariExtensionViewController *)sharedController;

@end
