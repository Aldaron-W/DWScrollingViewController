//
//  ContentViewController.m
//  DWScrollingViewController
//
//  Created by Private on 6/25/14.
//  Copyright (c) 2014 DrizzleWang. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置显示的内容为本身的Title
    [self.viewContent setText:self.title];
    
    UIGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushScrollingView)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
    [[self.view gestureRecognizers] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIGestureRecognizer *viewGestrure = obj;
        
        [self.view removeGestureRecognizer:viewGestrure];
    }];
    
    NSLog(@"ContentViewController Dealloc");
}

- (void)pushScrollingView{
    //初始化所有的View
    ContentViewController *contentViewController = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
    [contentViewController setTitle:[NSString stringWithFormat:@"%@ - 第1页", self.title]];
    
    ContentViewController *contentViewController2 = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
    [contentViewController2 setTitle:[NSString stringWithFormat:@"%@ - 第2页", self.title]];
    
    ContentViewController *contentViewController3 = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
    [contentViewController3 setTitle:[NSString stringWithFormat:@"%@ - 第3页", self.title]];
    
    ContentViewController *contentViewController4 = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
    [contentViewController4 setTitle:[NSString stringWithFormat:@"%@ - 第4页", self.title]];
    
    DWScrollingViewController *scrollingView = [[DWScrollingViewController alloc] initWithViewControllers:@[contentViewController, contentViewController2, contentViewController3, contentViewController4]];
    scrollingView.title = self.title;
    
    [self.navigationController pushViewController:scrollingView animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
