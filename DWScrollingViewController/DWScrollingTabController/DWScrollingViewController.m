//
//  DWScrollingViewController.m
//  DWScrollingTabController
//
//  Created by Private on 6/25/14.
//  Copyright (c) 2014 DrizzleWang. All rights reserved.
//

#import "DWScrollingViewController.h"

@interface DWScrollingViewController ()

@end

@implementation DWScrollingViewController

- (instancetype)initWithViewControllers:(NSArray *)viewControllers{
    self = [super init];
    if (self) {
        if (viewControllers) {
            self.subviewObjectsArray = [NSMutableArray arrayWithArray:viewControllers];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    
//    [[self.navigationController navigationBar] setHidden:YES];
    [[self.tabBarController tabBar] setHidden:YES];
    
    if (!_topTabController) {
        self.viewFrame = self.view.bounds;
        
        
        if ([[[UIDevice currentDevice] systemVersion] intValue] >= 7.0) {
            //判断是否显示NavigationBar
            if (self.navigationController &&
                ![[self.navigationController navigationBar] isHidden]) {
                
                CGRect contentFrame = self.viewFrame;
                contentFrame.origin.y += [[UIApplication sharedApplication] statusBarFrame].size.height + [[self.navigationController navigationBar] frame].size.height;
                contentFrame.size.height -= [[UIApplication sharedApplication] statusBarFrame].size.height + [[self.navigationController navigationBar] frame].size.height;
                self.viewFrame = contentFrame;
            }
            else{
                
                CGRect contentFrame = self.viewFrame;
                contentFrame.origin.y += [[UIApplication sharedApplication] statusBarFrame].size.height;
                contentFrame.size.height -= [[UIApplication sharedApplication] statusBarFrame].size.height;
                self.viewFrame = contentFrame;
                
            }
            
            //判断是否显示TabBar
            if (self.tabBarController &&
                ![[self.tabBarController tabBar] isHidden]) {
                CGRect contentFrame = self.viewFrame;
                contentFrame.size.height -= [[self.tabBarController tabBar] frame].size.height;
                self.viewFrame = contentFrame;
            }
        }
        
        [self.view addSubview:self.topTabController.view];
        [self.view addSubview:self.backgroundScrollView];
        
        [self putAllSubviewIntoThisView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
    self.topTabController = nil;
    
    [[self.backgroundScrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.backgroundScrollView removeFromSuperview];
    self.backgroundScrollView = nil;
    
    [self.subviewObjectsArray removeAllObjects];
    
    NSLog(@"USScrollingViewController Dealloc");
}

- (BOOL)putAllSubviewIntoThisView{
    if ([self.subviewObjectsArray count] > 0) {
        
        [self.subviewObjectsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIViewController *subviewController = obj;
            CGRect viewFrame = subviewController.view.frame;
            viewFrame.origin.x = [UIScreen mainScreen].bounds.size.width * idx;
            viewFrame.origin.y = 0;
            viewFrame.size.width = [UIScreen mainScreen].bounds.size.width;
            viewFrame.size.height = self.backgroundScrollView.frame.size.height;
            [subviewController.view setFrame:viewFrame];
            
            [self addChildViewController:subviewController];
            [subviewController didMoveToParentViewController:self];
            [self.backgroundScrollView addSubview:subviewController.view];
        }];
    }
    
    return YES;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pagewidth = self.backgroundScrollView.frame.size.width;
    int page = floor((self.backgroundScrollView.contentOffset.x - pagewidth)/pagewidth) + 1;
    if (page < 0) { page = 0; }
    [self.topTabController selectButtonWithIndex:page delegate:NO];
    self.selectedIndex = page;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int positon = 0;
    
    if (((int)self.backgroundScrollView.contentOffset.x / (int)[UIScreen mainScreen].bounds.size.width) < self.selectedIndex) {
        positon = ((int)self.backgroundScrollView.contentOffset.x - self.selectedIndex * (int)[UIScreen mainScreen].bounds.size.width);
        //        positon -= [UIScreen mainScreen].bounds.size.width;
    }
    else{
        positon = (int)self.backgroundScrollView.contentOffset.x - self.selectedIndex * (int)[UIScreen mainScreen].bounds.size.width;
    }
    
    [self.topTabController changeIndicatorViewPoziton:positon];
}

-(void)DWScrollingTabController:(DWScrollingTabController *)controller selection:(NSUInteger)selection{
    self.selectedIndex = (int)selection;
    [self.backgroundScrollView scrollRectToVisible:CGRectMake([UIScreen mainScreen].bounds.size.width * self.selectedIndex, 0, [UIScreen mainScreen].bounds.size.width, self.backgroundScrollView.frame.size.height) animated:YES];
}

#pragma mark - Getter
- (DWScrollingTabController *)topTabController{
    if (!_topTabController) {
        _topTabController = [[DWScrollingTabController alloc] init];
        CGFloat topTabControllerViewY;
        if ([[[UIDevice currentDevice] systemVersion] intValue] < 7.0) {
            topTabControllerViewY = 0.0;
        }
        else{
            topTabControllerViewY = self.viewFrame.origin.y;
        }
        
        _topTabController.view.frame = CGRectMake(0, topTabControllerViewY, [UIScreen mainScreen].bounds.size.width, 36);
        [_topTabController.view setAutoresizingMask:UIViewAutoresizingNone];
        _topTabController.delegate = self;
        //        [self addChildViewController:_topTabController];
        //        [_topTabController didMoveToParentViewController:self];
        //        [_topTabController setAutomaticallyAdjustsScrollViewInsets:NO];
        
        NSMutableArray *viewTitleArray = [[NSMutableArray alloc] initWithCapacity:3];
        
        for (UIViewController * subviewController in self.subviewObjectsArray) {
            [viewTitleArray addObject:subviewController.title];
        }
        self.topTabController.selection = viewTitleArray;
        
        self.selectedIndex = 0;
    }
    
    return _topTabController;
}

- (UIScrollView *)backgroundScrollView{
    if (!_backgroundScrollView) {
        _backgroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                               self.topTabController.view.frame.origin.y + self.topTabController.view.frame.size.height,
                                                                               [UIScreen mainScreen].bounds.size.width,
                                                                               self.viewFrame.size.height - self.topTabController.view.frame.size.height)];
        _backgroundScrollView.bounces = YES;
        _backgroundScrollView.pagingEnabled = YES;
        _backgroundScrollView.delegate = self;
        _backgroundScrollView.userInteractionEnabled = YES;
        _backgroundScrollView.showsHorizontalScrollIndicator = NO;
        _backgroundScrollView.showsVerticalScrollIndicator = NO;
        [_backgroundScrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width * [self.topTabController.selection count], _backgroundScrollView.frame.size.height)];
//        [_backgroundScrollView setBackgroundColor:COLOR_BGIMG];
        
//        for (int i=0; i<[self.topTabController.selection count]; i++) {
//            
//            UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * i,
//                                                                                        (_backgroundScrollView.frame.size.height - 180)/2,
//                                                                                        [UIScreen mainScreen].bounds.size.width, 180)];
//            backgroundView.image = [UIImage imageNamed:@"DWImagePageBackground"];
//            [backgroundView setContentMode:UIViewContentModeScaleAspectFill];
//            [_backgroundScrollView addSubview:backgroundView];
//        }
    }
    return _backgroundScrollView;
}

- (NSMutableArray *)subviewObjectsArray{
    if (!_subviewObjectsArray) {
        _subviewObjectsArray = [[NSMutableArray alloc] initWithCapacity:3];
    }
    return _subviewObjectsArray;
}

#pragma mark - Setters
- (void)setSelectedIndex:(int)selectedIndex{
    _selectedIndex = selectedIndex;
    
    NSMutableArray *refreshViewIndex = [[NSMutableArray alloc] initWithCapacity:3];
    
    if ([[self.subviewObjectsArray objectAtIndex:_selectedIndex] respondsToSelector:@selector(reloadData)]) {
        [[self.subviewObjectsArray objectAtIndex:_selectedIndex] reloadData];
    }
    
//    //左右两页加载数据
//    if (-1 < (_selectedIndex - 1)) {
//        if ([[self.subviewObjectsArray objectAtIndex:(_selectedIndex - 1)] respondsToSelector:@selector(reloadData)]) {
//            [[self.subviewObjectsArray objectAtIndex:(_selectedIndex - 1)] reloadData];
//        }
//        [refreshViewIndex addObject:[NSNumber numberWithInt:_selectedIndex - 1]];
//    }
//    [refreshViewIndex addObject:[NSNumber numberWithInt:_selectedIndex]];
//    if ([self.subviewObjectsArray count] > (_selectedIndex + 1)) {
//        if ([[self.subviewObjectsArray objectAtIndex:(_selectedIndex + 1)] respondsToSelector:@selector(reloadData)]) {
//            [[self.subviewObjectsArray objectAtIndex:(_selectedIndex + 1)] reloadData];
//        }
//        [refreshViewIndex addObject:[NSNumber numberWithInt:_selectedIndex + 1]];
//    }
//    
//    //其他页面清空数据
//    for (int i=0; i<[self.subviewObjectsArray count]; i++) {
//        if (i == [[refreshViewIndex objectAtIndex:0] intValue]) {
//            i += [refreshViewIndex count]-1;
//            continue;
//        }
//        if ([[self.subviewObjectsArray objectAtIndex:(i)] respondsToSelector:@selector(cleanData)]) {
//            [[self.subviewObjectsArray objectAtIndex:(i)] cleanData];
//        }
//    }
}

@end
