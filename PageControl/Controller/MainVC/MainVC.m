//
//  MainVC.m
//  PageControl
//
//  Created by keyur on 26/04/17.
//  Copyright © 2017 Keyur. All rights reserved.
//

#import "MainVC.h"

@interface MainVC ()

@end

@implementation MainVC

@synthesize mainVC;


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setTabBar{
    
    //SetTabBar View
    UIView *baseView = [[UIView alloc]init];
    baseView.frame=CGRectMake(0, 0, self.view.frame.size.width, 45);
    baseView.backgroundColor = [UIColor grayColor];

    [self.view addSubview:baseView];
    
    //SetButton
    
    UIButton *btnPageFrist =[[UIButton alloc]init];
    btnPageFrist.frame = CGRectMake(self.view.frame.origin.x + 10, 5, 120, 35);
    btnPageFrist.backgroundColor = [UIColor redColor];
    [btnPageFrist setTitle:@"Frist" forState:UIControlStateNormal];
    [self.view addSubview:btnPageFrist];
    
    
    UIButton *btnPageSecond =[[UIButton alloc]init];
    btnPageSecond.frame = CGRectMake(self.view.frame.origin.x + 240, 5, 120, 35);
    btnPageSecond.backgroundColor = [UIColor redColor];
    [btnPageSecond setTitle:@"Second" forState:UIControlStateNormal];

    [self.view addSubview:btnPageSecond];
}

@end
