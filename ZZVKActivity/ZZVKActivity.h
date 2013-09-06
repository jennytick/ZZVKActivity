//
//  ZZVKActivity.h
//  PrototypeForAvatarEditor
//
//  Created by Yevgeniya Zelenska on 8/26/13.
//  Copyright (c) 2013 Yevgeniya Zelenska. All rights reserved.
//

@interface ZZVKActivity : UIActivity

@property (nonatomic, strong) UIImage *sharedImage;
@property (nonatomic, strong) NSString *sharedText;
@property (nonatomic, strong) NSURL *sharedURL;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *token;

-(id)initWithActivityItems:(NSArray *)activityItems;
-(void)shareInViewController:(UIActivityViewController *)currentActivityViewController;
-(void)post;

@end
