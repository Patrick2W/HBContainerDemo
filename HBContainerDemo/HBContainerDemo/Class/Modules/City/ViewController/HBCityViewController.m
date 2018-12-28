//
//  HBCityViewController.m
//  HBContainerDemo
//
//  Created by cheyun on 2018/12/28.
//  Copyright © 2018 Patrick. All rights reserved.
//

#import "HBCityViewController.h"
#import "HBContainer.h"
#import "HBCityModel.h"

@interface HBCityViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation HBCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.cityModel.local_name;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:UITableViewCell.class
           forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - UITableViewDataSource
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cityModel.childModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.self)];
    HBCityModel *model = self.cityModel.childModels[indexPath.row];
    cell.textLabel.text = model.local_name;
    return cell;
}

#pragma mark - UITableViewDelegate
#pragma mark -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HBCityModel *model = self.cityModel.childModels[indexPath.row];
    if (model.childModels.count > 0) {
        
        HBCityViewController *vc = [[HBCityViewController alloc] init];
        vc.cityModel = model;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else {
        
        [self.navigationController.containerController dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
