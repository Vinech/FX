//
//  DateHelper.m
//  YesTime
//
//  Created by Zhuofeng Li on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

/*


*/
#import "DateHelper.h"

@implementation DateHelper

+ (NSDate *)weiboStringToDate: (NSString*)stringDate
{
    NSString * monthDate = [[stringDate substringToIndex:7] substringFromIndex:4];
    NSString * yearDate = [[stringDate substringToIndex:30] substringFromIndex:25];
    NSString * dayDate = [[stringDate substringToIndex:10] substringFromIndex:8];
    NSString * timeDate = [[stringDate substringToIndex:19] substringFromIndex:10];
    
    if ([monthDate isEqualToString:@"Jan"]) 
    {
       monthDate = @"01"; 
    }else if ([monthDate isEqualToString:@"Feb"]) 
    {
        monthDate = @"02";
    }else if ([monthDate isEqualToString:@"Mar"]) 
    {
        monthDate = @"03";
    }else if ([monthDate isEqualToString:@"Apr"]) 
    {
        monthDate = @"04";
    }else if ([monthDate isEqualToString:@"May"]) 
    {
        monthDate = @"05";
    }else if ([monthDate isEqualToString:@"Jun"]) 
    {
        monthDate = @"06";
    }else if ([monthDate isEqualToString:@"Jul"]) 
    {
        monthDate = @"07";
    }else if ([monthDate isEqualToString:@"Aug"]) 
    {
        monthDate = @"08";
    }else if ([monthDate isEqualToString:@"Sep"]) 
    {
        monthDate = @"09";
    }else if ([monthDate isEqualToString:@"Oct"]) 
    {
        monthDate = @"10";
    }else if ([monthDate isEqualToString:@"Nov"]) 
    {
        monthDate = @"11";
    }else if ([monthDate isEqualToString:@"Dec"]) 
    {
        monthDate = @"12";
    }
    
    
    
    
    
    NSString * allTime = [NSString stringWithFormat:@"%@-%@-%@ %@",yearDate,monthDate,dayDate,timeDate];
    
  
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
//    [format setDateFormat:@"EEE MMM dd HH:mm:ss zzz yyyy"];
    
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    
    NSDate *date = [format dateFromString:allTime];
    //            Wed Aug 15 11:31:24 +0800 2012
    //            2012-08-16 10:32:34 +0000
    
    
 
    return date;
}

+(NSDate *)stringToDate: (NSString *)dstr
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * date = [formatter dateFromString:dstr];
    return date;
}

+(NSString *)convertToReadableDate: (NSDate *)date{
    NSDate *now = [NSDate date];
    NSTimeInterval timeDifference = [now timeIntervalSinceDate:date];
    
    int min = 1;
    int hour = 60;
    int day = 60*24;
    int week = 60*24*7;
    int month = 60*24*30;
    
    int diffInMins = timeDifference / 60;
    NSString * result;
    
    if(diffInMins < min){
            result = @"刚刚";
    }
    else if(diffInMins < hour) 
    {
        result = [NSString stringWithFormat:@"刚刚",(diffInMins/min)];
    }
    else if(diffInMins < day) 
    {
        result = [NSString stringWithFormat:@"刚刚",(diffInMins/hour)];
    }
    else if(diffInMins < week) 
    {
        result = [NSString stringWithFormat:@"1天前",(diffInMins/day)];
    }
    else if(diffInMins < month) 
    {
        result = [NSString stringWithFormat:@"1周前",(diffInMins/week)];
    }
    else 
    {
        result = [NSString stringWithFormat:@"1个月前",(diffInMins/month)];
    }
    
    return result;
}

+(NSString *)convertToReadableDateForPhotoFlow: (NSDate *)date{
    NSDate *now = [NSDate date];
    NSTimeInterval timeDifference = [now timeIntervalSinceDate:date];
    
    int min = 1;
    int hour = 60;
    int day = 60*24;
    int week = 60*24*7;
    int month = 60*24*30;
    
    int diffInMins = timeDifference / 60;
    NSString * result;
    
    if(diffInMins < min){
        result = @"今天";
    }
    else if(diffInMins < hour) {
        result = [NSString stringWithFormat:@"今天",(diffInMins/min)];
    }
    else if(diffInMins < day) {
        result = [NSString stringWithFormat:@"今天",(diffInMins/hour)];
    }
    else if(diffInMins < week) {
        if (diffInMins/day ==1) {
            result = [NSString stringWithFormat:@"昨天"];

        }else {
            result = [NSString stringWithFormat:@"%d天前",(diffInMins/day)];
        }
    }
    else if(diffInMins < month) {
        result = [NSString stringWithFormat:@"%d周前",(diffInMins/week)];
    }
    else {
        result = [NSString stringWithFormat:@"%d个月前",(diffInMins/month)];
    }
    
    return result;
}

+ (NSString*)getFirstRecordUpdateTime: (NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *recordTime = [dateFormatter stringFromDate:date];
    return recordTime;
}





@end




