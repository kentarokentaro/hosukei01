//
//  CollectionViewController.m
//  hosukei01
//
//  Created by kentaro_miura on 12/10/24.
//  Copyright (c) 2012年 kentaro_miura. All rights reserved.
//

#import "CollectionViewController.h"

@implementation CollectionViewController

@synthesize stepNumColl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"%d", stepNumColl);
    
    // スクロールできる View を生成
    m_scroll = [[[UIScrollView alloc] init] autorelease];
    m_scroll.backgroundColor = [UIColor colorWithRed:0.4 green:0.3 blue:0.2 alpha:0.9];
    [m_scroll setFrame:CGRectMake(0, 50, 320, 480)];
    
    //スクロールビューの背景画像を設定
    [m_scroll setContentSize:CGSizeMake(320, 480)];
    [m_scroll setDelegate:self];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top5.png"]];
    [imageView setTag:1];
    [imageView setFrame:CGRectMake(0.0, 0.0, 320, 480)];
    [m_scroll addSubview:imageView];
    [imageView release];

    [self.view addSubview:m_scroll];

    //もどるボタン
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(0, 0, 320, 50);
    [btn setTitle:@"もどる" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:0.4 green:0.3 blue:0.2 alpha:0.8] forState:UIControlStateNormal];
    btn.tintColor = [UIColor colorWithRed:0.4 green:0.3 blue:0.2 alpha:0.8];
    [btn addTarget:self action:@selector(pushClose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    // スクロールビューのスクロール可能範囲を設定
    // (80x80 の画像を横に 4 枚ずつ合計 30 枚配置)
    [m_scroll setContentSize:CGSizeMake(320, 120 * 30 / 4 + 80)];

    int ix = 80 / 2 - 64 / 2;   // 60x80 内の画像表示位置
    int iy = ix;    // 縦横同じサイズなので計算省略
    int addx = 80;  // 1 枚表示する度にずらす X 座標
    int addy = 80;
    int maxWidth = 4;   // 横最大枚数
    for ( int i=1; i < 45; i++ ) {
        // 座標計算
        int x = i % maxWidth * addx;
        int y = i / maxWidth * addy;
        
        // 画像貼り付け
        UIImageView *imgView = [[[UIImageView alloc] init] autorelease];
        [imgView setFrame:CGRectMake(x + ix, y + iy, 48, 64)];
//        [imgView setImage:img];
        int a = 0;
        a = i * 100;
        UIImage *image = [[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", a]] autorelease];
        [imgView setImage:image];
        
//        if (stepNumColl >= 100) {
//            NSLog(@"!");
//            UIImage *image = [UIImage imageNamed:@"100.jpg"];
//            [imgView setImage:image];
//        }
        
        imgView.backgroundColor = [UIColor redColor];
        [m_scroll addSubview:imgView];
    }
}

- (void)pushClose:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView_
{
    if( scrollView_ == m_scroll )
    {
        [[scrollView_ viewWithTag:1] setFrame:CGRectMake(scrollView_.contentOffset.x, scrollView_.contentOffset.y, 320 , 480)];
    }
    scrollView_ =[[[UIScrollView alloc] init] autorelease];
}
@end
