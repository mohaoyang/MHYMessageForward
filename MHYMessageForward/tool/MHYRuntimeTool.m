//
//  MHYRuntimeTool.m
//  MHYMessageForward
//
//  Created by jshtmhy on 2018/2/11.
//  Copyright © 2018年 jshtmhy. All rights reserved.
//

#import "MHYRuntimeTool.h"
#import <objc/runtime.h>

@implementation MHYRuntimeTool

+ (Class)getMetaClassWithTargetClass:(Class)targetClass {
    //转换是字符串类别
    const char *classChar = [NSStringFromClass(targetClass) UTF8String];
     //需要char的字符串 获取元类
    return objc_getMetaClass(classChar);
}

+ (void)addMethodWithClass:(Class)class withMethodSel:(SEL)methodSel withImpMethodSel:(SEL)impMethodSel{
    //获取实现的方法内容
    Method funtionReaMethod = class_getInstanceMethod(class, impMethodSel);
    
    //实现方法的IMP
    IMP methodIMP = method_getImplementation(funtionReaMethod);
    
    //实现方法的类别 返回类型 携带参数等
    const char * types = method_getTypeEncoding(funtionReaMethod);
    
    //对目标添加方法
    class_addMethod(class, methodSel, methodIMP, types);
}
@end
