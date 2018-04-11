//
//  ViewController.m
//  MJRefreshCustomize
//
//  Created by qj.huang on 2018/4/11.
//  Copyright © 2018年 qjmac. All rights reserved.
//

#import "ViewController3.h"
#import "MJDIYSecondHeader.h"

@interface ViewController3 ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableVi;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initPageVIew];
    [self addMJRefresh];
}

- (void)initPageData{

}

- (void)initPageVIew{
    self.tableVi = [[UITableView alloc] init];
    self.tableVi.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.tableVi.dataSource = self;
    self.tableVi.delegate = self;
    [self.view addSubview:self.tableVi];
}

-(void)addMJRefresh{
    __weak __typeof(self) weakSelf = self;
    
    MJDIYSecondHeader* header = [[MJDIYSecondHeader alloc] initWithFrame:CGRectZero];
    
    header.refreshingBlock = ^{
        
        __weak UITableView *tableView = self.tableVi;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // 拿到当前的上拉刷新控件，结束刷新状态
            [tableView.mj_header endRefreshing];
            
        });
    };
    
    
    
    //    header.backgroundColor = UIColorFromRGB(0xf5f5f5);
    self.tableVi.mj_header = header;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    if (self.dataArray.count - 1 >= indexPath.section) {
        cell.textLabel.text = self.dataArray[indexPath.section];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

