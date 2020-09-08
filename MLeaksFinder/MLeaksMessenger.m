/**
 * Tencent is pleased to support the open source community by making MLeaksFinder available.
 *
 * Copyright (C) 2017 THL A29 Limited, a Tencent company. All rights reserved.
 *
 * Licensed under the BSD 3-Clause License (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
 *
 * https://opensource.org/licenses/BSD-3-Clause
 *
 * Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
 */

#import "MLeaksMessenger.h"

static __weak UIAlertView *alertView;

@implementation MLeaksMessenger

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message {
    [self alertWithTitle:title message:message delegate:nil additionalButtonTitle:nil];
}

//+ (void)alertWithTitle:(NSString *)title
//               message:(NSString *)message
//              delegate:(id<UIAlertViewDelegate>)delegate
// additionalButtonTitle:(NSString *)additionalButtonTitle {
//    [alertView dismissWithClickedButtonIndex:0 animated:NO];
//    UIAlertView *alertViewTemp = [[UIAlertView alloc] initWithTitle:title
//                                                            message:message
//                                                           delegate:delegate
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:additionalButtonTitle, nil];
//    [alertViewTemp show];
//    alertView = alertViewTemp;
//
//    NSLog(@"%@: %@", title, message);
//}
+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
              delegate:(id<UIAlertViewDelegate>)delegate
 additionalButtonTitle:(NSString *)additionalButtonTitle {
//    [alertView dismissWithClickedButtonIndex:0 animated:NO];
//    UIAlertView *alertViewTemp = [[UIAlertView alloc] initWithTitle:title
//                                                            message:message
//                                                           delegate:delegate
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:additionalButtonTitle, nil];
//    [alertViewTemp show];
//
//    alertView = alertViewTemp;
//
//    NSLog(@"%@: %@", title, message);
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cfa = [UIAlertAction actionWithTitle:additionalButtonTitle style:UIAlertActionStyleDefault handler:nil];
        [ac addAction:cfa];
        UIViewController *svc = nil;
        if (@available(iOS 13.0,*)){
            UIWindow *keyWindow = nil;
            for (UIWindowScene *ws in UIApplication.sharedApplication.connectedScenes) {
                if (!keyWindow)
                {
                    if (ws.activationState == UISceneActivationStateForegroundActive || UIApplication.sharedApplication.connectedScenes.count == 1){
                        for (UIWindow *w in ws.windows) {
                            if (w.isKeyWindow || UIApplication.sharedApplication.connectedScenes.count == 1){
                                keyWindow = w;
                                break;
                            }
                        }
                    }
                }
            }
            svc = keyWindow.rootViewController;
        }else{
            svc = UIApplication.sharedApplication.keyWindow.rootViewController;
        }
        while (svc.presentedViewController != nil){
            svc = svc.presentedViewController;
        }
        [svc presentViewController:ac animated:true completion:nil];
        NSLog(@"%@: %@", title, message);
    });
}
@end
