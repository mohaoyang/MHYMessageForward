//
//  ViewController.m
//  MHYMessageForward
//
//  Created by jshtmhy on 2018/2/11.
//  Copyright © 2018年 jshtmhy. All rights reserved.
//

#import "ViewController.h"
#import "MHYPeople.h"
#import <objc/runtime.h>
@interface ViewController ()
@property (nonatomic,strong) MHYPeople *people;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /******类方法调用******/
//    [[MHYPeople class] performSelector:@selector(speakClass)];
    
    //类方法触发resolveClassMethod方法来判断是否能响应SEL
    
    /******对象方法调用******/
    [self.people performSelector:@selector(speak)];
    
    //对象方法触发resolveInstanceMethod方法来判断是否能响应SEL
}


- (MHYPeople *)people{
    if (_people ==nil) {
        _people = [[MHYPeople alloc]init];
    }
    return _people;
}
@end
