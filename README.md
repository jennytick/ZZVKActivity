ZZVKActivity
============

ZZVKActivity enables you to post text, images, URLs via VK.com.

This project uses code from https://github.com/romaonthego/REActivityViewController for authentication in VK.com.

Include
=======

To include ZZVKActivity into your project add next line to your project's Podfile:

```
pod 'ZZVKActivity', :git => 'https://github.com/jennytick/ZZVKActivity.git'
```

Usage
=====

To add ZZVKActivity to your activity view controller create it:

```
#import <ZZVKActivity/ZZVKActivity.h>
...
NSArray *activityItems = @[[UIImage imageNamed:@"sad_dog.jpg"], @"Demo for VKActivity!", [NSURL URLWithString:@"https://github.com/jennytick/ZZVKActivity"]];
...
```

Then add  created ZZVKActivity to the applicationActivities array:

```
...
ZZVKActivity *VKActivity = [[ZZVKActivity alloc] initWithActivityItems:activityItems];
NSArray *applicationActivities = @[..., VKActivity, ...];
...
```

More details you can find in the demo project. 

License
=======

This code is free to use under the terms of the MIT license.
