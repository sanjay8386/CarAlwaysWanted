//
//  XMLAPICall.m
//  RestfulAPIDemo
//
//  Created by SOFT on 05/05/14.
//  Copyright (c) 2014 SOFT. All rights reserved.
//

#import "XMLAPICall.h"
#import "XMLDictionary.h"
#import "AFHTTPRequestOperationManager.h"

@implementation XMLAPICall

+ (void)executeAPICall:(NSString *)verb data: (id )obj completion: (void (^)(id, NSInteger, NSError*))callback {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"data":obj};

    [manager POST:BASEURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self processDataCallback:callback response:operation.response data:responseObject error:operation.error];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        return ;
    }];
}

+ (NSOperationQueue *)RESTQueue {
    static dispatch_once_t		once;
    static NSOperationQueue		*callQueue;
    dispatch_once(&once, ^ {
		callQueue = [[NSOperationQueue alloc] init];
	});
	
    return callQueue;
}

+ (void)processDataCallback: (void (^)(id, NSInteger, NSError*))callback
				   response: (NSHTTPURLResponse *)response
					   data: (id)data
					  error: (NSError *)error {
    
    NSInteger	statusCode	= response.statusCode;
	if (error && !statusCode &&
		([error code] == NSURLErrorUserCancelledAuthentication))
		statusCode	= 401;
	if (callback) {
		if (error || statusCode == 304)
			callback(nil, statusCode, error);
		else {
			NSError __autoreleasing	*anErr	= nil;
            id anObj = [NSDictionary dictionaryWithXMLData:data];
			if ([[anObj  objectForKey:@"result"] isEqualToString:@"error"]) {
                anErr	= [NSError errorWithDomain: BASEURL
											code: statusCode
										userInfo: @{ NSLocalizedDescriptionKey:[[anObj objectForKey: @"data"] objectForKey:@"errorDescription"] }];
				
				callback(nil, statusCode, anErr);
			} else {
				callback(anObj, statusCode, anErr);
			}
		}
	}
}

+ (void)processDateCallback: (void (^)(id, NSInteger, NSError*))callback
				   response: (NSURLResponse *)response
					   data: (NSData *)data
					  error: (NSError *)error {
	NSInteger	statusCode	= [(NSHTTPURLResponse *)response statusCode];
	if (error && !statusCode &&
		([error code] == NSURLErrorUserCancelledAuthentication))
		statusCode	= 401;
	
	if (callback) {
		if (error || statusCode == 304)
			callback(nil, statusCode, error);
		else {
			NSError __autoreleasing	*anErr	= nil;
            id anObj = [NSDictionary dictionaryWithXMLData:data];
			if ([[anObj objectForKey: @"data"] objectForKey:@"result"]) {
				anErr	= [NSError errorWithDomain: BASEURL
											code: statusCode
										userInfo: @{ NSLocalizedDescriptionKey:[anObj objectForKey: @"error"] }];
				
				callback(nil, statusCode, anErr);
			} else {
				callback(anObj, statusCode, anErr);
			}
		}
	}
}

+(void)verifyDeviceID: (NSString *)anDeviceId  completion: (void (^)(id, NSInteger, NSError*))callback {
    if (anDeviceId) {
         NSString *STR22 = [NSString stringWithFormat:@"<caw><action>getAuthKeyApple</action><parameters><deviceId>%@</deviceId></parameters></caw>",anDeviceId];
		[self executeAPICall:@"POST" data:STR22  completion: callback];
        
	} else {
		// TODO: Alert user?
	}
}


+ (void)getYear:(NSString *)anDeviceId authKey:(NSString *)anAuthKey completion: (void (^)(id, NSInteger, NSError*))callback {
    
    if (anAuthKey && anDeviceId) {
        NSString *xmlgetYear =[NSString stringWithFormat:@"<caw><action>getYear</action><parameters><deviceId>%@</deviceId><authkey><![CDATA[%@]]></authkey></parameters></caw>",anDeviceId,anAuthKey];
        [self executeAPICall:@"POST" data:xmlgetYear completion:callback];
    }
}

+ (void)getMake:(NSString *)anDeviceId authKey:(NSString *)anAuthKey year:(NSString *)year completion: (void (^)(id, NSInteger, NSError*))callback {
    
    if (anAuthKey && anDeviceId) {
        NSString *xmlgetMake =[NSString stringWithFormat:@"<caw><action>getMake</action><parameters><deviceId>%@</deviceId><authkey><![CDATA[%@]]></authkey><year>%@</year></parameters></caw>",anDeviceId,anAuthKey,year];
        [self executeAPICall:@"POST" data:xmlgetMake completion:callback];
    }
}


+ (void)getModel:(NSString *)anDeviceId authKey:(NSString *)anAuthKey year:(NSString *)year make:(NSString *)make completion: (void (^)(id, NSInteger, NSError*))callback {
    
    if (anAuthKey && anDeviceId) {
        NSString *xmlgetMake =[NSString stringWithFormat:@"<caw><action>getmodelData</action><parameters><deviceId>%@</deviceId><authkey><![CDATA[%@]]></authkey><year>%@</year><make>%@</make></parameters></caw>",anDeviceId,anAuthKey,year,make];
        [self executeAPICall:@"POST" data:xmlgetMake completion:callback];
    }
}

+ (void)getCylinder:(NSString *)anDeviceId authKey:(NSString *)anAuthKey year:(NSString *)year make:(NSString *)make model:(NSString *)model transmission:(NSString *)transmission completion: (void (^)(id, NSInteger, NSError*))callback {
    
    if (anAuthKey && anDeviceId) {
        NSString *xmlgetCylinder =[NSString stringWithFormat:@"<caw><action>getcylinderData</action><parameters><deviceId>%@</deviceId><authkey><![CDATA[%@]]></authkey><year>%@</year><make>%@</make><model>%@</model><transmission>%@</transmission></parameters></caw>",anDeviceId,anAuthKey,year,make];
        [self executeAPICall:@"POST" data:xmlgetCylinder completion:callback];
    }
}

















+(void)sendLoginRequest:(NSString *)anDeviceId authKey:(NSString*)anAuthKey userCode:(NSString *)anUserCode completion: (void (^)(id, NSInteger, NSError*))callback {
    if (anAuthKey && anDeviceId) {
        NSString *xmlsendLoginRequest =[NSString stringWithFormat:@"<tsf><action>doLogin</action><parameters><authkey><![CDATA[%@]]></authkey><deviceId>%@</deviceId><usercode>%@</usercode></parameters></tsf>",anAuthKey,anDeviceId,anUserCode];
        [self executeAPICall:@"POST" data:xmlsendLoginRequest completion:callback];
    }
}

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
               completion: (void (^)(id, NSInteger, NSError*))callback {
    if (anAuthKey && anDeviceId) {
        NSMutableString *xmlSendNewUserRequest =[NSMutableString stringWithFormat:@"<tsf><action>registerUser</action><parameters><authkey><![CDATA[%@]]></authkey><deviceId>%@</deviceId><company_detail><name>%@</name><abn_no>%@</abn_no><address>%@</address><suburb>%@</suburb><postcode>%@</postcode><state>%@</state><mobile>%@</mobile><fax>%@</fax><users>",anAuthKey,anDeviceId,aName,anAbn_no,anAddress,aSuburb,aPostCode,aState,aPhone,aFax];
        for (int i = 0; i < [aUsername count]; i++) {
            if (![[aUsername objectAtIndex:i] isEqualToString:@"ENTER NAME"] && ![[anUserEmail objectAtIndex:i] isEqualToString:@"ENTER EMAIL"] && ![[userMobile objectAtIndex:i] isEqualToString:@"ENTER MOBILE"]) {
                 [xmlSendNewUserRequest appendString:[NSString stringWithFormat:@"<user><name>%@</name><email>%@</email><mobile>%@</mobile></user>",[aUsername objectAtIndex:i],[anUserEmail objectAtIndex:i],[userMobile objectAtIndex:i]]];
            } else {
                
            }
        }
        [xmlSendNewUserRequest appendString:@"</users></company_detail></parameters></tsf>"];
        [self  executeAPICall:@"POST" data:xmlSendNewUserRequest completion:callback];
    }
}

+ (void)getCategoryList:(NSString *)anDeviceId authKey:(NSString *)anAuthKey  completion: (void (^)(id, NSInteger, NSError*))callback {
    if (anDeviceId && anAuthKey) {
       
        NSString *xmlgetCatlist =[NSString stringWithFormat:@"<tsf><action>getCategories</action><parameters><authkey><![CDATA[%@]]></authkey><deviceId>%@</deviceId><sortOrderField>id</sortOrderField><sortOrderType>asc</sortOrderType><fetchWithProducts>1</fetchWithProducts></parameters></tsf>",anAuthKey,anDeviceId];
        [self executeAPICall:@"POST" data:xmlgetCatlist completion:callback];
    }
}

+ (void)getCategoryDetail:(NSString *)anDeviceId authKey:(NSString *)anAuthKey usercode:(NSString *)aUserCode CategoryId:(NSString *)anCategoryId completion: (void (^)(id, NSInteger, NSError*))callback {
    if (anAuthKey && anCategoryId && anDeviceId) {
        
        NSString *xmlgetCategoryDetail =[NSString stringWithFormat:@"<tsf><action>getCategory</action><parameters><authkey><![CDATA[%@]]></authkey><deviceId>%@</deviceId><usercode>%@</usercode><categoryId>%@</categoryId><categoryDetail>3</categoryDetail><productList><sortOrderField>id</sortOrderField><sortOrderType>asc</sortOrderType><fetchWithProducts>1</fetchWithProducts></productList></parameters></tsf>",anAuthKey,anDeviceId,aUserCode,anCategoryId];
        [self executeAPICall:@"POST" data:xmlgetCategoryDetail completion:callback];
    }
}

+ (void)getProductDetail:(NSString *)anDeviceId authKey:(NSString *)anAuthKey ProductId:(NSString *)anProductId completion: (void (^)(id, NSInteger, NSError*))callback {
    if (anAuthKey && anDeviceId && anProductId) {
        NSString *xmlgetProductDetail =[NSString stringWithFormat:@"<tsf><action>getProduct</action><parameters><authkey><![CDATA[%@]]></authkey><deviceId>%@</deviceId><productId>%@</productId></parameters></tsf>",anAuthKey,anDeviceId,anProductId];
        [self executeAPICall:@"POST" data:xmlgetProductDetail completion:callback];
    }
}

+(void)sendLogoutRequest:(NSString *)anDeviceId authKey:(NSString *)anAuthKey userCode:(NSString *)anUserCode loginSessionId:(NSString *)aloginSessionId completion: (void (^)(id, NSInteger, NSError*))callback {
    if (anAuthKey && anDeviceId && aloginSessionId) {
        NSString *xmlsendLogoutRequest =[NSString stringWithFormat:@"<tsf><action>logout</action><parameters><authkey><![CDATA[%@]]></authkey><deviceId>%@</deviceId><usercode>%@</usercode><loginsessionid><![CDATA[%@]]></loginsessionid></parameters></tsf>",anAuthKey,anDeviceId,anUserCode,aloginSessionId];
        [self executeAPICall:@"POST" data:xmlsendLogoutRequest completion:callback];
    }
}

/*
+(void)sendProductEnquiry:(NSString *)anDeviceId authKey:(NSString *)anAuthKey name:(NSString *)aName email:(NSString *)anEmail phone:(NSString *)aPhone fax:(NSString *)aFax address:(NSString *)anAddress suburb:(NSString *)aSuburb postcode:(NSString *)aPostCode state:(NSString *)aState totalNoOfProducts:(NSString *)aTotalNoOfProducts ProductId:(NSString *)anProductId ProductName:(NSString *)aProductName totalNumberofAttr:(NSString *)aTotalAttr attributeAry:(NSMutableArray *)attributeArray completion: (void (^)(id, NSInteger, NSError*))callback
{
    if (anAuthKey && anDeviceId && anProductId && attributeArray.count > 0)
    {
        NSMutableString *xmlSendEnquiry =[NSMutableString stringWithFormat:@"<tsf><action>storeEnquiry</action><parameters><authkey><![CDATA[%@]]></authkey><deviceId>%@</deviceId><name>%@</name><email>%@</email><phone>%@</phone><fax>%@</fax><address>%@</address><suburb>%@</suburb><postcode>%@</postcode><state>%@</state><totalNoOfProducts>1</totalNoOfProducts><products><product><productId>%@</productId><productName>%@</productName><totalNoOfAttributes>%@</totalNoOfAttributes><attributes>",anAuthKey,anDeviceId,aName,anEmail,aPhone,aFax,anAddress,aSuburb,aPostCode,aState,anProductId,aProductName,aTotalAttr];
        for (int i = 0; i < attributeArray.count; i++)
        {
            TSAttributes *attributeObj =[attributeArray objectAtIndex:i];
            [xmlSendEnquiry appendString:[NSString stringWithFormat:@"<attribute><code>%@</code><size>%@</size><weight>%@</weight><qty>%@</qty></attribute>",attributeObj.strCode,attributeObj.strSize,attributeObj.strWeight,attributeObj.strQty]];
        }
        [xmlSendEnquiry appendString:@"</attributes></product></products></parameters></tsf>"];
        [self executeAPICall:@"POST" data:xmlSendEnquiry completion:callback];
    }
}*/

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
               completion: (void (^)(id, NSInteger, NSError*))callback {
    
    //    if (anAuthKey && anDeviceId && anProductId && attributeArray.count > 0) {
    
    NSMutableString *xmlSendEnquiry =[NSMutableString stringWithFormat:@"<tsf><action>storeEnquiry</action><parameters><authkey><![CDATA[%@]]></authkey>                                          <deviceId>%@</deviceId><usercode>%@</usercode><name>%@</name><email>%@</email><mobile>%@</mobile><fax>%@</fax><shipping_required>%@</shipping_required><order_confirmation>%@</order_confirmation><billing_address>%@</billing_address><billing_suburb>%@</billing_suburb><billing_postcode>%@</billing_postcode><billing_state>%@</billing_state><shipp_add_same_to_billing_add>%@</shipp_add_same_to_billing_add><shipping_address>%@</shipping_address><shipping_suburb>%@</shipping_suburb><shipping_postcode>%@</shipping_postcode><shipping_state>%@</shipping_state><totalNoOfProducts>%lu</totalNoOfProducts><products>",anAuthKey,anDeviceId,aUserCode,aName,anEmail,aPhone,aFax,aShipping,aConfirmation,anAddress,aSuburb,aPostCode,aState,aShippingBillingSame,aShippingAddress,aShippingSuburb,aShippingPostode,aShippingState,(unsigned long)[anProductId count]];
    
    for (int i = 0;i < [anProductId count]; i++) {
        [xmlSendEnquiry appendString:[NSString stringWithFormat:@"<product><productId>%@</productId><productName>%@</productName><totalNoOfAttributes>%@</totalNoOfAttributes><attributes>",[[anProductId objectAtIndex:i] objectForKey:@"productId"],
                                      [[anProductId objectAtIndex:i] objectForKey:@"productName"],
                                      [[anProductId objectAtIndex:i] objectForKey:@"noOfAttributes"]]];
        
        for (int j = 0; j < [[[[anProductId objectAtIndex:i] objectForKey:@"attributes"] objectForKey:@"attribute" ] count]; j++) {
            [xmlSendEnquiry appendString:[NSString stringWithFormat:@"<attribute><code>%@</code><size>%@</size><weight>%@</weight><qty>%@</qty></attribute>",[[[[[anProductId objectAtIndex:i] objectForKey:@"attributes"] objectForKey:@"attribute" ] objectAtIndex:j] objectForKey:@"code"],
                                          [[[[[anProductId objectAtIndex:i] objectForKey:@"attributes"] objectForKey:@"attribute" ] objectAtIndex:j] objectForKey:@"size"],
                                          [[[[[anProductId objectAtIndex:i] objectForKey:@"attributes"] objectForKey:@"attribute" ] objectAtIndex:j] objectForKey:@"weight"],[[[[[anProductId objectAtIndex:i] objectForKey:@"attributes"] objectForKey:@"attribute" ] objectAtIndex:j] objectForKey:@"qty"]]];
            
        }
        [xmlSendEnquiry appendString:[NSString stringWithFormat:@"</attributes></product>"]];
    }
    
    [xmlSendEnquiry appendString:@"</products></parameters></tsf>"];
    [self executeAPICall:@"POST" data:xmlSendEnquiry completion:callback];
}

+(void)getUserHistory:(NSString *)anDeviceId authKey:(NSString *)anAuthKey usercode:(NSString *)aUserCode loginsessionid:(NSString *)anLoginsessionid completion: (void (^)(id, NSInteger, NSError*))callback {
    if (anAuthKey && anDeviceId && aUserCode) {
        NSString *xmlUserhistory =[NSString stringWithFormat:@"<tsf><action>getOrders</action><parameters><authkey><![CDATA[%@]]></authkey><deviceId>%@</deviceId><usercode>%@</usercode><loginsessionid><![CDATA[%@]]></loginsessionid></parameters></tsf>",anAuthKey,anDeviceId,aUserCode,anLoginsessionid];
        [self executeAPICall:@"POST" data:xmlUserhistory completion:callback];
    }
}

+(void)getOrderHistoryDetail:(NSString *)anDeviceId authKey:(NSString *)anAuthKey usercode:(NSString *)aUserCode loginsessionid:(NSString *)anLoginsessionid orderid:(NSString *)anOrderId completion: (void (^)(id, NSInteger, NSError*))callback {
    if (anAuthKey && anDeviceId && aUserCode && anOrderId && anLoginsessionid) {
        NSString *xmlgetOrderDetail =[NSString stringWithFormat:@"<tsf><action>orderDetail</action><parameters><authkey><![CDATA[%@]]></authkey><deviceId>%@</deviceId><usercode>%@</usercode><loginsessionid><![CDATA[%@]]></loginsessionid><orderid>%@</orderid></parameters></tsf>",anAuthKey,anDeviceId,aUserCode,anLoginsessionid,anOrderId];
        [self executeAPICall:@"POST" data:xmlgetOrderDetail completion:callback];
    }
}

+(void)acceptTermsandCondition:(NSString *)anAuthKey deviceId:(NSString *)anDeviceId usercode:(NSString *)anUserCode loginsessionid:(NSString *)anLoginsessionid completion: (void (^)(id, NSInteger, NSError*))callback {
    if (anAuthKey && anDeviceId && anUserCode &&  anLoginsessionid) {
        NSString *xmlsendTNC =[NSString stringWithFormat:@"<tsf><action>acceptTNC</action><parameters><authkey><![CDATA[%@]]></authkey><deviceId>%@</deviceId><usercode>%@</usercode><loginsessionid><![CDATA[%@]]></loginsessionid><tnc>%@</tnc></parameters></tsf>",anAuthKey,anDeviceId,anUserCode,anLoginsessionid,[NSNumber numberWithInteger:1]];
        [self executeAPICall:@"POST" data:xmlsendTNC completion:callback];
    }
}

+(void)updateUserProfile:(NSString *)anAuthKey deviceId:(NSString *)anDeviceId usercode:(NSString *)anUserCode loginsessionid:(NSString *)anLoginsessionid name:(NSString *)aUsername email:(NSString *)anEmail mobile:(NSString *)aMobile completion: (void (^)(id, NSInteger, NSError*))callback {
    if (anAuthKey && anDeviceId && anUserCode &&  anLoginsessionid && aUsername && anEmail && aMobile) {
        NSString *xmlsendUserUpdate =[NSString stringWithFormat:@"<tsf><action>updateProfile</action><parameters><authkey><![CDATA[%@]]></authkey><deviceId>%@</deviceId><usercode>%@</usercode><loginsessionid><![CDATA[%@]]></loginsessionid><userdata><name>%@</name><email>%@</email><mobile>%@</mobile></userdata></parameters></tsf>",anAuthKey,anDeviceId,anUserCode,anLoginsessionid,aUsername,anEmail,aMobile];
        [self executeAPICall:@"POST" data:xmlsendUserUpdate completion:callback];
    }
}

+(void)getUserProfile:(NSString *)anAuthKey deviceId:(NSString *)anDeviceId usercode:(NSString *)anUserCode loginsessionid:(NSString *)anLoginsessionid  completion: (void (^)(id, NSInteger, NSError*))callback {
    if (anAuthKey && anDeviceId && anUserCode &&  anLoginsessionid) {
        NSString *xmlgetUserProfile =[NSString stringWithFormat:@"<tsf><action>getProfile</action><parameters><authkey><![CDATA[%@]]></authkey><deviceId>%@</deviceId><usercode>%@</usercode><loginsessionid><![CDATA[%@]]></loginsessionid></parameters></tsf>",anAuthKey,anDeviceId,anUserCode,anLoginsessionid];
        [self executeAPICall:@"POST" data:xmlgetUserProfile completion:callback];
    }
}

@end