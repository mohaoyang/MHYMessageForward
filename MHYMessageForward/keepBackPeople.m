//
//  keepBackPeople.m
//  MHYMessageForward
//
//  Created by jshtmhy on 2018/2/11.
//  Copyright © 2018年 jshtmhy. All rights reserved.
//

#import "keepBackPeople.h"

@implementation keepBackPeople
-(void)speak{
    NSLog(@"备用类的对象方法speak");
    self.name = @"pdd";
    NSLog(@"%@",self.name);
}

@end
