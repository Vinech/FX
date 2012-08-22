//
//  NewsAnalysisViewController.m
//  iChart
//
//  Created by bin huang on 12-7-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//sssiis是h

#import "NewsAnalysisViewController.h"
#import "StoryViewController.h"
#import "NewsSearchViewController.h"
#import "DateHelper.h"

#import <QuartzCore/QuartzCore.h>
#define kWBSDKDemoAppKey @"2131365630"
#define kWBSDKDemoAppSecret @"9ccde1899c528308145342904dfb7b18"
@interface NewsAnalysisViewController (){
    NSString *string;
    NSString *style;
    UILabel * UserNameLabel;
    UIButton * searchDateButton;
    UILabel * label;
    UIButton *button_logo;
    UISearchBar * seacrhView ;
    UIBarButtonItem * cancelBar;
    UIBarButtonItem * bar;
    UIBarButtonItem * searchBar;
    UIBarButtonItem *buttonleft;
    UILabel *label_SourceandTime;
    
    NSArray * barArray;
    NSArray * barArray1;
    UILabel *labletext;//tableviewcell里面得;
    CGRect *rect_labletext;
    CGRect rect_tableview;
    CGFloat wigth_labeltext;
    CGFloat wigth_label_SourceandTime;
    

}
@property(nonatomic,strong)UIActivityIndicatorView * loadingIndicator;
@end

@implementation NewsAnalysisViewController
@synthesize loadingIndicator = _loadingIndicator,searchArray = _searchArray;
@synthesize myTableView,stringtext,dictionary_weibo;







- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@".......danteng");
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    string = [user objectForKey:@"style"];
    NSLog(@"viewvillappear..string ==================== %@",string);
    if ([style isEqualToString:string]==NO) {
        NSLog(@"执行了viewdiload");
        [self viewDidLoad];
    }if ([engine isLoggedIn]) {
        NSLog(@"hahhahhahhhhahahah");
    }else {
        NSLog(@"w cao");
        NSLog(@"===%@",engine.accessToken);
     // [engine logIn];
        
    }
    NSUserDefaults *user_hengshuping=[NSUserDefaults standardUserDefaults];
    NSString *string_hengshuping=[user_hengshuping objectForKey:@"hengshuping"];
    NSLog(@"string_hengshuping===%@",string_hengshuping);
    //[self viewDidLoad];
    if ([string_hengshuping isEqualToString:@"hengping"]) {
        self.myTableView.frame=CGRectMake(0, 0, 480, 320-44-49);
        rect_tableview=CGRectMake(0, 0, 480, 320-44-49);
        wigth_labeltext=475;
        wigth_label_SourceandTime=480;
   [self viewDidLoad];
    }else {
        self.myTableView.frame=CGRectMake(0,0,320,480-44-48);
        rect_tableview=CGRectMake(0, 0, 320, 480-44-48);
        wigth_labeltext=310;
        wigth_label_SourceandTime=320;
       [self viewDidLoad];

    }
    

    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@".......danteng");

    count_biaoji=0;
    mytableview_contentview=0;
    [dataArr removeAllObjects];
    if (string==nil) {
        string=@"dark";
        style=@"dark";
    }
    else 
    {
        style=[NSString stringWithFormat:string];   
    }
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.title=nil;
    
    
    UIView * seacV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 44)];
    seacV.backgroundColor = [UIColor clearColor];
    
    seacrhView = [[UISearchBar alloc] initWithFrame:seacV.bounds];
    seacrhView.delegate = self;
    seacrhView.keyboardType = UIKeyboardTypeDefault;
    [[seacrhView.subviews objectAtIndex:0]removeFromSuperview];
    seacrhView.placeholder = @"search...";
    
    [seacV addSubview:seacrhView];
    
    
    self.navigationItem.title = nil;
    bar = [[UIBarButtonItem alloc] initWithCustomView:seacV];
    
    cancelBar = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(searchContentText:)];
    UIBarButtonItem * sep = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleDone target:self action:nil];
    
    barArray1 = [NSArray arrayWithObjects:cancelBar,sep,nil];
    
    
    
    
    
    searchBar = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStyleDone target:self action:@selector(searchContentText:)];
    UIBarButtonItem * screeningBar = [[ UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStyleDone target:self action:@selector(screeningDate:)];
    barArray = [NSArray arrayWithObjects:searchBar,screeningBar,nil];
    self.navigationItem.rightBarButtonItems = barArray;
    
    UIButton* bulo=[[UIButton alloc]initWithFrame:CGRectMake(0, 2, 38, 30)];
    bulo.multipleTouchEnabled=NO;//不可触摸
    bulo.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"3730.png"]];
    //  button_logo.backgroundColor=[UIColor yellowColor];
    UIBarButtonItem* leftitem=[[UIBarButtonItem alloc]initWithCustomView:bulo];
    self.navigationItem.leftBarButtonItem=leftitem;
    


    UIView * aView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = aView;
    
    
    
    self.myTableView = [[UITableView alloc] initWithFrame:rect_tableview style:UITableViewStyleGrouped];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.backgroundColor = [UIColor clearColor];
    //    self.myTableView.rowHeight = 80;
    //    UIButton *button_jiazai=[[UIButton alloc]initWithFrame:CGRectMake(50, 460-44-49-50, 130, 40)];
    //    [self.view addSubview:button_jiazai];
    //    button_jiazai.backgroundColor=[UIColor blueColor];
    //    [button_jiazai addTarget:self action:@selector(jiazai) forControlEvents:UIControlEventTouchUpInside];
   		EGORefreshTableHeaderView *view2 = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - myTableView.bounds.size.height, self.view.frame.size.width, myTableView.bounds.size.height)];
     view2.backgroundColor=[UIColor whiteColor];
		view2.delegate = self;
		[myTableView addSubview:view2];
        
		_refreshHeaderView = view2;
	
	
	//  update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];
    
    //_refreshLowView=[[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, myTableView.bounds.size.height+0.0f, self.view.frame.size.width, myTableView.bounds.size.height)];
    //[myTableView addSubview:_refreshLowView];
    
    
    
    if ([style isEqualToString:@"dark"]) {
        aView.backgroundColor = [UIColor blackColor];
        
        
    }else {
        aView.backgroundColor = [UIColor whiteColor];
        
    }
    
    [aView addSubview:self.myTableView];
    engine=[[WBEngine alloc]initWithAppKey:kWBSDKDemoAppKey appSecret:kWBSDKDemoAppSecret];
    engine.delegate=self;
    NSLog(@"accesstoken===========%@",engine.accessToken);
    [self performSelector:@selector(loaddata)];
	// Do any additional setup after loading the view.
}

#pragma mark-请求新郎微波的数据
-(void)loaddata{
    biaoji_shuaxin=1;
    dataArr = [[NSMutableArray alloc] init];
    
    //statuses/user_timeline.json   请求我的微博数据
    //statuses/home_timeline.json   请求全部微博数据
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    NSString *uid=@"2667934680";
    NSString *screen_name=@"久誉贵金属";
    NSString *count=@"40";
    NSString *trim_user=@"1";
    [dic setValue:engine.accessToken forKey:@"access_token"];
    [dic setValue:screen_name forKey:@"screen_name"];
    [dic setValue:count forKey:@"count"];
    [dic setValue:uid forKey:@"uid"];
    [dic setValue:trim_user forKey:@"trim_user"];
    
    //    [engine loadRequestWithMethodName:@"statuses/home_timeline.json" 
    //                           httpMethod:@"GET" params:dic 
    //                         postDataType:kWBRequestPostDataTypeNone 
    //                     httpHeaderFields:nil];
    [engine loadRequestWithMethodName:@"statuses/user_timeline.json" 
                           httpMethod:@"GET" params:dic 
                         postDataType:kWBRequestPostDataTypeNone 
                     httpHeaderFields:nil];
}
#pragma mark-接收数据的方法 wbengine的代理方法
-(void)engine:(WBEngine *)engine requestDidSucceedWithResult:(id)result{
   // NSLog(@"==%@",result);
    //  NSLog(@"++%@,%@,requestDidSucceedWithResult = %@",self,self.view.subviews,result);
    
    if ([result isKindOfClass:[NSDictionary class]]) //模糊判断，MemberOfClass为精确判断
    {
        if (biaoji_shuaxin) {
            NSDictionary * dic = (NSDictionary *)result;
            [dataArr removeAllObjects];
            [dataArr addObjectsFromArray:[dic objectForKey:@"statuses"]];
            [_loadingIndicator stopAnimating];
            [self.myTableView reloadData];
            
        }
        else {
            NSDictionary * dic = (NSDictionary *)result;
            [array_jiazai addObjectsFromArray:[dic objectForKey:@"statuses"]];
            for (int i=1; i<[array_jiazai count]; i++) {
                [dataArr addObject:[array_jiazai objectAtIndex:i]];
                isjiazai=NO;
                [_loadingIndicator stopAnimating];
                [self.myTableView reloadData];
                
            }
        }
        
        
    }
    
    
}
-(void)engine:(WBEngine *)engine requestDidFailWithError:(NSError *)error{
    NSLog(@"==？？？？？？？？requestDidFailWithError = %@",error);
}


#pragma mark-searchbar


#pragma mark-tableviewdatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ([dataArr count]+1);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //mytableview_contentview=0;
    NSString * stringcell = [NSString stringWithFormat:@"%d",indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:stringcell];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }else 
    {
        for (UIView * view in cell.contentView.subviews) 
        {
            [view removeFromSuperview];
        }
    }
    
    
    if ([dataArr count]!=0) {
        if (indexPath.row==[dataArr count]) 
        {            
            //            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            _loadingIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(260,10,24,24)];
            _loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
            _loadingIndicator.hidden = YES;
            _loadingIndicator.backgroundColor = [UIColor clearColor];
            //            [_loadingIndicator startAnimating];
            _loadingIndicator.hidesWhenStopped = YES;
            
            
            UILabel *label_jiazai=[[UILabel alloc]initWithFrame:CGRectMake(100, 2, 120, 40)];
            label_jiazai.text=@"点击加载更多。。";
            label_jiazai.textColor=[UIColor redColor];
            label_jiazai.backgroundColor=[UIColor blackColor];
            
            [cell.contentView addSubview:label_jiazai];
            [cell.contentView addSubview:_loadingIndicator];
            
        }
        if (indexPath.row<[dataArr count]) {
            dictionary_weibo = [dataArr objectAtIndex:indexPath.row];//每条微博是一个字典
            stringtext= [NSString stringWithFormat:[dictionary_weibo objectForKey:@"text"]];
            labletext=[[UILabel alloc]init];
            labletext.text=stringtext;
       
            CGFloat contentWidth = wigth_labeltext;
              UIFont *font = [UIFont systemFontOfSize:17];
            CGSize size = [stringtext sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, 1000) lineBreakMode:UILineBreakModeWordWrap];
            CGRect rect = [labletext textRectForBounds:cell.textLabel.frame limitedToNumberOfLines:0];
            rect.size=size;
            labletext.frame=rect;
            labletext.numberOfLines=0;
            labletext.backgroundColor=[UIColor clearColor];
            [cell.contentView addSubview:labletext];
            //labletext.font=font;
            
            label_SourceandTime=[[UILabel alloc]initWithFrame:CGRectMake(0, size.height+2,wigth_label_SourceandTime ,30 )];
            NSString *string_time=[NSString stringWithFormat:[dictionary_weibo objectForKey:@"created_at"]];
            NSString *string_timeshang=[string_time substringToIndex:19];
            NSString *string_sourceandtime=[[NSString alloc]initWithFormat:@"来自久誉贵金属  %@",string_timeshang];
            label_SourceandTime.text=string_sourceandtime;
            label_SourceandTime.backgroundColor=[UIColor clearColor];
            label_SourceandTime.textAlignment=UITextAlignmentCenter;
            [cell.contentView addSubview:label_SourceandTime];
            
        }
        
    }
    
    cell.contentView.backgroundColor = [UIColor clearColor];
    if ([style isEqualToString:@"dark"]) {
        cell.backgroundColor = [UIColor blackColor];
        labletext.textColor = [UIColor whiteColor];
        label_SourceandTime.textColor=[UIColor brownColor];
        
    }else {
        cell.backgroundColor=[UIColor whiteColor];
        labletext.textColor = [UIColor blackColor];
        label_SourceandTime.textColor=[UIColor brownColor];

        
    }
    return cell;
}
#pragma mark-上啦加载更多数据
-(void)jiazai{
    NSLog(@"zhengzaijiazai");
    biaoji_shuaxin=0;
    [array_jiazai removeAllObjects];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    NSString *uid=@"2667934680";
    NSString *screen_name=@"久誉贵金属";
    NSString *count=@"20";
    
    NSDictionary *dict_id=[[NSDictionary alloc]init];
    dict_id= [dataArr objectAtIndex:[dataArr count]-1];//每条微博是一个字典
    stringtext= [NSString stringWithFormat:[dict_id objectForKey:@"idstr"]];
    NSString * max_id=stringtext;
    //NSLog(@"max_id==============%@",max_id);
    
    NSString *trim_user=@"1";
    [dic setValue:engine.accessToken forKey:@"access_token"];
    [dic setValue:screen_name forKey:@"screen_name"];
    [dic setValue:count forKey:@"count"];
    [dic setValue:uid forKey:@"uid"];
    [dic setValue:max_id forKey:@"max_id"];
    NSLog(@"max_id==============%@",max_id);
    [dic setValue:trim_user forKey:@"trim_user"];
    
    [engine loadRequestWithMethodName:@"statuses/user_timeline.json" 
                           httpMethod:@"GET" params:dic 
                         postDataType:kWBRequestPostDataTypeNone 
                     httpHeaderFields:nil];
    
    array_jiazai=[[NSMutableArray alloc]init];
    
    //    [ajuhua stopAnimating];
    
    NSLog(@"arraycount====%d",[dataArr count]);

}

#pragma mark--计算高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize labelSize;
    // NSString *stringtest=@"123";
    //创建一个新的CGSize来限制和计算text边框的大小
//    if ([dataArr count]!=0) {
//        if (indexPath.row<[dataArr count]) {
//            dictionary_weibo = [dataArr objectAtIndex:indexPath.row];//每条微博是一个字典
//            stringtext= [NSString stringWithFormat:[dictionary_weibo objectForKey:@"text"]];       // NSString *cellText = sts;
//            UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
//            CGSize constraintSize = CGSizeMake(240.0f, MAXFLOAT);
//            labelSize = [stringtext sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
//           // NSLog(@"stringtext==%@",stringtext);
//            if (labelSize.height<100) {
//                labelSize.height=labelSize.height+30;
//            }
//        }
//        if (indexPath.row==[dataArr count]) {
//            labelSize.height=40;
//        }
//    }
    if ([dataArr count]!=0) {
        if (indexPath.row<[dataArr count]) {
            CGFloat contentWidth = wigth_labeltext;
            // 用何種字體進行顯示
            UIFont *font = [UIFont systemFontOfSize:17];
            
            // 該行要顯示的內容
           // NSString *content = [data objectAtIndex:indexPath.row];
                      dictionary_weibo = [dataArr objectAtIndex:indexPath.row];//每条微博是一个字典
                       stringtext= [NSString stringWithFormat:[dictionary_weibo objectForKey:@"text"]];      
            // 計算出顯示完內容需要的最小尺寸
            labelSize = [stringtext sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, 1000) lineBreakMode:UILineBreakModeWordWrap];
            
            // 這裏返回需要的高度
//            if (labelSize.height>100) {
//                labelSize.height=labelSize.height+100;
//            }
        }else {
            labelSize.height=20;
            
        }
    }
    return labelSize.height + 30;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @" ";
}
//自己实现如果更新数据
- (void)reloadTableViewDataSource
{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
	
}
//更新数据结束以后需要进行的操作
- (void)doneLoadingTableViewData
{
	
	//  model should call this when its done loading
	_reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
    [self loaddata];
	
}//在scrollView拖动的时候，调用的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{	
    //HeaderView是自定义的一个View，它用自己的Controller的方法来控制
    //当滑动的时候HeaderView应该进行什么操作
    //这种处理问题的思想以后应该要借鉴
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}
//在scrollView结束拖动的时候，调用的代理方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	//HeaderView是自定义的一个View，它用自己的Controller的方法来控制
    //当滑动结束的时候HeaderView应该进行什么操作
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}
#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

//如果拖动超过预定距离并且 没有在loading状态时由EGO调用的代理方法
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
	
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:5.0];
	
}
//返回当前加载状态
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
	
	return _reloading; // should return if data source model is reloading
	
}
//功能是返回一个data，不过实际实现的是返回当前时间
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
	//Creates and returns a new date set to the current date and time.
    //这个方法创建一个data里面包含当前的时间
	return [NSDate date]; // should return date data source was last changed
	
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<[dataArr count]) {
        StoryViewController * story= [[StoryViewController alloc] init];
        dictionary_weibo = [dataArr objectAtIndex:indexPath.row];//每条微博是一个字典
        stringtext= [NSString stringWithFormat:[dictionary_weibo objectForKey:@"text"]]; 
        if ([dictionary_weibo objectForKey:@"bmiddle_pic"]) {
            NSString *string_url=[NSString stringWithFormat:[dictionary_weibo objectForKey:@"bmiddle_pic"]];
            NSLog(@"string_url===%@",string_url);
            dictionary_weibo = [dataArr objectAtIndex:indexPath.row];//每条微博是一个字典
            if (string_url!=nil) {
                story.string_picture=string_url;
            }
        }
        story.string_text=self.stringtext;
        story.string_idstr=[NSString stringWithFormat:[dictionary_weibo objectForKey:@"idstr"]];
        story.dicwb= dictionary_weibo;
        
  //****************这一部分为计算高度得**********************************************************************************************************      
        CGSize labelSize;
        // NSString *stringtest=@"123";
        //创建一个新的CGSize来限制和计算text边框的大小
        if ([dataArr count]!=0) {
            if (indexPath.row<[dataArr count]) {
                dictionary_weibo = [dataArr objectAtIndex:indexPath.row];//每条微博是一个字典
                stringtext= [NSString stringWithFormat:[dictionary_weibo objectForKey:@"text"]];       // NSString *cellText = sts;
                UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
                CGSize constraintSize = CGSizeMake(240.0f, MAXFLOAT);
                labelSize = [stringtext sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
               // NSLog(@"stringtext==%@",stringtext);
            }
        }

   //******************************以上部分为计算高度********************************************************************************************     
    
        story.gaodu_text=labelSize.height;
        //NSLog(@"story.gaodu_text========%f",story.gaodu_text);
        [self.navigationController pushViewController:story animated:YES];
    }
    if (indexPath.row==[dataArr count]) 
    {
        _loadingIndicator.hidden = NO;
        [_loadingIndicator startAnimating];
        [self performSelector:@selector(jiazai)];
    }  
}

#pragma mark-search

-(void)searchContentText:(UIBarButtonItem *)sender
{
    static BOOL isSearch;
    isSearch = !isSearch;
    
    if (isSearch) 
    {
        self.navigationItem.title = nil;
        self.navigationItem.rightBarButtonItems = barArray1;
        self.navigationItem.leftBarButtonItem = bar;
    }else 
    {
        self.navigationItem.leftBarButtonItem=buttonleft;
        self.navigationItem.rightBarButtonItems = barArray;
    }   
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"yeah");
    return YES;
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar1
{
    _searchArray = [[NSMutableArray alloc] init];
    for (NSMutableDictionary * dic in dataArr) 
    {
        NSString * stringText = [dic objectForKey:@"text"];
    //NSLog(@"stringTextstringText == %@",stringText);
        NSRange range = [stringText rangeOfString:searchBar1.text];
        if (range.length) 
        {
            [self.searchArray addObject:dic];    
        } 
    }
    NewsSearchViewController * search = [[NewsSearchViewController alloc] init];
    search.dataArray = self.searchArray;
    search.titleStr = @"Search Results";
    
    [self.navigationController pushViewController:search animated:YES];
}

#pragma mark-actionsheet


-(void)screeningDate:(UIBarButtonItem *)sender
{
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"按时间查找" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"一天前",@"一周前",@"一月前",nil];
    
    [actionSheet showInView:self.view.window];
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSMutableArray * dayArray = [[NSMutableArray alloc] init];
    NSMutableArray * weekArray = [[NSMutableArray alloc] init];
    NSMutableArray * monthArray = [[NSMutableArray alloc] init];
    NSMutableArray * nowArray = [[NSMutableArray alloc] init];
    
    
    for (int i = 0;i < [dataArr count];i++) 
    {
        //        NSDictionary *dic = [[NSDictionary alloc] init];
        //        dic = [dataArr objectAtIndex:i];
        
        
        dictionary_weibo = [dataArr objectAtIndex:i];//每条微博是一个字典
        stringtext= [NSString stringWithFormat:[dictionary_weibo objectForKey:@"text"]];
        
        NSString * stringstring = [dictionary_weibo objectForKey:@"created_at"];
        
        NSDate * theDate = [DateHelper weiboStringToDate:stringstring];
        NSString * str1 = [DateHelper convertToReadableDate:theDate];
        if ([str1 isEqualToString:@"1天前"]) 
        {
            [dayArray addObject:dictionary_weibo];
        }else if ([str1 isEqualToString:@"1周前"]) 
        {
            [weekArray addObject:dictionary_weibo];
        }else if ([str1 isEqualToString:@"1个月前"]) 
        {
            [monthArray addObject:dictionary_weibo];
        }
    }
    
    NewsSearchViewController * new = [[NewsSearchViewController alloc] init];
    
    if (buttonIndex == 0) 
    {
        new.dataArray = dayArray;
        new.titleStr = @"1天前";
        [self.navigationController pushViewController:new animated:YES];
        
        
    }else if (buttonIndex == 1) 
    {
        new.dataArray = weekArray;
        new.titleStr = @"1周前";
        [self.navigationController pushViewController:new animated:YES];
        
    }else if (buttonIndex == 2) 
    {
        new.dataArray = monthArray;
        new.titleStr = @"1个月前";
        [self.navigationController pushViewController:new animated:YES];
        
    }else if (buttonIndex == 3) 
    {
        new.dataArray = nowArray;
        new.titleStr = @"刚刚";
        [self.navigationController pushViewController:new animated:YES];
    }
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft||interfaceOrientation==UIInterfaceOrientationLandscapeRight) { 
        self.myTableView.frame=CGRectMake(5, 0, 480, 320-44-49);
        rect_tableview=CGRectMake(5, 0, 480, 320-44-49);
        wigth_labeltext=470;
        wigth_label_SourceandTime=480;

       [self viewDidLoad];
        //zuo 
    } 
     if (interfaceOrientation==UIInterfaceOrientationPortrait||interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) { 
        self.myTableView.frame=CGRectMake(5,0,320,480-44-48);
         rect_tableview=CGRectMake(5, 0, 320, 480-44-48);
         wigth_labeltext=300;
         wigth_label_SourceandTime=320;
   [self viewDidLoad];

        //shang 
    } 
    NSLog(@"怎么会这样的");
    return YES;
}

@end
