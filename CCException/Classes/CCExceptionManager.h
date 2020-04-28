//
//  CCExceptionManager.h
//  Crash
//
//  Created by cc on 2018/12/27.
//  Copyright © 2018 test. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CCExceptionManager;

@protocol CCExceptionProtocol <NSObject>

@required

- (void)handlerExceptionManager:(CCExceptionManager *)mgr
                      exception:(NSException *)exception;

@end


@interface CCExceptionManager : NSObject

+ (instancetype)sharedInstance;

- (void)registerExceptionHandlerObj:(id<CCExceptionProtocol>)obj;

- (void)handlerException:(NSException *)exception;


@end

NS_ASSUME_NONNULL_END
