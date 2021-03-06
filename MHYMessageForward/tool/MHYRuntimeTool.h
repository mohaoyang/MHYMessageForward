//
//  MHYRuntimeTool.h
//  MHYMessageForward
//
//  Created by jshtmhy on 2018/2/11.
//  Copyright © 2018年 jshtmhy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHYRuntimeTool : NSObject
/**
 获取类的元类
 
 @param TargetClass 目标类别
 @return 返回元类
 */
+(Class)getMetaClassWithTargetClass:(Class)targetClass;

/**
 对一个类添加对象方法
 
 @param class 目标类
 @param methodSel 获取方法名的SEL
 @param impMethodSel 实现方法的SEL用于获取实现方法的IMP
 */
+(void)addMethodWithClass:(Class)class withMethodSel:(SEL)methodSel withImpMethodSel:(SEL)impMethodSel;
@end
