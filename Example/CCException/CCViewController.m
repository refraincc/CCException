//
//  CCViewController.m
//  CCException
//
//  Created by refrainc21@gmail.com on 04/28/2020.
//  Copyright (c) 2020 refrainc21@gmail.com. All rights reserved.
//

#import "CCViewController.h"
#import <CCException/CCExceptionManager.h>
#import <CCException/NSArray+Crash.h>
#import "CCArray.h"
#import <objc/runtime.h>

@interface CCViewController ()<CCExceptionProtocol>

@end

@implementation CCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[CCExceptionManager sharedInstance] registerExceptionHandlerObj:self];
    

    NSString *unsafeObj = nil;
    
    
    NSMutableDictionary *mutableDict = @{@"1" : unsafeObj}.mutableCopy;

    [mutableDict setObject:unsafeObj forKey:@"2"];

    NSArray *aArray = @[@"0", @"1", @"2"];

    id element = aArray[3];

    
    NSArray *bArray = @[@"0", unsafeObj, @"2"];
    
    NSMutableArray *cArray = [NSMutableArray array];
    
    [cArray setObject:unsafeObj atIndexedSubscript:0];
    
    [cArray insertObject:unsafeObj atIndex:0];
    
    [cArray addObject:unsafeObj];
    
    cArray[99];
    
}

- (void)handlerExceptionManager:(CCExceptionManager *)mgr exception:(NSException *)exception{
    
    // upload exception
    
    
}

@end
