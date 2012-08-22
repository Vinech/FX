//
//  NewsSearchViewController.h
//  iChartApp
//
//  Created by 张少南 on 12-8-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsSearchViewController : UITableViewController
{
    
    NSMutableDictionary * dictionary_weibo;
    NSString * stringtext;
}


@property(nonatomic,strong)NSString * titleStr;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)UIActivityIndicatorView * loadingIndicator;


@end
