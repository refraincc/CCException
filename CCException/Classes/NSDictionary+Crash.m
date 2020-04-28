//
//  NSDictionary+Crash.m
//  Crash
//
//  Created by cc on 2018/12/25.
//  Copyright © 2018 test. All rights reserved.
//

#import "NSDictionary+Crash.h"
#import <objc/runtime.h>
#import "NSObject+Swlzzing.h"
#import "CCExceptionManager.h"

@implementation NSDictionary (Crash)

+ (void)load{
    [super load];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        [NSClassFromString(@"__NSPlaceholderDictionary") swizzleMethod:@selector(initWithObjects:forKeys:count:) withMethod:@selector(initWithSafeObjects:forKeys:count:)];


        [object_getClass((id)self) swizzleMethod:@selector(dictionaryWithObjects:forKeys:count:) withMethod:@selector(dictionarySafeWithObjects:forKeys:count:)];
    });
    
    
}


- (instancetype)initWithSafeObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt {
    
    
    
    if (objects) {
        @try {
            return  [self initWithSafeObjects:objects forKeys:keys count:cnt];
        } @catch (NSException *exception) {
            
            [[CCExceptionManager sharedInstance] handlerException:exception];
        }
    }else{
        return   [self initWithSafeObjects:objects forKeys:keys count:cnt];
    }
    return self;
}

+ (instancetype)dictionarySafeWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt{
    if (objects) {
        @try {
            return [self dictionarySafeWithObjects:objects forKeys:keys count:cnt];
        } @catch (NSException *exception) {
            
            [[CCExceptionManager sharedInstance] handlerException:exception];
        }
    }else{
        return [self dictionarySafeWithObjects:objects forKeys:keys count:cnt];
    }
}



@end
