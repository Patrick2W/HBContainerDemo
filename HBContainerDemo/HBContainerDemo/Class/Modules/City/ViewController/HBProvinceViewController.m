//
//  HBProvinceViewController.m
//  HBContainerDemo
//
//  Created by cheyun on 2018/12/28.
//  Copyright © 2018 Patrick. All rights reserved.
//

#import "HBProvinceViewController.h"
#import "HBCityViewController.h"
#import "HBContainer.h"
#import "HBCityModel.h"

@interface HBProvinceViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *models;

@end

@implementation HBProvinceViewController

+ (HBProvinceViewController *)showProvincePage:(UIViewController *)caller {
    HBProvinceViewController *vc = [[HBProvinceViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [nav.navigationBar setBarTintColor:[UIColor cyanColor]];
    [nav setEdges:UIEdgeInsetsMake(200, 0, 0, 0)];
    HBContainerController *container = [[HBContainerController alloc] initWithRootViewController:nav];
    container.dismissWhenBlankTouched = YES;
    [container setPresentAnimationStyle:HBContainerPresentAnimationStyleBottomIn
                  dismissAnimationStyle:HBContainerDismissAnimationStyleBottomOut];
    [caller presentViewController:container animated:YES completion:nil];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"省份选择";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:UITableViewCell.class
           forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    [self.view addSubview:self.tableView];
    
    [self loadData];
}

- (void)loadData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    NSDictionary *result = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *data = result[@"data"];
    NSMutableArray *models = [NSMutableArray array];
    for (NSDictionary *element in data) {
        HBCityModel *model = [HBCityModel modelWithDictionary:element];
        [models addObject:model];
    }
    self.models = models;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - UITableViewDataSource
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.self)];
    HBCityModel *model = self.models[indexPath.row];
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
    HBCityModel *model = self.models[indexPath.row];
    if (model.childModels.count > 0) {
        
        HBCityViewController *vc = [[HBCityViewController alloc] init];
        vc.cityModel = model;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else {
        
        [self.navigationController.containerController dismissViewControllerAnimated:YES completion:nil];
    }
}




@end
