//
//  LogoAdViewDelegate.h
//  Logo AD SDK
//
//  Created by nsp
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LogoAdView;
@class LogoAdRequestError;

/*!
 @protocol LogoAdViewDelegate
 広告SDK用デリゲートメソッド定義
 */
@protocol LogoAdViewDelegate <NSObject>

@optional

/*!
 @method didReceiveAd:
 @discussion 広告取得が完了した際に呼び出されるメソッド
 @param adView 広告ビュー
 */
- (void)didReceiveAd:(LogoAdView *)adView;

/*!
 @method didFailToReceiveAd:withError:
 @discussion 広告取得に失敗した際に呼び出されるメソッド
 @param adView 広告ビュー
 @param error エラーオブジェクト
 */
- (void)didFailToReceiveAd:(LogoAdView *)adView withError:(LogoAdRequestError *)error;


/*!
 @method didRefreshAd:
 @discussion 広告リロードが完了した際に呼び出されるメソッド
 @param adView 広告ビュー
 */
- (void)didRefreshAd:(LogoAdView *)adView;

/*!
 @method didFailtoRefreshAd:withError:
 @discussion 広告リロードに失敗した際に呼び出されるメソッド
 @param adView 広告ビュー
 @param error エラーオブジェクト
 */
- (void)didFailToRefreshAd:(LogoAdView *)adView withError:(LogoAdRequestError *)error;


/*!
 @method willPresentModalFromAd:
 @discussion 広告ビュー画面表示前に呼び出されるメソッド
 @param adView 広告ビュー
 */
- (void)willPresentModalFromAd:(LogoAdView *)adView;

/*!
 @method didPresentModalFromAd:
 @discussion 広告ビュー画面表示後に呼び出されるメソッド
 @param adView 広告ビュー
 */
- (void)didPresentModalFromAd:(LogoAdView *)adView;


/*!
 @method willDismissModalFromAd:
 @discussion 広告ビュー画面が閉じる前に呼び出されるメソッド
 @param adView 広告ビュー
 */
- (void)willDismissModalFromAd:(LogoAdView *)adView;

/*!
 @method didDismissModalFromAd:
 @discussion 広告ビュー画面が閉じた後に呼び出されるメソッド
 @param adView 広告ビュー
 */
- (void)didDismissModalFromAd:(LogoAdView *)adView;


@end
