//
//  LayerLookLoader.mm
//  LayerLookLoader
//
//  Created by lixy on 2019/5/20.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

// CaptainHook by Ryan Petrich
// see https://github.com/rpetrich/CaptainHook/

#if TARGET_OS_SIMULATOR
#error Do not support the simulator, please use the real iPhone Device.
#endif

#import <Foundation/Foundation.h>
#import "CaptainHook/CaptainHook.h"
#include <dlfcn.h>
#import <UIKit/UIKit.h>

CHConstructor // code block that runs immediately upon load
{
    @autoreleasepool
    {
        NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.lixy.LayerLook.plist"];
        NSString *libraryPath = @"/var/mobile/Library/DynamicLibraries/LayerLook.dylib";
        if([[prefs objectForKey:[NSString stringWithFormat:@"LayerLookEnabled-%@", [[NSBundle mainBundle] bundleIdentifier]]] boolValue]) {
            if ([[NSFileManager defaultManager] fileExistsAtPath:libraryPath]){
                void *addr = dlopen([libraryPath UTF8String], RTLD_NOW);
                if(addr){
                    NSLog(@"LayerLook loaded %@ successed, address %p", libraryPath,addr);
                } else{
                    NSLog(@"LayerLook loaded %@ failed, address %p", libraryPath,addr);
                }
            }
        }
    }
}
