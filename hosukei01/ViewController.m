//
//  ViewController.m
//  hosukei01
//
//  Created by kentaro_miura on 12/10/12.
//  Copyright (c) 2012年 kentaro_miura. All rights reserved.
//

#import "ViewController.h"
#import "InfoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //イメージビュー（画像の張り付け）
    customImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 480.0)]; //枠を生成
    customImageView.image = [UIImage imageNamed:@"0.png"];
    [self.view addSubview:customImageView];
    
    [self positionCheck];
    [self stepView];
    [self infoButton];
    [self clearButton];
    [self rockSwitch];
    [self impAdView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}
#pragma stepCofig
//加速度センサー
-(void)positionCheck
{
    motionManager = [[CMMotionManager alloc] init];
    motionManager.accelerometerUpdateInterval = 0.1;
    
    NSOperationQueue *currentQueue = [NSOperationQueue currentQueue];
    
    if (![motionManager isAccelerometerActive]) {
        [motionManager startAccelerometerUpdatesToQueue:currentQueue
                                            withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
                                                CMAcceleration acceleration = accelerometerData.acceleration;
                                                accX = acceleration.x;
                                                accY = acceleration.y;
                                                accZ = acceleration.z;
                                                [self logCheck];
                                                [self countCheck];
                                            }];
    }
}

//加速度センサーのログ表示　positionCheckへ
-(void)logCheck
{
    NSLog(@"X:%f Y:%f Z:%f",accX,accY,accZ);    //座標ログを表示
}
//歩数カウントチェック　→　positionCheckへ
-(void)countCheck
{
    if (accX > 0.1 || accY > 0.1 || accZ > 0.1) {
        stepNum++;
        intervalNum++;
        imageNum++;
        NSLog(@"%dstepNum",stepNum);
        NSLog(@"%dintervalNum",intervalNum);
        NSLog(@"%dimageNum",imageNum);
        stepView.text = [NSString stringWithFormat:@"%dstep", intervalNum];
        [self viewChange];
    }
}
//カウントされた歩数を表示
-(void)stepView
{
    stepView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 40.0)];
    stepView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.4];
    stepView.textColor = [UIColor colorWithRed:0.4 green:0.3 blue:0.2 alpha:0.7];
    stepView.textAlignment = UITextAlignmentCenter;
    stepView.text = @"0step";
    stepView.font = [UIFont fontWithName:@"Helvetica-Bold" size:28];
    [self.view addSubview:stepView];
}
#pragma imageChangeConfig
//歩数が一定値に達した場合のアクション
- (void)viewChange
{
    //一定枚数を超えたら始めからループ
    if(imageNum % 10 == 0 && imageNum > 100){
        NSLog(@"ループ発動");
        imageNum =0;
        NSString *imageName = [NSString stringWithFormat:@"%d.png", imageNum];
        customImageView.image = nil;
        customImageView.image = [UIImage imageNamed: imageName];
    }else if(imageNum % 10 == 0 &&  imageNum> 0) {
        NSLog(@"チェンジ発動");
        NSString *imageName = [NSString stringWithFormat:@"%d.png", imageNum];
        customImageView.image = nil;
        customImageView.image = [UIImage imageNamed: imageName];
    }
}

#pragma infoView
//インフォメーション画面を出すスイッチ
-(void)infoButton
{
    //ボタンの生成
	UIButton *infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    infoBtn.frame = CGRectMake(-5.0, -10.0, 45, 60);
    [infoBtn setBackgroundImage:[UIImage imageNamed:@"botan_info.png"]
                       forState:UIControlStateNormal];
    [infoBtn addTarget:self action:@selector(infoView:)
                       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:infoBtn];
}
//インフォメーション画面をモーダルで表示
-(void)infoView:(UIButton*)sender;
{
    // InfoViewController生成
    NSLog(@"モーダルインフォ");
    InfoViewController *infoViewController;
    infoViewController = [[InfoViewController alloc]
                          initWithNibName:@"InfoViewController"
                           bundle:nil];
    infoViewController.modalTransitionStyle = UIModalPresentationFullScreen + UIModalTransitionStylePartialCurl;
    [self presentModalViewController:infoViewController animated:YES];
}

#pragma clearAlert
//歩数をクリアするボタン
-(void)clearButton
{
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame = CGRectMake(20.0, -10.0, 60, 60);
    [clearBtn setBackgroundImage:[UIImage imageNamed:@"botan_reset.png"]
                        forState:UIControlStateNormal];
    [clearBtn addTarget:self action:@selector(clearAlert:)
                        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearBtn];
}
//クリアアラート選択肢
-(void)clearAlert:(UIAlertView*)alertView;
{
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.delegate = self;
    alert.title = @"";
    alert.message = @"歩数をゼロにしますか？";
    [alert addButtonWithTitle:@"いいえ"];
    [alert addButtonWithTitle:@"はい"];
    [alert show];
}
//歩数をクリア
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ((buttonIndex = 1)){
        intervalNum = 0;
    }else if((buttonIndex = 0)){
    }
}

#pragma rockSlider
//自動スリープを無効ボタン
-(void)rockSwitch
{
    UISwitch *customSwtich = [[UISwitch alloc] initWithFrame:CGRectMake(240.0, 5.0, 80, 30)];
    customSwtich.on = NO;
    customSwtich.onTintColor = [UIColor colorWithRed:0.4 green:0.3 blue:0.2 alpha:0.8];
    [customSwtich addTarget:self action:@selector(rockAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:customSwtich];
}
//iPhoneの自動ロック（自動スリープ）を無効にする
-(void)rockAction:(id)sender;
{
    UISwitch *tempSwitch = sender;
    if(tempSwitch.on){
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    }
}

#pragma impAd

- (void)impAdView
{
    CGRect adSize = CGRectMake(0,460-LOGOAD_SIZE.height,LOGOAD_SIZE.width,LOGOAD_SIZE.height);
    adView = [[LogoAdView alloc] initWithFrame:adSize];
    adView.delegate = self;
    adView.viewController = self;
    // 画面の回転に対応させる
    adView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin
    | UIViewAutoresizingFlexibleRightMargin
    | UIViewAutoresizingFlexibleTopMargin; [self.view addSubview:adView];
    // 取得したパブリッシャーIDをセットする
    NSString *publisherID = @"111111211114114";
    LogoAdRequest *req = [LogoAdRequest requestWithId:publisherID];
    // リクエストを開始する
    [adView loadRequest:req];
}

// 広告取得が完了した際に呼び出されます。
- (void)didReceiveAd:(LogoAdView *)adView
{
    
}
// 広告取得に失敗した際に呼び出されます。
- (void)didFailToReceiveAd:(LogoAdView *)adView withError:(LogoAdRequestError *)error
{
    NSLog(@"*** error: %@",error);
}
// 広告リロードが完了した際に呼び出されます。
- (void)didRefreshAd:(LogoAdView *)adView {
}
//広告リロードに失敗した際に呼び出されます。
- (void)didFailToRefreshAd:(LogoAdView *)adView withError:(LogoAdRequestError *)error
{
    NSLog(@"*** error: %@",error);
}
//広告ビュー画面表示前に呼び出されます。
- (void)willPresentModalFromAd:(LogoAdView *)adView
{
    
}
//広告ビュー画面表示後に呼び出されます。
- (void)didPresentModalFromAd:(LogoAdView *)adView
{
    
}
//広告ビュー画面が閉じる前に呼び出されます。
- (void)willDismissModalFromAd:(LogoAdView *)adView{
    
}
//広告ビュー画面が閉じた後に呼び出されます。
- (void)didDismissModalFromAd:(LogoAdView *)adView
{
    
}
//下記の4つは表示するために必要なので、必ず含んでください
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [adView viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated]; [adView viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [adView viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated]; [adView viewDidDisappear:animated];
}


@end
