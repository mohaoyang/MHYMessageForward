//
//  MHYPeople.m
//  MHYMessageForward
//
//  Created by jshtmhy on 2018/2/11.
//  Copyright © 2018年 jshtmhy. All rights reserved.
//

#import "MHYPeople.h"
#import "tool/MHYRuntimeTool.h"
#import "keepBackPeople.h"

@implementation MHYPeople
#pragma mark -消息机制的第一步，消息处理机制 判断是否接受SEL

/**
 类：如果是类方法的调用，首先会触发该类方法
 
 @param sel 传递进入的方法
 @return 如果YES则能接受消息 NO不能接受消息 进入第二步
 */

+ (BOOL)resolveClassMethod:(SEL)sel {
    //判断是否为外部调用的方法
    if([NSStringFromSelector(sel) isEqualToString:@"speakClass"]){
        /**
         对类进行添加类方法 需要将方法添加进入元类内
         */
        [MHYRuntimeTool addMethodWithClass:[MHYRuntimeTool getMetaClassWithTargetClass:[self class]] withMethodSel:sel withImpMethodSel:@selector(addClassDynamicMethod)];
        return YES;
    }
    return [super resolveClassMethod:sel];
}

/**
 对象：在接受到无法解读的消息的时候 首先会调用所属类的类方法
 
 @param sel 传递进入的方法
 @return 如果YES则能接受消息 NO不能接受消息 进入第二步
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    //判断是否为外部调用的方法
    if ([NSStringFromSelector(sel) isEqualToString:@"speak"]) {
        /**
         对类进行对象方法 需要把方法添加进入类内
         */
//        [MHYRuntimeTool addMethodWithClass:[self class] withMethodSel:sel withImpMethodSel:@selector(addDynamicMethod)];
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}
#pragma mark - 消息机制的第二步 消息转发机制
/**
 转发SEL去对象内部的其他可以响应的对象
 
 @param aSelector 需要被响应的方法SEL
 @return 返回一个可以被响应的该SEL的对象 如果返回self或者nil,则说明没有可以响应的目标 则进入第三步
 */
-(id)forwardingTargetForSelector:(SEL)aSelector{
    if ([NSStringFromSelector(aSelector) isEqualToString:@"speak"]) {
        return [keepBackPeople new];
    }
    return [super forwardingTargetForSelector:aSelector];
}

#pragma mark - 消息机制的第三步 完整的消息转发机制
//第三步的消息转发机制本质上跟第二步是一样的都是切换接受消息的对象

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    /*手动创建签名 但是尽量少使用 因为容易创建错误 可以按照这个规则来创建
        https://blog.csdn.net/ssirreplaceable/article/details/53376915
     
     //写法例子
     //例子"v@:@"
     //v@:@ v 返回值类型void;@ id类型,执行sel的对象;: SEL;@ 参数
     //例子"@@:"
     //@ 返回值类型id;@ id类型,执行sel的对象;: SEL
     
     */
    //如果返回为nil则进行手动创建签名
    if ([super methodSignatureForSelector:aSelector]==nil) {
        NSMethodSignature * sign = [NSMethodSignature signatureWithObjCTypes:"v@:"];
        return sign;
    }
    return [super methodSignatureForSelector:aSelector];
    
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    // 创建备用对象
    keepBackPeople *keepBack = [keepBackPeople new];
    SEL sel = anInvocation.selector;
    
    //判断备用对象是否可以响应传递进来等待响应的SEL
    if ([keepBackPeople respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:keepBack];
    }else {
        //如果备用对象不能响应，则抛出异常
        [self doesNotRecognizeSelector:sel];
    }
}
//上方方法如果调用返回有签名 则进入消息转发最后一步
-(void)addDynamicMethod{
    NSLog(@"动态添加方法");
}

+(void)addClassDynamicMethod{
    NSLog(@"动态添加类方法");
}
@end
