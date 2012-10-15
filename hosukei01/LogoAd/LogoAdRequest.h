//
//  LogoAdRequest.h
//  Logo AD SDK
//
//  Created by nsp
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

/*!
 @enum LogoAdGender
 @discussion 性別パラメータのENUM定義
 @const LogoAdGenderUnknown 性別未指定
 @const LogoAdGenderMale 男性
 @const LogoAdGenderFemale 女性
 */
typedef enum {
	LogoAdGenderUnknown=0, // default
	LogoAdGenderMale,
	LogoAdGenderFemale,
} LogoAdGender;


/*!
 @class LogoAdRequest
 @superclass NSObject
 @discussion LogoAdのリクエスト用クラス
 */
@interface LogoAdRequest : NSObject

/*!
 @property pubId
 パブリッシャーID
 */
@property (nonatomic, retain) NSString *pubId;

/*!
 @property latitude
 @discussion 緯度パラメータ
 */
@property (nonatomic, retain) NSNumber *latitude;

/*!
 @property longitude
 @discussion 経度パラメータ
 */
@property (nonatomic, retain) NSNumber *longitude;

/*!
 @property address
 @discussion 住所文字列パラメータ
 */
@property (nonatomic, retain) NSString *address;

/*!
 @property zipCode
 @discussion 郵便番号パラメータ
 */
@property (nonatomic, retain) NSString *zipCode;

/*!
 @property keywords
 @discussion キーワードパラメータ
 */
@property (nonatomic, retain) NSArray *keywords;

/*!
 @property gender
 @discussion 性別パラメータ
 */
@property (nonatomic, assign) LogoAdGender gender;

/*!
 @property birthday
 @discussion 誕生日パラメータ
 */
@property (nonatomic, retain) NSDate *birthday;

/*!
 @property testing
 @discussion テストモード
 */
@property (nonatomic, assign) BOOL testing;

/*!
 @property traceLocation
 @discussion YESのとき、位置情報が利用できるならば自動的に広告サーバーに通知する
 */
@property (nonatomic, assign) BOOL traceLocation;


# pragma mark --- LogoAdRequest Creation Methods

/*!
 @method requestWithId:
 @discussion リクエストインスタンス作成メソッド
 autoreleaseインスタンスが生成され返される
 @param pubId パブリッシャーID
 @result LogoAdRequestインスタンス
 */
+ (LogoAdRequest *)requestWithId:(NSString *)pubId;


# pragma mark --- LogoAdRequest Utility Methods

/*!
 @method setLocationWithLatitude:longitude:
 @discussion 位置情報設定(緯度経度)
 広告取得時に緯度経度位置情報パラメータを渡す場合に指定
 @param latitude 緯度
 @param longitude 経度
 */
- (void)setLocationWithLatitude:(CGFloat)latitude longitude:(CGFloat)longitude;

/*!
 @method isTesting
 @discussion テストモードのステータスをBOOL値で返す
 @result テストモードで実行中の場合はYESを返す
 */
- (BOOL)isTesting;



@end
