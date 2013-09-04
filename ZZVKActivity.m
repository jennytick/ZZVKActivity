//
//  ZZVKActivity.m
//  PrototypeForAvatarEditor
//
//  Created by Yevgeniya Zelenska on 8/26/13.
//  Copyright (c) 2013 Yevgeniya Zelenska. All rights reserved.
//

#import "ZZVKActivity.h"
#import "ZZWebViewController.h"
#import "AFNetworking.h"
#import "ZZVKPostViewController.h"

@implementation ZZVKActivity

-(id)initWithActivityItems:(NSArray *)activityItems{
    self = [super init];
    if(self){
        for(NSObject *obj in activityItems)
            if([obj isKindOfClass:[UIImage class]])
                self.sharedImage = (UIImage *)obj;
            else if([obj isKindOfClass:[NSURL class]])
                self.sharedURL = (NSURL *)obj;
            else if([obj isKindOfClass:[NSString class]])
                self.sharedText = (NSString *)obj;
    }
    return self;
}

-(NSString *)activityTitle{
    return @"VK";
}

-(UIImage *)activityImage{
    return [UIImage imageNamed:@"Icon_VK.png"];
}

-(BOOL)canPerformWithActivityItems:(NSArray *)activityItems{
    return YES;
}

-(UIViewController *)activityViewController{
    if(!self.token){
        ZZWebViewController *webViewController = [[ZZWebViewController alloc] init];
        webViewController.activity = self;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:webViewController];
        return navigationController;
    } else {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        ZZVKPostViewController *VKPostViewController = [storyBoard instantiateViewControllerWithIdentifier:@"VKPostViewController"];
        VKPostViewController.activity = self;
        return VKPostViewController;
    }
}

#pragma mark - VK sharing

-(void)shareInViewController:(UIActivityViewController *)controller{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    ZZVKPostViewController *VKPostViewController = [storyBoard instantiateViewControllerWithIdentifier:@"VKPostViewController"];
    VKPostViewController.activity = self;
    [controller presentViewController:VKPostViewController animated:YES completion:nil];
}

-(void)post{
    __typeof(&*self) __weak weakSelf = self;
    if(self.sharedImage)
        [weakSelf shareText:self.sharedText image:self.sharedImage];
    else [weakSelf shareText:self.sharedText];UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"VK sharing" message:@"Your great photo was posted on your VK wall!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}


- (void)requestPhotoUploadURLWithSuccess:(void (^)(NSString *uploadURL))success
{
    NSString *serverURL = [NSString stringWithFormat:@"https://api.vk.com/method/photos.getWallUploadServer?owner_id=%@&access_token=%@", self.userID, self.token];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:serverURL]];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if (success) {
            success([[JSON objectForKey:@"response"] objectForKey:@"upload_url"]);
        }
    } failure:nil];
    [operation start];
}

- (void)uploadImage:(UIImage *)image toURL:(NSString *)urlString success:(void (^)(NSString *hash, NSString *photo, NSString *server))success
{
    NSURL *url = [NSURL URLWithString:urlString];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.75f);
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:@"" parameters:nil
                                                    constructingBodyWithBlock:^(id <AFMultipartFormData>formData) {
                                                        [formData appendPartWithFileData:imageData name:@"photo" fileName:@"photo.jpg" mimeType:@"image/jpg"];
                                                    }];
    
    void (^parseJSON)(id JSON) = ^(id JSON){
        if (success)
            success([JSON objectForKey:@"hash"], [JSON objectForKey:@"photo"], [JSON objectForKey:@"server"]);
    };
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        parseJSON(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        parseJSON(JSON);
    }];
    [operation start];
}

- (void)saveImageToWallWithHash:(NSString *)hash photo:(NSString *)photo server:(NSString *)server success:(void (^)(NSString *wallPhotoId))success
{
    NSString *serverURL = [NSString stringWithFormat:@"https://api.vk.com/method/photos.saveWallPhoto?owner_id=%@&access_token=%@&server=%@&photo=%@&hash=%@", self.userID, self.token, server, photo, hash];
    NSString *escapedURL = [serverURL stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:escapedURL]];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if (success)
            success([[[JSON objectForKey:@"response"] objectAtIndex:0] objectForKey:@"id"]);
    } failure:nil];
    [operation start];
}

- (void)shareOnWall:(NSString *)text photoId:(NSString *)wallPhotoId completion:(void (^)(void))completion
{
    NSString *serverURL;
    
    if (wallPhotoId) {
        serverURL = [NSString stringWithFormat:@"https://api.vk.com/method/wall.post?owner_id=%@&access_token=%@&message=%@&attachment=%@", self.userID, self.token, [self URLEncodedString:text], wallPhotoId];
    } else {
        serverURL = [NSString stringWithFormat:@"https://api.vk.com/method/wall.post?owner_id=%@&access_token=%@&message=%@", self.userID, self.token, [self URLEncodedString:text]];
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:serverURL]];
    
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if (completion)
            completion();
    } failure:nil];
    [operation start];
}

- (void)shareText:(NSString *)text image:(UIImage *)image
{
    __typeof(&*self) __weak weakSelf = self;
    
    [self requestPhotoUploadURLWithSuccess:^(NSString *uploadURL) {
        [weakSelf uploadImage:image toURL:uploadURL success:^(NSString *hash, NSString *photo, NSString *server) {
            [weakSelf saveImageToWallWithHash:hash photo:photo server:server success:^(NSString *wallPhotoId) {
                [weakSelf shareOnWall:text photoId:wallPhotoId completion:nil];
            }];
        }];
    }];
}

- (void)shareText:(NSString *)text
{
    [self shareOnWall:text photoId:nil completion:nil];
}

#pragma mark - Helper

- (NSString *)URLEncodedString:(NSString *)str
{
    NSString *result = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
																							 (CFStringRef)str,
																							 NULL,
																							 CFSTR("!*'();:@&=+$,/?%#[]"),
																							 kCFStringEncodingUTF8);
	return result;
}

@end
