//
//  ViewController.m
//  hosukei01
//
//  Created by kentaro_miura on 12/10/12.
//  Copyright (c) 2012年 kentaro_miura. All rights reserved.
//
#import <AudioToolbox/AudioToolbox.h>
#import "ViewController.h"
#import "InfoViewController.h"

@interface ViewController ()
{
    UIImage *webImage;
}
@end

@implementation ViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self wakeCount];
    [self stepLoad];
    
    customImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 480.0)];
    customImageView.image = [UIImage imageNamed:@"0.jpg"];
    [self.view addSubview:customImageView];
    
    [self positionCheck];
    [self stepView];
    [self infoButton];
    [self clearButton];
    [self rockSwitch];
    [self impAdView];
    
   
}

-(void)viewDidUnload
{
    [super viewDidUnload];
    [self stepSave];
}

#pragma mark stepCofig
-(void)positionCheck
{
    motionManager = [[CMMotionManager alloc] init];
    motionManager.accelerometerUpdateInterval = 0.6;
    
    NSOperationQueue *currentQueue = [NSOperationQueue currentQueue];
    
    if (![motionManager isAccelerometerActive]) {
        [motionManager startAccelerometerUpdatesToQueue:currentQueue
                                            withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
                                                CMAcceleration acceleration = accelerometerData.acceleration;
                                                accX = acceleration.x;
                                                accY = acceleration.y;
                                                accZ = acceleration.z;
                                                [self countCheck];
                                                [self stepSave];
                                            }];
    }
}

-(void)countCheck
{
    if (accX > 0.8 || accY > 0.8 || accZ > 0.9) {
        intervalNum++;
        imageNum++;
        stepView.text = [NSString stringWithFormat:@"%dstep", intervalNum];
        [self viewChange];
    }
}

-(void)stepView
{
    stepView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 40.0)];
    stepView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.4];
    stepView.textColor = [UIColor colorWithRed:0.4 green:0.3 blue:0.2 alpha:0.7];
    stepView.textAlignment = UITextAlignmentCenter;
    stepView.text = [NSString stringWithFormat:@"%dstep",intervalNum];
    stepView.font = [UIFont fontWithName:@"Helvetica-Bold" size:28];
    [self.view addSubview:stepView];
}

#pragma mark imageChangeConfig
-(void)viewChange
{
        if(imageNum % 100 == 0 && imageNum > 49000){
            imageNum =0;
            NSString *imageName = [NSString stringWithFormat:@"%d.jpg", imageNum/10];
            customImageView.image = nil;
            customImageView.image = [UIImage imageNamed: imageName];
        }else if(imageNum % 100 == 0 &&  imageNum> 0) {
            NSString *imageName = [NSString stringWithFormat:@"%d.jpg", imageNum/10];
            customImageView.image = nil;
            customImageView.image = [[UIImage imageNamed: imageName] autorelease];
        }
}

#pragma mark infoView
-(void)infoButton
{
	UIButton *infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    infoBtn.frame = CGRectMake(-5.0, -10.0, 45, 60);
    [infoBtn setBackgroundImage:[UIImage imageNamed:@"botan_info.png"]
                       forState:UIControlStateNormal];
    [infoBtn addTarget:self action:@selector(infoView:)
                       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:infoBtn];
}

-(void)infoView:(UIButton*)sender;
{
    InfoViewController *infoViewController;
    infoViewController = [[InfoViewController alloc]
                          initWithNibName:@"InfoViewController"
                           bundle:nil];
    infoViewController.modalTransitionStyle = UIModalPresentationPageSheet + UIModalTransitionStylePartialCurl;
    [self presentModalViewController:infoViewController animated:YES];
}

#pragma mark clearAlert
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

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1){
        intervalNum = 0;
        stepView.text = [NSString stringWithFormat:@"%dstep",intervalNum];
    }else if(buttonIndex == 0){
    }
}

#pragma mark rockSlider
-(void)rockSwitch
{
    UISwitch *customSwtich = [[UISwitch alloc] initWithFrame:CGRectMake(240.0, 5.0, 80, 30)];
    customSwtich.on = NO;
    customSwtich.onTintColor = [UIColor colorWithRed:0.4 green:0.3 blue:0.2 alpha:0.8];
    [customSwtich addTarget:self action:@selector(rockAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:customSwtich];
}

-(void)rockAction:(id)sender;
{
    UISwitch *tempSwitch = sender;
    if(tempSwitch.on){
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    }
}

#pragma mark stepSave

-(void)stepSave
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:imageNum forKey:@"KEY_SN"];
    [ud setInteger:intervalNum forKey:@"KEY_SS"];
    [ud synchronize];
    sn = [ud integerForKey:@"KEY_SN"];
    ss = [ud integerForKey:@"KEY_SS"];
    NSLog(@"SimageNum %d",sn);
    NSLog(@"SinatervalNum %d",ss);
}

-(void)wakeCount
{
    NSUserDefaults *udw = [NSUserDefaults standardUserDefaults];
    wakeCnt = [udw integerForKey:@"wake"];
    wakeCnt++;
    [udw setInteger:wakeCnt forKey:@"wake"];
    [udw synchronize];
    NSLog(@"起動回数 : %d", wakeCnt);
}

-(void)stepLoad
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    [ud setInteger:imageNum forKey:@"KEY_SN"];
//    [ud setInteger:intervalNum forKey:@"KEY_SS"];
//    [ud synchronize];
    sn = [ud integerForKey:@"KEY_SN"];
    ss = [ud integerForKey:@"KEY_SS"];
    if(wakeCnt > 1){
        NSLog(@"LimageNum %d",sn);
        NSLog(@"LintervalNum %d",ss);
        imageNum = sn;
        intervalNum = ss;
        }
}


#pragma mark impAd

- (void)impAdView
{
    CGRect adSize = CGRectMake(0,460-LOGOAD_SIZE.height,LOGOAD_SIZE.width,LOGOAD_SIZE.height);
    adView = [[LogoAdView alloc] initWithFrame:adSize];
    adView.delegate = self;
    adView.viewController = self;
    adView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin
    | UIViewAutoresizingFlexibleRightMargin
    | UIViewAutoresizingFlexibleTopMargin; [self.view addSubview:adView];
    NSString *publisherID = @"111111211116859";
    LogoAdRequest *req = [LogoAdRequest requestWithId:publisherID];
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
