//
//  LogoAdRequestError.h
//  Logo AD SDK
//
//  Created by nsp
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @const kLogoAdErrorDomain
 @discussion LogoAdRequestErrorで発行するエラードメイン
 */
extern NSString *kLogoAdErrorDomain;

/*!
 @enum LogoAdErrorCode
 @discussion 広告リクエスト時のエラーコード
 @const kLogoAdErrorInvalidRequest リクエストに失敗した場合のエラー
 @const kLogoAdErrorNoAd リクエストは成功したが、広告が取得できなかった場合のエラー
 @const kLogoAdNetworkError ネットワークからデータが取得できない場合のエラー
 @const kLogoAdOSVersionTooLow 本SDK実行に必要なOSバージョンに満たない場合のエラー
 @const kLogoAdErrorTimeout タイムアウト発生時のエラー
 @const kLogoAdErrorDefaultSetting LogoAdViewのサイズやアプリ指定のパラメータが有効でない場合のエラー
 */
typedef enum {
	kLogoAdErrorInvalidRequest,
	kLogoAdErrorNoAd,
	kLogoAdNetworkError,
	kLogoAdOSVersionTooLow,
	kLogoAdErrorTimeout,
	kLogoAdErrorDefaultSetting,
} LogoAdErrorCode;

/*!
 @class LogoAdRequestError
 @superclass NSError
 @discussion 広告リクエスト時に発行されるエラークラス
 */
@interface LogoAdRequestError : NSError

@end
