//
//  ToSelectViewController.m
//  timeManageToList
//
//  Created by mac on 2018/8/9.
//  Copyright © 2018年 com.xz.timeManageToList. All rights reserved.
//

#import "ToSelectViewController.h"

@interface ToSelectViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
}

//主页面
@property (weak, nonatomic) IBOutlet UITableView *MainTabView;

@end

@implementation ToSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.MainTabView.delegate =self;
    self.MainTabView.dataSource = self;
    if (!self.dataArr) {
        self.dataArr = [[NSArray alloc] init];
    }
    switch (self.num) {
        case 0:
        {
            [self initNavigationWithImgAndTitle:@"重复选择" leftBtton:nil rightBut: nil navBackColor:HexRGB(0x3CA7A3)];
        }
            break;
        case 1:
        {
            [self initNavigationWithImgAndTitle:@"重复选择" leftBtton:nil rightBut: nil navBackColor:HexRGB(0x3CA7A3)];
        }
            break;
        default:
            break;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
//
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *str = self.dataArr[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"formCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"formCell"];
        cell.textLabel.text = str;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = self.dataArr[indexPath.row];
    self.block(str, indexPath.row);
}
@end
