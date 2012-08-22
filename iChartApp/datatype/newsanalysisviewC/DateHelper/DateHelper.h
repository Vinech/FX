//
//  DateHelper.h
//  YesTime
//
//  Created by Zhuofeng Li on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateHelper : NSObject

+(NSDate *)stringToDate: (NSString *)dstr;
+(NSString *)convertToReadableDate: (NSDate *)date;
+ (NSDate *)weiboStringToDate: (NSString*)stringDate;
+(NSString *)convertToReadableDateForPhotoFlow: (NSDate *)date;
+ (NSString*)getFirstRecordUpdateTime: (NSDate *)date;

@end
