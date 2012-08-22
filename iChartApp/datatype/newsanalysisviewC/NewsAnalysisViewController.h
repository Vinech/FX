//
//  NewsAnalysisViewController.h
//  iChart
//
//  Created by bin huang on 12-7-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBEngine.h"
#import "EGORefreshTableHeaderDelegate.h"
#import "EGORefreshTableHeaderView.h"
@interface NewsAnalysisViewController : UIViewController<UIActionSheetDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,WBEngineDelegate,EGORefreshTableHeaderDelegate>{
    WBEngine * engine;
    NSMutableArray * dataArr;
    NSMutableArray * array_jiazai;
    EGORefreshTableHeaderView *_refreshHeaderView;
    UIActivityIndicatorView *ajuhua;
	BOOL _reloading;
    BOOL isjiazai;
    UIView *view_header;//点击查询之前的
    UIView *aview_titleview;//点击了查询按钮之后的
    //  NSString *stringtext;
    int biaoji_shuaxin;//如果是1,就是刷新；如果是0，就是加载
    float mytableview_contentview;
    int count_biaoji;
}
@property(nonatomic,strong)UITableView * myTableView;
@property(nonatomic,strong)NSString *stringtext;
@property(nonatomic,strong)NSDictionary *dictionary_weibo;
@property(nonatomic,strong)NSMutableArray * searchArray;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;


@end
