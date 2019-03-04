//
//  LayerLook.mm
//  LayerLook
//
//  Created by 李向阳 on 2019/2/23.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

// CaptainHook by Ryan Petrich
// see https://github.com/rpetrich/CaptainHook/

#if TARGET_OS_SIMULATOR
#error Do not support the simulator, please use the real iPhone Device.
#endif

#import <UIKit/UIKit.h>

@interface NSObject(LayerLook)

+ (instancetype)sharedManager;
- (void)showExplorer;

@end

@implementation NSObject(LayerLook)

+ (void)load
{
    [[NSNotificationCenter defaultCenter] addObserverForName:UIWindowDidBecomeVisibleNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        UIWindow *window = note.object;
        UILongPressGestureRecognizer *lp = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showDebug:)];
        lp.numberOfTouchesRequired = 4;
        [window addGestureRecognizer:lp];
    }];
}

+ (void)showDebug:(UILongPressGestureRecognizer *)lp
{
    if (lp.state == UIGestureRecognizerStateBegan) {
        Class manager = NSClassFromString(@"FLEXManager");
        [[manager sharedManager] showExplorer];
    }
}

@end
