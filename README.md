ZZVKActivity
============

VK Activity is the activity for an activity view controller to be able to post text.images, URLs via VK.com.

This project uses code from https://github.com/romaonthego/REActivityViewController for authentication in VK.com.

All you need to include the library into your project is to add this pod to your project's pod file:

pod 'ZZVKActivity', :git => 'https://github.com/jennytick/ZZVKActivity.git'.

For adding ZZVKActivity to your activity view controller create it and add to your applicationActivities array:

NSArray *activityItems = @[[UIImage imageNamed:@"sad_dog.jpg"], @"Demo for VKActivity!", [NSURL URLWithString:@"https://github.com/jennytick/ZZVKActivity"]];
ZZVKActivity *VKActivity = [[ZZVKActivity alloc] initWithActivityItems:activityItems];

NSArray *applicationActivities = @[…, VKActivity, ...];

Don't forget to add:

#import <ZZVKActivity/ZZVKActivity.h>

More details you can find in demo project. 

