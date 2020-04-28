//
//  NSMutableArray+Crash.m
//  Crash
//
//  Created by cc on 2018/12/24.
//  Copyright © 2018 test. All rights reserved.
//

#import "NSMutableArray+Crash.h"
#import <objc/runtime.h>
#import "CCExceptionManager.h"
#import "NSObject+Swlzzing.h"

@implementation NSMutableArray (Crash)

+ (void)load{
    [super load];
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [NSClassFromString(@"__NSArrayM") swizzleMethod:@selector(insertObject:atIndex:) withMethod:@selector(insertSafeObject:atIndex:)];
        
        [NSClassFromString(@"__NSArrayM") swizzleMethod:@selector(setObject:atIndexedSubscript:) withMethod:@selector(setSafeObject:atIndexedSubscript:)];
        
        
        //替换可变数组方法
        [NSClassFromString(@"__NSArrayM") swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(mutableObjectAtSafeIndex:)];
        
        
        [NSClassFromString(@"__NSArrayM") swizzleMethod:@selector(objectAtIndexedSubscript:) withMethod:@selector(mutableObjectAtSafeIndexedSubscript:)];
        
        
    });
    
    
    
}

- (void)setSafeObject:(id)obj atIndexedSubscript:(NSUInteger)idx{
    
    if (!obj) {
        @try {
            [self setSafeObject:obj atIndexedSubscript:idx];
        } @catch (NSException *exception) {
            [[CCExceptionManager sharedInstance] handlerException:exception];
        } @finally {
            
        }
    }else{
        [self setSafeObject:obj atIndexedSubscript:idx];
    }
    
}


- (void)insertSafeObject:(id)object atIndex:(NSUInteger)index{
    
    if (!object) {
        @try {
            [self insertSafeObject:object atIndex:index];
        } @catch (NSException *exception) {
            
            [[CCExceptionManager sharedInstance] handlerException:exception];
        }
    }else{
        [self insertSafeObject:object atIndex:index];
    }
    
}


- (id)mutableObjectAtSafeIndexedSubscript:(NSUInteger)index{
    
    if (index > self.count - 1 || !self.count) {
        @try {
            return [self mutableObjectAtSafeIndexedSubscript:index];
        }
        @catch (NSException *exception) {
            
            [[CCExceptionManager sharedInstance] handlerException:exception];
            return nil;
        }
        
    }else {
        return [self mutableObjectAtSafeIndexedSubscript:index];
    }
}

- (id)mutableObjectAtSafeIndex:(NSUInteger)index
{
    if (index > self.count - 1 || !self.count) {
        @try {
            return [self mutableObjectAtSafeIndex:index];
        }
        @catch (NSException *exception) {
            
            [[CCExceptionManager sharedInstance] handlerException:exception];
            return nil;
        }
        
    }else {
        return [self mutableObjectAtSafeIndex:index];
    }
}




@end
