//
//  LoginViewController.m
//  timeManageToList
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 com.xz.timeManageToList. All rights reserved.
//

#import "LoginViewController.h"
#import "TaskViewController.h"


@interface LoginViewController ()
// 账号
@property (weak, nonatomic) IBOutlet UITextField *AccountTextField;
// 密码
@property (weak, nonatomic) IBOutlet UITextField *PassWordTextField;
- (IBAction)LoginAction:(UIButton *)sender;
// 登录
@property (weak, nonatomic) IBOutlet UIButton *LoginBtu;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.LoginBtu.layer.cornerRadius = 5;
    self.LoginBtu.layer.borderWidth =1;
    self.LoginBtu.layer.borderColor = HexRGB(0xFFA700).CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark 登录
- (IBAction)LoginAction:(UIButton *)sender {
    if (self.AccountTextField.text.length !=0) {
        [HttpConnection loginWithUsername:self.AccountTextField.text password:self.PassWordTextField.text block:^(NSInteger result, id response) {
            if (result==1) {
                NSDictionary *dict = response[@"data"];
                [[userModel getInstance] saveUserInfo:dict];
                TaskViewController *task = [[TaskViewController alloc] initWithNibName:@"TaskViewController" bundle:nil];
                [self.navigationController pushViewController:task animated:YES];
            } else{
                [SVProgressHUD showErrorWithStatus:response[@"message"]];
            }
        }];
    }

}
@end
