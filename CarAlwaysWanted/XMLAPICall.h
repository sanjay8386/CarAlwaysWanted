//
//  XMLAPICall.h
//  RestfulAPIDemo
//
//  Created by SOFT on 05/05/14.
//  Copyright (c) 2014 SOFT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLAPICall : NSObject

+ (NSOperationQueue *)RESTQueue;
+ (void)executeAPICall:(NSString *)verb data: (id)obj completion: (void (^)(id, NSInteger, NSError*))callback;

+ (void)verifyDeviceID: (NSString *)anDeviceId  completion: (void (^)(id, NSInteger, NSError*))callback;


+ (void)getYear:(NSString *)anDeviceId authKey:(NSString *)anAuthKey completion: (void (^)(id, NSInteger, NSError*))callback;

+ (void)getMake:(NSString *)anDeviceId authKey:(NSString *)anAuthKey year:(NSString *)year completion: (void (^)(id, NSInteger, NSError*))callback;

+ (void)getModel:(NSString *)anDeviceId authKey:(NSString *)anAuthKey year:(NSString *)year make:(NSString *)make completion: (void (^)(id, NSInteger, NSError*))callback;

+ (void)getCylinder:(NSString *)anDeviceId authKey:(NSString *)anAuthKey year:(NSString *)year make:(NSString *)make model:(NSString *)model transmission:(NSString *)transmission completion: (void (^)(id, NSInteger, NSError*))callback;








+(void)sendLoginRequest:(NSString *)anDeviceId authKey:(NSString *)anAuthKey userCode:(NSString *)anUserCode completion: (void (^)(id, NSInteger, NSError*))callback;
+(void)sendNewUserRequest:(NSString *)anDeviceId
                  authKey:(NSString *)anAuthKey
                     name:(NSString *)aName
                   abn_no:(NSString *)anAbn_no
                  address:(NSString *)anAddress
                    phone:(NSString *)aPhone
                      fax:(NSString *)aFax
                   suburb:(NSString *)aSuburb
                 postcode:(NSString *)aPostCode
                    state:(NSString *)aState
                 username:(NSMutableArray *)aUsername
                useremail:(NSMutableArray *)anUserEmail
                   mobile:(NSMutableArray *)userMobile
               completion: (void (^)(id, NSInteger, NSError*))callback;

+(void)getUserHistory:(NSString *)anDeviceId authKey:(NSString *)anAuthKey usercode:(NSString *)aUserCode loginsessionid:(NSString *)anLoginsessionid completion: (void (^)(id, NSInteger, NSError*))callback;

+ (void)getCategoryList:(NSString *)anDeviceId authKey:(NSString *)anAuthKey  completion: (void (^)(id, NSInteger, NSError*))callback;
+ (void)getCategoryDetail:(NSString *)anDeviceId authKey:(NSString *)anAuthKey usercode:(NSString *)aUserCode CategoryId:(NSString *)anCategoryId completion: (void (^)(id, NSInteger, NSError*))callback;
+ (void)getProductDetail:(NSString *)anDeviceId authKey:(NSString *)anAuthKey ProductId:(NSString *)anProductId completion: (void (^)(id, NSInteger, NSError*))callback;
+(void)sendProductEnquiry:(NSString *)anDeviceId
                  authKey:(NSString *)anAuthKey
                 userCode:(NSString *)aUserCode
                     name:(NSString *)aName
                    email:(NSString *)anEmail
                    phone:(NSString *)aPhone
                      fax:(NSString *)aFax
                 shipping:(NSString *)aShipping
             confirmation:(NSString *)aConfirmation
                  address:(NSString *)anAddress
                   suburb:(NSString *)aSuburb
                 postcode:(NSString *)aPostCode
                    state:(NSString *)aState
      shippingbillingsame:(NSString *)aShippingBillingSame
          shippingaddress:(NSString *)aShippingAddress
           shippingsuburb:(NSString *)aShippingSuburb
         shippingpostcode:(NSString *)aShippingPostode
            shippingstate:(NSString *)aShippingState
        totalNoOfProducts:(NSString *)aTotalNoOfProducts
                ProductId:(NSMutableArray *)anProductId
               completion: (void (^)(id, NSInteger, NSError*))callback;
+(void)sendLogoutRequest:(NSString *)anDeviceId authKey:(NSString *)anAuthKey userCode:(NSString *)anUserCode loginSessionId:(NSString *)loginSessionId completion: (void (^)(id, NSInteger, NSError*))callback;

+(void)getOrderHistoryDetail:(NSString *)anDeviceId authKey:(NSString *)anAuthKey usercode:(NSString *)aUserCode loginsessionid:(NSString *)anLoginsessionid orderid:(NSString *)anOrderId completion: (void (^)(id, NSInteger, NSError*))callback;

+(void)acceptTermsandCondition:(NSString *)anAuthKey deviceId:(NSString *)anDeviceId usercode:(NSString *)anUserCode loginsessionid:(NSString *)anLoginsessionid completion: (void (^)(id, NSInteger, NSError*))callback;

+(void)updateUserProfile:(NSString *)anAuthKey deviceId:(NSString *)anDeviceId usercode:(NSString *)anUserCode loginsessionid:(NSString *)anLoginsessionid name:(NSString *)aUsername email:(NSString *)anEmail mobile:(NSString *)aMobile completion: (void (^)(id, NSInteger, NSError*))callback;

+(void)getUserProfile:(NSString *)anAuthKey deviceId:(NSString *)anDeviceId usercode:(NSString *)anUserCode loginsessionid:(NSString *)anLoginsessionid  completion: (void (^)(id, NSInteger, NSError*))callback;
@end