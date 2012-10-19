//
//  ViewController.h
//  hosukei01
//
//  Created by kentaro_miura on 12/10/12.
//  Copyright (c) 2012年 kentaro_miura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <coreMotion/CoreMotion.h>
#import "InfoViewController.h"
#import "LogoAdView.h"
#import "LogoAdViewDelegate.h"

@interface ViewController : UIViewController<UIAlertViewDelegate,LogoAdViewDelegate>
{
    UILabel *stepView;                      //歩数表示
    CMMotionManager *motionManager;         //加速度センサー
    UIImageView *customImageView;           //チェンジ画面イメージ
    LogoAdView *adView;                     //インプレッション広告
    
    float accX,accY,accZ;                   //加速度座標
    int stepNum;                            //総歩数
    int intervalNum;                        //表示用歩数
    int imageNum;                           //画像チェンジ用歩数
}

-(void)viewDispray;                         //画面表示
-(void)logCheck;                            //座標のログ表示
-(void)countCheck;                          //振動の感知
-(void)stepView;                            //歩数を表示
-(void)viewChange;                          //一定歩数に達した時の処理
-(void)infoButton;                          //インフォメーション画面へ
-(void)infoModal:(UIButton*)sender;         //インフォメーション画面へ行くアクション
-(void)clearButton;                         //クリアボタン
-(void)clearAlert;                          //クリアボタン押下時のクリアアラート
-(void)alertView:(UIAlertView*)alertView;   //クリアアラート分岐
-(void)rockSwitch;                          //画面ロックのスイッチ
-(void)rockAction:(id)sender;               //画面をっク
-(void)impAdView;                          //インプレッション広告表示
-(void)changeSound1;
-(void)changeSound2;

@end
