//
//  NSArray+Crash.m
//  Crash
//
//  Created by cc on 2018/12/24.
//  Copyright © 2018 test. All rights reserved.
//



#import "NSArray+Crash.h"
#import <objc/runtime.h>
#import <CCExceptionManager.h>
#import "NSObject+Swlzzing.h"

@implementation NSArray (Crash)

+ (void)load
{
    [super load];
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        [NSClassFromString(@"__NSArrayI") swizzleMethod:@selector(objectAtIndexedSubscript:) withMethod:@selector(objectAtSafeIndexedSubscript:)];


        [NSClassFromString(@"__NSPlaceholderArray") swizzleMethod:@selector(initWithObjects:count:) withMethod:@selector(safeInitWithObjects:count:)];
        

        [NSClassFromString(@"__NSArrayI") swizzleMethod:@selector(initWithObjects:count:) withMethod:@selector(safeInitWithObjects:count:)];


        
        //替换不可变数组方法
        [NSClassFromString(@"__NSArrayI") swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(objectAtSafeIndex:)];
        
        
    });
    
}


- (id)objectAtSafeIndexedSubscript:(NSUInteger)index{
    
    if (index > self.count - 1 || !self.count) {
        @try {
            return [self objectAtSafeIndexedSubscript:index];
        }
        @catch (NSException *exception) {
            [[CCExceptionManager sharedInstance] handlerException:exception];
            return nil;
        }
        
    }else {
        return [self objectAtSafeIndexedSubscript:index];
    }
}

- (id)objectAtSafeIndex:(NSUInteger)index
{
    
    
    if (index > self.count - 1 || !self.count) {
        @try {
            return [self objectAtSafeIndex:index];
        }
        @catch (NSException *exception) {
            
            [[CCExceptionManager sharedInstance] handlerException:exception];
            return nil;
        }

    }else {
        return [self objectAtSafeIndex:index];
    }
}




- (instancetype)safeInitWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt{
    
    BOOL isSafe = YES;
    
    for (int i = 0; i < cnt; i++) {
        id obj = objects[i];
        if (!obj) {
            isSafe = NO;
            break;
        }
    }
    
    if (!isSafe) {
        @try {
            return [self safeInitWithObjects:objects count:cnt];
        } @catch (NSException *exception) {
            [[CCExceptionManager sharedInstance] handlerException:exception];
            return nil;
        } @finally {
            return nil;
        }
        
    }else{
        return [self safeInitWithObjects:objects count:cnt];
    }
    
}

@end

