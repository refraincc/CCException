//
//  NSMutableDictionary+Crash.m
//  Crash
//
//  Created by cc on 2018/12/24.
//  Copyright © 2018 test. All rights reserved.
//

#import "NSMutableDictionary+Crash.h"
#import <objc/runtime.h>
#import "CCExceptionManager.h"
#import "NSObject+Swlzzing.h"

@implementation NSMutableDictionary (Crash)


+ (void)load{
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [NSClassFromString(@"__NSDictionaryM") swizzleMethod:@selector(setObject:forKey:) withMethod:@selector(setSafeObject:forKey:)];
    });
}



- (void)setSafeObject:(id)anObject forKey:(id<NSCopying>)aKey{
    if (!anObject) {
        
        @try {
            [self setSafeObject:anObject forKey:aKey];
        } @catch (NSException *exception) {
        
            [[CCExceptionManager sharedInstance] handlerException:exception];
            
        }
    }else{
        [self setSafeObject:anObject forKey:aKey];
    }
}

@end
