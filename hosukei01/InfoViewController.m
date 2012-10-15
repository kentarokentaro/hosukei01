//
//  InfoViewController.m
//  hosukei01
//
//  Created by kentaro_miura on 12/10/13.
//  Copyright (c) 2012年 kentaro_miura. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //イメージビュー（画像の張り付け）
    UIImageView *infoImageView =
            [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 480.0)];
    infoImageView.image = [UIImage imageNamed:@"info.png"];
    [self.view addSubview:infoImageView];
    
    //もどるボタン
    UIButton *rBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rBtn.frame = CGRectMake(15.0, 410.0, 75, 40);
    rBtn.backgroundColor= [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.0];
    [rBtn setTitle:@"もどる" forState:UIControlStateNormal];
    [rBtn setTitleColor:[UIColor colorWithRed:0.4 green:0.3 blue:0.2 alpha:10.0]
               forState:UIControlStateNormal];
    rBtn.titleLabel.font = [ UIFont fontWithName:@"Helvetica-Bold" size:24 ];
    [rBtn addTarget:self action:@selector(returnBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rBtn];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

-(void)returnBtn:(UIButton*)sender;
{
    // モーダルを非表示
    [self dismissModalViewControllerAnimated:YES];
}

@end
