//
//  ZZVKPostViewController.h
//  PrototypeForAvatarEditor
//
//  Created by Yevgeniya Zelenska on 8/27/13.
//  Copyright (c) 2013 Yevgeniya Zelenska. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZWebViewController.h"
#import "ZZVKActivity.h"

@interface ZZVKPostViewController : UIViewController <UITextViewDelegate>

@property (nonatomic,strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UITextView *textView;
@property (nonatomic, strong) ZZVKActivity *activity;

-(IBAction)post:(id)sender;
-(IBAction)cancel:(id)sender;
-(IBAction)logoutVK:(id)sender;

@end
