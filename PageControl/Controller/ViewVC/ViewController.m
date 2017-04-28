//
//  ViewController.m
//  PageControl
//
//  Created by keyur on 25/04/17.
//  Copyright © 2017 Keyur. All rights reserved.
//

#import "ViewController.h"
#import "ListVC.h"
#import "MainVC.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize pageTitles =_pageTitles;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageVC"];
    self.pageViewController.dataSource = self;
    
    // Instantiate the first view controller.
    UIViewController *startingViewController = [self viewControllerAtIndex:0];
    
    [self.pageViewController setViewControllers:@[startingViewController]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:^(BOOL finished) {
                                         // Completion code
                                     }];
    
    // Add the page view controller to this root view controller.
    self.pageViewController.view.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height - 140);
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    [self setTabBar];
    
    self.title =@"Page1";

    pageControl = [[UIPageControl alloc]init];
    pageControl.frame = CGRectMake(0, self.view.frame.size.height - 35, 320, 35);
    pageControl.backgroundColor = [UIColor grayColor];
    pageControl.numberOfPages = 2;
    pageControl.pageIndicatorTintColor = [UIColor blueColor];

    pageControl.transform = CGAffineTransformMakeScale(2.9f, 2.9f);

    [self.view addSubview:pageControl];

  //  pageControl.transform = CGAffineTransformMakeScale(0.1, 0.1);

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setters and Getters

-(NSArray *)contentPageRestorationIDs
{
    if (!_pageTitles) {
        
        _pageTitles = @[@"Page1VC", @"Page2VC"];
    }
    
    return _pageTitles;
}

- (IBAction)changePage:(id)sender{
    
    
}

#pragma mark - Public Methods

- (void)goToPreviousContentViewController{
    
    self.title =@"Page1";

    // Get index of current view controller
    UIViewController *currentViewController = [self.pageViewController.viewControllers objectAtIndex:0];
    NSString *vcRestorationID = currentViewController.restorationIdentifier;
    NSUInteger index = [self.contentPageRestorationIDs indexOfObject:vcRestorationID];
    UIViewController *previousViewController = [self viewControllerAtIndex:index - 1];
    [self.pageViewController setViewControllers:@[previousViewController]
                                      direction:UIPageViewControllerNavigationDirectionReverse
                                       animated:YES
                                     completion:^(BOOL finished) {
                                         // Completion code
                                     }];
}

- (void)goToNextContentViewController {
    
    self.title =@"Page2";

    // Get index of current view controller
    UIViewController *currentViewController = [self.pageViewController.viewControllers objectAtIndex:0];
    NSString *vcRestorationID = currentViewController.restorationIdentifier;
    NSUInteger index = [self.contentPageRestorationIDs indexOfObject:vcRestorationID];
    
    UIViewController *nextViewController = [self viewControllerAtIndex:index + 1];
    
    [self.pageViewController setViewControllers:@[nextViewController]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:^(BOOL finished) {

                                     }];

}


#pragma mark - UIPageViewControllerDataSource

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return self.contentPageRestorationIDs.count;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSString *vcRestorationID = viewController.restorationIdentifier;
    NSUInteger index = [self.contentPageRestorationIDs indexOfObject:vcRestorationID];
    if (index == 0) {
        
        [pageControl setCurrentPage:index];
        pageControl.pageIndicatorTintColor = [UIColor blueColor];

        return nil;
    }
    
    return [self viewControllerAtIndex:index - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSString *vcRestorationID = viewController.restorationIdentifier;
    NSUInteger index = [self.contentPageRestorationIDs indexOfObject:vcRestorationID];
    if (index == self.contentPageRestorationIDs.count - 1) {
        
        [pageControl setCurrentPage:index];
        pageControl.pageIndicatorTintColor = [UIColor blueColor];

        return nil;
    }
    return [self viewControllerAtIndex:index + 1];
}

#pragma mark - Private Methods

#pragma mark - Private Methods

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    
    

    // Only process a valid index request.
    if (index >= self.contentPageRestorationIDs.count) {
        return nil;
    }
    
    // Create a new view controller.
    MainVC *contentViewController = (MainVC *)[self.storyboard instantiateViewControllerWithIdentifier:self.contentPageRestorationIDs[index]];
    
    // Set any data needed by the VC here
    contentViewController.mainVC = self;
    
    return contentViewController;
}

-(void)setTabBar{
    
    //SetTabBar View
    UIView *baseView = [[UIView alloc]init];
    baseView.frame=CGRectMake(0, 65, self.view.frame.size.width, 45);
    baseView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:baseView];
    
    //SetButton
    
    UIButton *btnPageFrist =[[UIButton alloc]init];
    btnPageFrist.frame = CGRectMake(self.view.frame.origin.x + 10, 5, 120, 35);
    btnPageFrist.backgroundColor = [UIColor whiteColor];
    [btnPageFrist setTitle:@"Frist" forState:UIControlStateNormal];
    [btnPageFrist setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

    [btnPageFrist addTarget:self action:@selector(goToPreviousContentViewController) forControlEvents:UIControlEventTouchUpInside];
    [baseView addSubview:btnPageFrist];
    
    
    UIButton *btnPageSecond =[[UIButton alloc]init];
    btnPageSecond.frame = CGRectMake(  self.view.frame.size.width - 130 , 5, 120, 35);
    btnPageSecond.backgroundColor = [UIColor whiteColor];
    [btnPageSecond setTitle:@"Second" forState:UIControlStateNormal];
    [btnPageSecond setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btnPageSecond addTarget:self action:@selector(goToNextContentViewController) forControlEvents:UIControlEventTouchUpInside];

    [baseView addSubview:btnPageSecond];
}


//- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
//{
//    NSUInteger index = ((PageContentVC*) viewController).pageIndex;
//    
//    if ((index == 0) || (index == NSNotFound)) {
//        return nil;
//    }
//    
//    index--;
//    return [self viewControllerAtIndex:index];
//}

//- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
//{
//    NSUInteger index = ((PageContentVC*) viewController).pageIndex;
//    
//    if (index == NSNotFound) {
//        return nil;
//    }
//    
//    index++;
//    if (index == [self.pageTitles count]) {
//        return nil;
//    }
//    return [self viewControllerAtIndex:index];
//}
//
//- (PageContentVC *)viewControllerAtIndex:(NSUInteger)index
//{
//    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
//        return nil;
//    }
//    
//    // Create a new view controller and pass suitable data.
//    PageContentVC *pageContentVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentVC"];
//    pageContentVC.titleText = self.pageTitles[index];
//    pageContentVC.pageIndex = index;
//    
//    return pageContentVC;
//}
//
//- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
//{
//    return [self.pageTitles count];
//}
//
//- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
//{
//    return 0;
//}
@end
