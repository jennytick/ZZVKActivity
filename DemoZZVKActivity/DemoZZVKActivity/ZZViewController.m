//
//  ZZViewController.m
//  DemoZZVKActivity
//
//  Created by Yevgeniya Zelenska on 9/6/13.
//  Copyright (c) 2013 Yevgeniya Zelenska. All rights reserved.
//

#import "ZZViewController.h"
#import <ZZVKActivity/ZZVKActivity.h>

@interface ZZViewController ()

@end

@implementation ZZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)share:(id)sender{
    NSArray *activityItems = @[[UIImage imageNamed:@"sad_dog.jpg"], @"Demo for VKActivity!", [NSURL URLWithString:@"https://github.com/jennytick/ZZVKActivity"]];
    
    ZZVKActivity *VKActivity = [[ZZVKActivity alloc] initWithActivityItems:activityItems];
    NSArray *applicationActivities = @[VKActivity];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:applicationActivities];
    activityViewController.excludedActivityTypes = @[UIActivityTypePostToWeibo, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll, UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypePostToFacebook];
    
    [self presentViewController:activityViewController animated:YES completion:nil];
}

@end
