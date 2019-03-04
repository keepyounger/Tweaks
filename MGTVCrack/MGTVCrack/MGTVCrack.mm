//
//  MGTVCrack.mm
//  MGTVCrack
//
//  Created by lixy on 2019/2/25.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

// CaptainHook by Ryan Petrich
// see https://github.com/rpetrich/CaptainHook/

#if TARGET_OS_SIMULATOR
#error Do not support the simulator, please use the real iPhone Device.
#endif

#import <Foundation/Foundation.h>
#import "CaptainHook/CaptainHook.h"

// 去广告功能来自 https://github.com/BackNotGod/MGDropAD

CHDeclareClass(MGVODView)

CHOptimizedMethod4(self, void, MGVODView, requestADsWithVideoId,id,arg1,pcUrl,id,arg2,clipId,id,arg3,params,id,arg4){
    NSData* jsonData = [(NSString*)arg4 dataUsingEncoding:kCFStringEncodingUTF8];
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:nil];
    [dic[@"v"] setValue:@1 forKey:@"vip"];
    NSError *parseError = nil;
    NSData * jsonData_s = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString* arg4s = [[NSString alloc] initWithData:jsonData_s encoding:NSUTF8StringEncoding];
    CHSuper4(MGVODView, requestADsWithVideoId, arg1, pcUrl, arg2, clipId, arg3, params, arg4s);
}

CHConstructor{
    
    CHLoadLateClass(MGVODView);
    CHClassHook4(MGVODView, requestADsWithVideoId, pcUrl, clipId, params);

}
