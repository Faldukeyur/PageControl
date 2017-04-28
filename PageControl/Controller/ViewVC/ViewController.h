//
//  ViewController.h
//  PageControl
//
//  Created by keyur on 25/04/17.
//  Copyright © 2017 Keyur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPageViewControllerDataSource>
{
    UIPageControl *pageControl;

}

- (void)goToPreviousContentViewController;
- (void)goToNextContentViewController;


- (IBAction)changePage:(id)sender;

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;

@end

