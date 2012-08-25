//
//  eightbyte.m
//  iChartApp
//
//  Created by vinech.SZK on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "eightbyte.h"

@implementation eightbyte
@synthesize type=_type,string=_string;
//@synthesize string;
//-(void)shengchengdata:(NSString *)string_request type(short)tyoe_{
//    short length_zhuce=string_request.length*2;
//    int8_t ch[2];
//    ch[0] = (length_zhuce & 0x0ff00)>>8;  
//    ch[1] = (length_zhuce & 0x0ff);  
//    
//    
//    //  NSLog(@"=====%d",sizeof(length_zhuce));
//    short type=1106;
//    int8_t mm[2];
//    mm[0] = (type & 0x0ff00)>>8;  
//    mm[1] = (type & 0x0ff);  
//    
//    
//    int zero=0;
//    //   NSData *data_length=[NSData da];
//    NSMutableData *alldata=[[NSMutableData alloc]init];
//    
//    NSData * zeroData = [NSData dataWithBytes:&zero length:4];
//    NSData *data=[string_request dataUsingEncoding:NSUTF16BigEndianStringEncoding];
//    
//    [alldata appendBytes:ch length:2];
//    [alldata appendBytes:mm length:2];
//    [alldata appendData:zeroData];
//    
//    [alldata appendData:data];
//    NSData *requestData = [[NSMutableData alloc]init];
//    requestData=alldata;
//    
//    
//}
+(NSData *)shengchengdata:(NSString *)string_request type:(short)type_{
       short length_zhuce=string_request.length*2;
       int8_t ch[2];
       ch[0] = (length_zhuce & 0x0ff00)>>8;  
        ch[1] = (length_zhuce & 0x0ff);  
        
        
       int8_t mm[2];
       mm[0] = (type_ & 0x0ff00)>>8;  
        mm[1] = (type_ & 0x0ff);  
    
      
    int zero=0;
    NSMutableData *alldata=[[NSMutableData alloc]init];
    
       NSData * zeroData = [NSData dataWithBytes:&zero length:4];
     NSData *data=[string_request dataUsingEncoding:NSUTF16BigEndianStringEncoding];
   
    [alldata appendBytes:ch length:2];
       [alldata appendBytes:mm length:2];
  [alldata appendData:zeroData];
   
        [alldata appendData:data];
        NSData *requestData = [[NSMutableData alloc]init];
       requestData=alldata;
      
    return requestData;
}

@end
