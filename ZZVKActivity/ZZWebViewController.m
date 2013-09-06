//
//  ZZWebViewController.m
//  PrototypeForAvatarEditor
//
//  Created by Yevgeniya Zelenska on 8/28/13.
//  Copyright (c) 2013 Yevgeniya Zelenska. All rights reserved.
//

#import "ZZWebViewController.h"
#import "ZZVKPostViewController.h"

@interface ZZWebViewController ()

@end

@implementation ZZWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc]
                               initWithTitle:@"Cancel"
                               style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    self.navigationItem.leftBarButtonItem = cancel;
    
    UIWebView *VKWebView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.webView = VKWebView;
    VKWebView.autoresizesSubviews = YES;
    VKWebView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    VKWebView.delegate = self;

    [self.view addSubview:VKWebView];
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.wasLoaded = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(!self.wasLoaded){
        static int APP_ID = 3843780;
        NSURLRequest *authRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://oauth.vk.com/authorize?client_id=%d&scope=wall,photos&redirect_uri=http://oauth.vk.com/blank.html&display=touch&response_type=token", APP_ID]]];
        [self.webView loadRequest:authRequest];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)createPostPreviewController{
    
}

-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Web view delegate

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"Web view loading failed with error %@", error);
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *url = request.URL.absoluteString;
    NSRange searchRange = NSMakeRange(0, url.length);
    NSRange foundRange = [url rangeOfString:@"access_token" options:0 range:searchRange];
    if (foundRange.location != NSNotFound) {
        NSArray *items = [url componentsSeparatedByString:@"="];
        items = [[items objectAtIndex:1] componentsSeparatedByString:@"&"];
        NSString *token = [items objectAtIndex:0];
        
        NSArray *userAr = [url componentsSeparatedByString:@"&user_id="];
        NSString *userId = [userAr lastObject];
        
        self.activity.token = token;
        self.activity.userID = userId;
        
        if (!self.activity.sharedText && self.activity.sharedURL)
            self.activity.sharedText = self.activity.sharedURL.absoluteString;
        
        if (self.activity.sharedText && self.activity.sharedURL)
            self.activity.sharedText = [NSString stringWithFormat:@"%@ %@", self.activity.sharedText, self.activity.sharedURL.absoluteString];
        
        UIActivityViewController *presentingViewController = (UIActivityViewController *)self.presentingViewController;
        [self dismissViewControllerAnimated:YES completion:^(){
            [self.activity shareInViewController:presentingViewController];
        }];
        
        return NO;
    }
    
    return YES;
}

@end
