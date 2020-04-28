//
//  NSObject+Swlzzing.h
//  Crash
//
//  Created by cc on 2018/12/27.
//  Copyright © 2018 test. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swlzzing)




+ (BOOL)swizzleMethod:(SEL)origSel withMethod:(SEL)altSel;



+ (BOOL)swizzleClassMethod:(SEL)origSel withMethod:(SEL)altSel;



@end

NS_ASSUME_NONNULL_END
