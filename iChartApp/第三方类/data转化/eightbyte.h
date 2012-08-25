//
//  eightbyte.h
//  iChartApp
//
//  Created by vinech.SZK on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface eightbyte : NSObject
@property (nonatomic,strong)NSString *string;
@property (nonatomic,assign)short type;

+(NSData*)shengchengdata:(NSString *)string_request type:(short)type_;
@end
