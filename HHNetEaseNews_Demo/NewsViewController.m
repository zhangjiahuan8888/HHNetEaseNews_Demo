//
//  NewsViewController.m
//  NetEaseNews
//
//  Created by 张家欢 on 16/7/21.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

#import "NewsViewController.h"
#import "MJRefresh.h"

@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *newsTableView;
}
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatSubviews];
}
- (void)setupBackground{
        switch (_newsType) {
            case NewsTypeMain:
                self.view.backgroundColor = [UIColor greenColor];
                break;
            case NewsTypeTiyu:
                self.view.backgroundColor = [UIColor yellowColor];
                break;
            case NewsTypeYule:
                self.view.backgroundColor = [UIColor cyanColor];
                break;
            case NewsTypeKeji:
                self.view.backgroundColor = [UIColor blueColor];
                break;
            case NewsTypeVideo:
                self.view.backgroundColor = [UIColor redColor];
                break;
            case NewsTypeJingji:
                self.view.backgroundColor = [UIColor purpleColor];
                break;
            case NewsTypeJunshi:
                self.view.backgroundColor = [UIColor lightGrayColor];
                break;
            case NewsTypeWenhua:
                self.view.backgroundColor = [UIColor orangeColor];
                break;
            case NewsTypeWeibo:
                self.view.backgroundColor = [UIColor brownColor];
                break;
    
            default:
                break;
        }

}
- (void)creatSubviews{
    newsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64-40) style:UITableViewStylePlain];
    newsTableView.dataSource = self;
    newsTableView.delegate = self;

    /////////////////////////////////////////////////////
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    newsTableView.mj_header = header;
    [header beginRefreshing];

    [self.view addSubview:newsTableView];
}
- (void)requestData{
    NSLog(@"进行网络请求");
    [newsTableView.mj_header endRefreshing];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _newsStr;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"这是关于%@的详情",_newsStr];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
