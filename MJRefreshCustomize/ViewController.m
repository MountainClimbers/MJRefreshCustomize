//
//  ViewController.m
//  MJRefreshCustomize
//
//  Created by qj.huang on 2018/4/11.
//  Copyright © 2018年 qjmac. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"

#import "ViewController3.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableVi;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initPageData];
    [self initPageVIew];
}

- (void)initPageData{
    self.dataArray = [[NSMutableArray alloc] init];
    
    [self.dataArray addObject:@"自定义动画一"];
    [self.dataArray addObject:@"自定义动画二"];
}

- (void)initPageVIew{
    self.tableVi = [[UITableView alloc] init];
    self.tableVi.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.tableVi.dataSource = self;
    self.tableVi.delegate = self;

    [self.tableVi registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentifier"];
    [self.view addSubview:self.tableVi];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];

    if (self.dataArray.count - 1 >= indexPath.section) {
        cell.textLabel.text = self.dataArray[indexPath.section];
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [self.navigationController pushViewController:[ViewController2 new] animated:YES];
    } else if (indexPath.section == 1) {
        [self.navigationController pushViewController:[ViewController3 new] animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
