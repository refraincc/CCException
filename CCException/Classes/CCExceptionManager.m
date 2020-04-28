//
//  BDExceptionCollectManager.m
//  Crash
//
//  Created by cc on 2018/12/27.
//  Copyright © 2018 test. All rights reserved.
//

#import "CCExceptionManager.h"


@interface CCExceptionManager ()

@property (nonatomic, weak)id<CCExceptionProtocol> obj;

@end


@implementation CCExceptionManager

+ (instancetype)sharedInstance{
    static CCExceptionManager *mgr;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [[CCExceptionManager alloc] init];
    });
    return mgr;
}


- (void)registerExceptionHandlerObj:(id<CCExceptionProtocol>)obj{
    self.obj = obj;
}


- (void)handlerException:(NSException *)exception{
    
    if (!self.obj) return;
    
    [self.obj handlerExceptionManager:self exception:exception];
    
}


@end
