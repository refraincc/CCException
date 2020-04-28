//
//  NSObject+Swlzzing.m
//  Crash
//
//  Created by cc on 2018/12/27.
//  Copyright © 2018 test. All rights reserved.
//

#import "NSObject+Swlzzing.h"
#import <objc/runtime.h>

@implementation NSObject (Swlzzing)



+ (BOOL)swizzleMethod:(SEL)origSel withMethod:(SEL)altSel {
    Method origMethod = class_getInstanceMethod(self, origSel);
    Method altMethod = class_getInstanceMethod(self, altSel);
    if (!origMethod || !altMethod) {
        return NO;
    }
    class_addMethod(self,
                    origSel,
                    class_getMethodImplementation(self, origSel),
                    method_getTypeEncoding(origMethod));
    class_addMethod(self,
                    altSel,
                    class_getMethodImplementation(self, altSel),
                    method_getTypeEncoding(altMethod));
    method_exchangeImplementations(class_getInstanceMethod(self, origSel),
                                   class_getInstanceMethod(self, altSel));
    return YES;
}



+ (BOOL)swizzleClassMethod:(SEL)origSel withMethod:(SEL)altSel {
    return [object_getClass((id)self) swizzleMethod:origSel withMethod:altSel];
}


@end
