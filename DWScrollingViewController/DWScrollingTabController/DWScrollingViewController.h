//
//  DWScrollingViewController.h
//  DWScrollingTabController
//
//  Created by Private on 6/25/14.
//  Copyright (c) 2014 DrizzleWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DWScrollingTabController.h"

@interface DWScrollingViewController : UIViewController<DWScrollingTabControllerDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *backgroundScrollView;
@property (nonatomic, assign) CGRect viewFrame;

//View的信息
@property (nonatomic, strong) NSMutableArray *subviewObjectsArray;

//滚动标题内容
@property (nonatomic, strong) DWScrollingTabController *topTabController;
@property (nonatomic, assign) int selectedIndex;

- (instancetype)initWithViewControllers:(NSArray *)viewControllers;

@end
