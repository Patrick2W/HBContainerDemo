//
//  ViewController.m
//  HBContainerDemo
//
//  Created by cheyun on 2018/12/24.
//  Copyright © 2018 Patrick. All rights reserved.
//

#import "ViewController.h"
#import "HBHomeTableViewCell.h"
#import "HBRedPacketViewController.h"
#import "HBProvinceViewController.h"
#import "HBCartViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *titles;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    self.title = [UIDevice currentDevice].name;
    self.titles = @[@"抽红包了", @"城市选择", @"多级弹窗", @"城市选择Push"];
    self.tableView.tableFooterView = [UIView new];
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    [navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}


#pragma mark - UITableViewDataSource
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HBHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HBHomeTableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
#pragma mark -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    if (row == 0) {
        
        [HBRedPacketViewController showRedPacketPage:self];
        
    } else if (row == 1) {
        
        [HBProvinceViewController showProvincePage:self];
    } else if (row == 2) {
        
        [HBCartViewController showCartPage:self];
    } else if (row == 3) {
        HBProvinceViewController *vc = [[HBProvinceViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}




@end
