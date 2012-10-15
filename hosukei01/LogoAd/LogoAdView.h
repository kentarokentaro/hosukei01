//
//  LogoAdView.h
//  Logo AD SDK
//
//  Created by nsp
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LogoAdRequest.h"
#import "LogoAdViewDelegate.h"
#import "LogoAdRequestError.h"


# pragma mark --- Ad Sizes

/*!
 @const LOGOAD_SIZE
 @discussion 広告規定サイズ
 */
#define LOGOAD_SIZE CGSizeMake(320,48)



# pragma mark --- Ad View

/*!
 @class LogoAdView
 @superclass UIView
 @discussion 広告表示ビュークラス
 loadRequestメソッドにより広告を取得し、広告を描画する
 */
@interface LogoAdView : UIView <UIWebViewDelegate, CLLocationManagerDelegate>

/*!
 @property delegate
 @discussion delegateプロパティ
 */
@property (nonatomic, assign) id <LogoAdViewDelegate> delegate;

/*!
 @property viewController
 @discussion 広告タップ時に広告ビュー画面をするためのビューコントローラ指定
 */
@property (nonatomic, assign) UIViewController *viewController;


/*!
 @method loadRequest:
 @discussion 広告リクエストを開始するメソッド
 @param request 広告リクエストインスタンス
 */
- (void)loadRequest:(LogoAdRequest *)request;

/*!
 @method viewWillAppear:
 @discussion ビューが表示される直前に呼び出されるメソッド
 @param animated アニメーションを含むか
 */
- (void)viewWillAppear:(BOOL)animated;
/*!
 @method viewDidAppear:
 @discussion ビューが表示された直後に呼び出されるメソッド
 @param animated アニメーションを含むか
 */
- (void)viewDidAppear:(BOOL)animated;
/*!
 @method viewWillDisappear:
 @discussion ビューが非表示になる直前に呼び出されるメソッド
 @param animated アニメーションを含むか
 */
- (void)viewWillDisappear:(BOOL)animated;
/*!
 @method viewDidDisappear:
 @discussion ビューが非表示になった直後に呼び出されるメソッド
 @param animated アニメーションを含むか
 */
- (void)viewDidDisappear:(BOOL)animated;

@end




