//
//  ZZVKPostViewController.m
//  PrototypeForAvatarEditor
//
//  Created by Yevgeniya Zelenska on 8/27/13.
//  Copyright (c) 2013 Yevgeniya Zelenska. All rights reserved.
//

#import "ZZVKPostViewController.h"

@interface ZZVKPostViewController ()

@end

@implementation ZZVKPostViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageView.image = self.activity.sharedImage;
    self.textView.textAlignment = NSTextAlignmentCenter;
    self.textView.text = self.activity.sharedText;
    self.textView.delegate = self;
    [self.view reloadInputViews];
}   

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - IBActions

-(void)post:(id)sender{
    self.activity.sharedText = self.textView.text;
    self.activity.sharedImage = self.imageView.image;
    [self dismissViewControllerAnimated:YES completion:^(){
        [self.activity post];
    }];
}

-(void)cancel:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)logoutVK:(id)sender{
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for(NSHTTPCookie *cookie in [cookieStorage cookies]){
        [cookieStorage deleteCookie:cookie];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.activity.token = nil;
    self.activity.userID = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TextView delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

@end
