//
//  MainMenuViewController.m
//  Calcohol
//
//  Created by Andrew Carvajal on 11/30/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import "MainMenuViewController.h"
#import "ViewController.h"
#import "WhiskeyViewController.h"

@interface MainMenuViewController ()

@property (weak, nonatomic) UIButton *wineButton;
@property (weak, nonatomic) UIButton *whiskeyButton;

@end

@implementation MainMenuViewController

- (void)loadView {
    self.view = [[UIView alloc] init];
    UIButton *wine = [UIButton buttonWithType:UIButtonTypeSystem];
    UIButton *whiskey = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:wine];
    [self.view addSubview:whiskey];
    self.wineButton = wine;
    self.whiskeyButton = whiskey;
    [self.wineButton addTarget:self action:@selector(winePressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.whiskeyButton addTarget:self action:@selector(whiskeyPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.wineButton setTitle:NSLocalizedString(@"Wine !", @"wine button") forState:UIControlStateNormal];
    [self.whiskeyButton setTitle:NSLocalizedString(@"Whiskey !", @"whiskey button") forState:UIControlStateNormal];

    self.title = NSLocalizedString(@"Menu", @"menu");
    wine.backgroundColor = [UIColor purpleColor];
    whiskey.backgroundColor = [UIColor orangeColor];
    
}

- (void)viewWillLayoutSubviews {
    CGFloat viewWidth = self.view.bounds.size.width;
    CGFloat padding = 20;
    CGFloat itemWidth = viewWidth / 2.5;
    CGFloat itemHeight = 44;
    self.wineButton.frame = CGRectMake(padding, padding *6, itemWidth, itemHeight);
    self.whiskeyButton.frame = CGRectMake(viewWidth - itemWidth - padding, padding *6, itemWidth, itemHeight);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)winePressed:(UIButton *)sender {
    ViewController *wineVC = [[ViewController alloc] init];
    [self.navigationController pushViewController:wineVC animated:YES];
}

- (void)whiskeyPressed:(UIButton *)sender {
    WhiskeyViewController *whiskeyVC = [[WhiskeyViewController alloc] init];
    [self.navigationController pushViewController:whiskeyVC animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
