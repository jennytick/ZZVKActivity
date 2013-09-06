//
//  ZZWebViewController.h
//  PrototypeForAvatarEditor
//
//  Created by Yevgeniya Zelenska on 8/28/13.
//  Copyright (c) 2013 Yevgeniya Zelenska. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZVKActivity.h"

@interface ZZWebViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) ZZVKActivity *activity;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic) BOOL wasLoaded;

-(void)dismiss;

@end
