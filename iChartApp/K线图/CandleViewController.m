//  https://github.com/zhiyu/chartee/
//
//  Created by zhiyu on 7/11/11.
//  Copyright 2011 zhiyu. All rights reserved.
//

#import "CandleViewController.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "ResourceHelper.h"
#import "OptionViewController.h"
#import "Personaldetail.h"

@implementation CandleViewController

@synthesize candleChart;
@synthesize autoCompleteView;
@synthesize toolBar;
@synthesize candleChartFreqView;
@synthesize autoCompleteDelegate;
@synthesize timer;
@synthesize chartMode;
@synthesize tradeStatus;
@synthesize lastTime;
@synthesize status;
@synthesize req_freq;
@synthesize req_type;
@synthesize req_url;
@synthesize req_security_id;
@synthesize arrTitle;
@synthesize arrayEdit;
@synthesize stringhost;
@synthesize stringport;
@synthesize arrValue;
@synthesize hcandleChart;
@synthesize activity;

@synthesize Minute;//时间
@synthesize codeName;//产品名称
@synthesize userName;//密码
@synthesize passWord;//账号
@synthesize periodEma,periodAdx,periodCci,periodKdj,periodMom,periodRsi,periodSma,periodWma,periodBoll,periodMacd,LongperiodEma,ShortperiodEma,SignaperiodEma,longMacdPeriod,shortMacdPeriod,storyboard,bandDeviation,kPeriod,dPeriod,jPeriod;//技术指标周期

@synthesize allProiod;
@synthesize SELF_ACTIVITY_FRAME_X,SELF_ACTIVITY_FRAME_Y,SELF_ACTIVITY_FRAME_WIDTH,SELF_ACTIVITY_FRAME_HEIGHT,SELF_VIEW_FRAME_X,SELF_VIEW_FRAME_Y,SELF_VIEW_FRAME_WIDTH,SELF_VIEW_FRAME_HEIGHT,SELF_CANDLECHART_FRAME_X,SELF_CANDLECHART_FRAME_Y,SELF_CANDLECHART_FRAME_WIDTH,SELF_CANDLECHART_FRAME_HEIGHT ,BACKBUTTON_FRAME_Y,BACKBUTTON_FRAME_WIDTH,BACKBUTTON_FRAME_HEIGHT,BACKBUTTON_FRAME_X,VIEWHUB_FRAME_X,VIEWHUB_FRAME_Y,VIEWBACK_FRAME_X,VIEWBACK_FRAME_Y,VIEWHUB_FRAME_WIDTH,VIEWBACK_FRAME_WIDTH,VIEWHUB_FRAME_HEIGHT,VIEWBACK_FRAME_HEIGHT,LABELDATA_FRAME_X,LABELDATA_FRAME_Y,LABELDATA_FRAME_WIDTH,LABELDATA_FRAME_HEIGHT;
@synthesize viewBack ,viewHUB  ,imageBack ,backButton,biaoji,array_pro,string_color;
//nima lebi  de schou shabi 

- (void)backButtons
{
    [socket1 setDelegate:nil];
    [socket1 disconnect];
    
    [self.viewHUB setHidden:YES];
    [self.viewBack setHidden:YES];
    [self.activity stopAnimating];
    [self.imageBack setHidden:YES];
    [self.backButton setHidden:YES];
    
    self.viewHUB = nil;
    self.viewBack = nil;
    self.imageBack = nil;
    self.backButton = nil;
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)popToRoot:(NSMutableArray *)theArray
{
    self.allProiod = theArray;
    NSLog(@"lululululululuul = %@",self.allProiod);
    [self getData];
}



-(void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *user_style=[NSUserDefaults standardUserDefaults];
    //    string_yanse = [[NSString alloc] init];
    //    string_color = [[NSString alloc] init];
    string_yanse=[user_style objectForKey:@"style"];
    //    NSMutableArray * array2 = [[NSMutableArray alloc] init];
    //    array2 = [user_style objectForKey:@"Data"];
    //    if (array2.count !=0) 
    //    {
    //        [self.allProiod removeAllObjects];
    //        self.allProiod = array2;
    //        NSLog(@"aaaaaaaalulululuull === %@",self.allProiod);
    //        [self getData];
    //    }else 
    //    {
    //        [self getData];
    //    }
    
    //    self.allProiod = [user_style objectForKey:@"Data"];
    //    if (self.allProiod.count != 0) 
    //    { 
    //        [self getData];
    //    }else {
    //        [self getData];
    //    }
    //    NSLog(@"color ====   %@",string_color);
    
    if (![string_yanse isEqualToString:string_color]) 
    {
        //        NSLog(@"-------000990000000000000-=======");
        // [self viewDidLoad];
    }
}
- (void)initPeriod
{
    NSUserDefaults * user1 = [NSUserDefaults standardUserDefaults];
    self.allProiod = [user1 objectForKey:@"Data"];
    if (self.allProiod==nil) 
    {
        
        
        
        self.periodAdx =9;
        self.periodBoll=20;
        
        self.periodCci =14;
        self.periodEma =10;
        
        self.periodMacd=9;
        
        self.periodMom =10;
        self.periodRsi =10;
        
        self.periodSma =7;
        self.periodWma =10;
        
        self.shortMacdPeriod = 12;
        self.longMacdPeriod  = 26;
        
        self.bandDeviation = 2.0;
        
        self.kPeriod = 60;
        self.dPeriod = 60;
        self.jPeriod = 60;
        
        self.allProiod = [[NSMutableArray alloc] initWithObjects:[NSString stringWithFormat:@"%d",self.periodSma],
                          [NSString stringWithFormat:@"%d",self.periodWma],
                          [NSString stringWithFormat:@"%d",self.periodEma],
                          [NSString stringWithFormat:@"%d",self.periodBoll],
                          [NSString stringWithFormat:@"%.f",self.bandDeviation],
                          [NSString stringWithFormat:@"%d",self.periodRsi],
                          [NSString stringWithFormat:@"%d",self.periodMacd],
                          [NSString stringWithFormat:@"%d",self.longMacdPeriod],
                          [NSString stringWithFormat:@"%d",self.shortMacdPeriod],
                          [NSString stringWithFormat:@"%d",self.kPeriod],
                          [NSString stringWithFormat:@"%d",self.dPeriod],
                          [NSString stringWithFormat:@"%d",self.jPeriod],
                          [NSString stringWithFormat:@"%d",self.periodCci],
                          [NSString stringWithFormat:@"%d",self.periodMom],
                          [NSString stringWithFormat:@"%d",self.periodAdx], nil];
    }
    //    NSLog(@"newnewnewnew%@",self.allProiod);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allProiod = [[NSMutableArray alloc] init];
    //    NSLog(@"zoulehaojicimamamamamammama");
    //判断是高亮状态还是黑暗状态
    if (string_yanse==nil) {
        string_yanse=@"dark";
        string_color=@"dark";
    }else {
        string_color=[NSString stringWithFormat:string_yanse];
    }
    [self initPeriod];
    
    
    backgroundViews = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];
    
    backgroundViews.backgroundColor = [UIColor colorWithRed:20/255.0f green:20/255.0f blue:20/255.0f alpha:1.0f];
    if (upView == YES) {
        [backgroundViews setHidden:YES];
        
    }else {
        [backgroundViews setHidden:NO];
        
    }
    [self.view addSubview:backgroundViews];
    
    
    
    
    
    //    NSLog(@"kPeriod = %d",self.kPeriod);
    //    NSLog(@"123");
    
    UISegmentedControl * segmentC = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"<",@">", nil]];
    segmentC.frame = CGRectMake(260, 10,70,30);               
    segmentC.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentC.momentary = NO;    //设置在点击后是否恢复原样 
    segmentC.multipleTouchEnabled=NO;  //可触摸
    segmentC.tintColor = [UIColor grayColor];
    [segmentC addTarget:self action:@selector(mySegment:) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *segButton = [[UIBarButtonItem alloc] initWithCustomView:segmentC];
    self.navigationItem.rightBarButtonItem =segButton;
    
    
    if (label.text!=nil) {
        [label removeFromSuperview];
    }
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 130, 40)];
    label.text = [array_pro objectAtIndex:self.biaoji];
    label.textAlignment = UITextAlignmentLeft;
    label.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:20];
    label.backgroundColor = [UIColor clearColor];
    [backgroundViews addSubview:label];
    
    self.navigationItem.title=label.text;

    
    Personaldetail *userproduct=[[Personaldetail alloc]init];
    userproduct = [Personaldetail findpersonaldetailwithproductname:label.text];
    
    //数据更新的时间
    if (label1.text!=nil) {
        [label1 removeFromSuperview];
    }
    
    label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 60+20,300, 30)];
    int time=[userproduct.time intValue];
    NSDate *nd = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYY-MM-dd HH:mm"];//时间格式，YYYY-MM-dd HH:mm:ss:SSSS
    NSString *dateString = [dateFormat stringFromDate:nd];  
    label1.text =[NSString stringWithFormat:@"最后更新时间: %@",dateString];
    label1.textAlignment = UITextAlignmentLeft;
    label1.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:12];
    [backgroundViews addSubview:label1];
    
    //开盘
    if (label2.text!=nil) {
        [label2 removeFromSuperview];
    }
    label2 = [[UILabel   alloc] initWithFrame:CGRectMake(120, 20,190, 40)];
    NSString * strings = [NSString stringWithFormat:@"%.5f",[userproduct.open floatValue]];
    
    
    NSString * str = @".";
    NSRange  range = [strings rangeOfString:str];
    NSString *str1 = [strings substringFromIndex:range.location+1];
    NSString *str2 = [[str1 substringFromIndex:2] substringToIndex:2];
    NSString *str3 = [strings stringByReplacingOccurrencesOfString:str2 withString:@"          "];
    label2.text = str3;     
    label2.textAlignment = UITextAlignmentRight;
    label2.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:15];
    
    UILabel * label9 = [[UILabel alloc] initWithFrame:CGRectMake(128, 0, 52, 40)];
    label9.backgroundColor = [UIColor clearColor];
    label9.text = str2;
    label9.textColor = [UIColor whiteColor];
    label9.textAlignment = UITextAlignmentCenter;
    label9.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:45];
    [label2 addSubview:label9];
    [backgroundViews addSubview:label2];
    //最低，最高
    if (label3.text!=nil) {
        [label3 removeFromSuperview];
    }
    
    label3 = [[UILabel   alloc] initWithFrame:CGRectMake(10, 60,300, 30)];
    label3.text = [NSString stringWithFormat:@"High:%.5f             Low:%.5f",[userproduct.high floatValue] ,[userproduct.low floatValue]];
    label3.textAlignment = UITextAlignmentLeft;
    label3.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:12];
    label3.backgroundColor = [UIColor clearColor];
    [backgroundViews addSubview:label3];
    
    label. backgroundColor=[UIColor clearColor];
    label1.backgroundColor=[UIColor clearColor];
    label2.backgroundColor=[UIColor clearColor];
    label3.backgroundColor=[UIColor clearColor];
    
    
    
    if ([string_color isEqualToString:@"dark"]) {
        self.view.backgroundColor=[UIColor blackColor];
        label.textColor=[UIColor whiteColor];
        label1.textColor=[UIColor whiteColor];
        label2.textColor=[UIColor whiteColor];
        label3.textColor=[UIColor whiteColor];
        
    }else {
        self.view.backgroundColor=[UIColor whiteColor];
        backgroundViews.backgroundColor = [UIColor whiteColor];
        label.textColor=[UIColor blackColor];
        label1.textColor=[UIColor blackColor];
        label2.textColor=[UIColor blackColor];
        label3.textColor=[UIColor blackColor];
    }
    
	
    
	//init vars
	self.chartMode  = 1; //1,图表模式
	self.tradeStatus= 1; //贸易地位？
    
    
    
    //**************到时候传值过来，就不用赋值了********************************************
	NSUserDefaults *user_chuanzhi=[NSUserDefaults standardUserDefaults];
    NSString *string_codename=[array_pro objectAtIndex:self.biaoji];
    self.userName = [user_chuanzhi objectForKey:@"remberusername"];//用户名
    self.passWord = [user_chuanzhi objectForKey:@"remberpassword"]; //密码
    
    if ([string_codename isEqualToString:@"现货白银"]) 
    {
        string_codename=@"XAGUS+D";
        
    }else if ([string_codename isEqualToString:@"白银T+D"]) {
        string_codename=@"AGT+D";
    }else if([string_codename isEqualToString:@"黄金T+D"]) {
        string_codename=@"AUT+D";
    }else if ([string_codename isEqualToString:@"美元指数"]) {
        string_codename = @"USD";
    }
    
    self.codeName = [NSString stringWithFormat:string_codename];  //产品名称
    //    NSLog(@"name=%@ *  password=%@  * codename=%@   ",[user_chuanzhi objectForKey:@"remberusername"],[user_chuanzhi objectForKey:@"remberpassword"],[array_pro objectAtIndex:self.biaoji]);
    //    self.codeName = @"USD";
    //    self.userName = @"test8899";
    //    self.passWord = @"123";
    self.Minute   = 30;    //时间周期
    
    //***********************************************************************************
    
    //selfview 大小
	[self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    
	//搜索bar
	UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(self.view.frame.size.width-250, 0, 250, 40)];
	[searchBar setBackgroundColor:[[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0]];
	searchBar.delegate = self;
	
    
	
    self.candleChart = [[Chart alloc] init];
    self.candleChart.delegate = self;
    
    self.hcandleChart = [[HChart alloc] init];
    self.hcandleChart.delegate = self;	
    
    
    
    [self initChart];//初始化数据
    [self getData];  //调用socket
    //  [self JUHUA];    //初始化菊花
    
}
#pragma mark-调节上下产品
- (void)mySegment:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
        case 0:
        {
            if (self.biaoji==0) {
                NSLog(@"当前是第一个");
            }
            else {
                NSLog(@"之前%d",self.biaoji);
                self.biaoji=self.biaoji-1;
                NSLog(@"之后%d",self.biaoji);
                
                [self viewDidLoad];
                
            }
        }
            
            
            break;
        case 1:
        {
            if ([array_pro count]==1) {
                NSLog(@"只有一个");
            }
            else {
                if (self.biaoji+1==[array_pro count]) {
                    NSLog(@"当前已经是最后一个");
                }
                else {
                    NSLog(@"之前%d",self.biaoji);
                    self.biaoji=self.biaoji+1;
                    NSLog(@"之后%d",self.biaoji);
                    [self viewDidLoad];
                    
                    
                    
                }
                
                
            }
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - 菊花上的返回
-(void)back
{
    //定制读取数据
    [socket1 setDelegate:nil];
    [socket1 disconnect];
    
    
    //隐藏小菊花那些东西
    [self.viewHUB setHidden:YES];
    [self.viewBack setHidden:YES];
    [self.activity stopAnimating];
    [self.imageBack setHidden:YES];
    [self.backButton setHidden:YES];
    
    //清空指针
    self.viewHUB = nil;
    self.viewBack = nil;
    self.imageBack = nil;
    self.backButton = nil;
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - Hchart Delegate
- (void)HtimerTitle:(int)title
{
    NSLog(@"横屏 delegate");
    [self.viewHUB setHidden:YES];
    [self.viewBack setHidden:YES];
    [self.activity stopAnimating];
    [self.imageBack setHidden:YES];
    [self.backButton setHidden:YES];
    
    self.viewHUB = nil;
    self.viewBack = nil;
    self.imageBack = nil;
    self.backButton = nil;
    
    
    self.Minute = title;
    [self getData];
    [self JUHUA];
}

#pragma mark - chart Delegate
- (void)timerTitle:(int)title
{
    //    NSLog(@"title = %d",title);
    
    self.Minute = title;
    //    NSLog(@"竖屏 delegate");
    //    [self.viewHUB setHidden:YES];
    //    [self.viewBack setHidden:YES];
    //    [self.activity stopAnimating];
    //    [self.imageBack setHidden:YES];
    //    [self.backButton setHidden:YES];
    //    
    //    
    //    self.viewHUB = nil;
    //    self.viewBack = nil;
    //    self.imageBack = nil;
    //    self.backButton = nil;
    
    [self getData];
    //[self JUHUA];
}
- (void)ChooseIndexes
{
    OptionViewController * option = [[OptionViewController alloc] init];
    //    if (self.allProiod) 
    //    {
    //        
    //    }else {
    //        
    //    
    //    self.allProiod = [[NSMutableArray alloc] initWithObjects:[NSString stringWithFormat:@"%d",self.periodSma],
    //                                                             [NSString stringWithFormat:@"%d",self.periodWma],
    //                      [NSString stringWithFormat:@"%d",self.periodEma],
    //                      [NSString stringWithFormat:@"%d",self.periodBoll],
    //                      [NSString stringWithFormat:@"%.f",self.bandDeviation],
    //                      [NSString stringWithFormat:@"%d",self.periodRsi],
    //                      [NSString stringWithFormat:@"%d",self.periodMacd],
    //                      [NSString stringWithFormat:@"%d",self.longMacdPeriod],
    //                      [NSString stringWithFormat:@"%d",self.shortMacdPeriod],
    //                      [NSString stringWithFormat:@"%d",self.kPeriod],
    //                      [NSString stringWithFormat:@"%d",self.dPeriod],
    //                      [NSString stringWithFormat:@"%d",self.jPeriod],
    //                      [NSString stringWithFormat:@"%d",self.periodCci],
    //                      [NSString stringWithFormat:@"%d",self.periodMom],
    //                      [NSString stringWithFormat:@"%d",self.periodAdx], nil];
    //    }
    option.dataArray = self.allProiod;
    [option setDelegate:self];
    //    option.periodMom = self.periodMom;
    //    option.periodAdx = self.periodAdx;
    //    
    //    option.periodBoll= self.periodBoll;
    //    option.periodCci = self.periodCci;
    //    
    //    option.periodEma = self.periodEma;
    //    option.periodKdj = self.periodKdj;
    //    
    //    option.periodMacd= self.periodMacd;
    //    option.periodRsi = self.periodRsi;
    //    
    //    option.periodSma = self.periodSma;
    //    option.periodWma = self.periodWma;
    //    
    //    option.longMacdPeriod = self.longMacdPeriod;
    //    option.shortMacdPeriod= self.shortMacdPeriod;
    //    
    //    option.bandDeviation = self.bandDeviation;
    //    option.kPeriod = self.kPeriod;
    //    
    //    option.dPeriod = self.dPeriod;
    //    option.jPeriod = self.jPeriod;
    
    
    
    [self.navigationController pushViewController:option animated:YES];
}

#pragma mark - 菊花那些东西初始化
- (void)JUHUA
{
    
    
    self.viewHUB = [[UIView alloc] initWithFrame:CGRectMake(self.VIEWHUB_FRAME_X, self.VIEWHUB_FRAME_Y, self.VIEWHUB_FRAME_WIDTH, self.VIEWHUB_FRAME_HEIGHT)];
    self.viewHUB.backgroundColor = [UIColor blackColor];
    self.viewHUB.alpha = 0.8;
    [self.navigationController.view addSubview:self.viewHUB];
    
    NSLog(@"with = %d, height = %d",self.VIEWHUB_FRAME_WIDTH,self.VIEWHUB_FRAME_HEIGHT);
    
    
    self.viewBack = [[UIView alloc] initWithFrame:CGRectMake(self.VIEWBACK_FRAME_X, self.VIEWBACK_FRAME_Y, self.VIEWBACK_FRAME_WIDTH, self.VIEWBACK_FRAME_HEIGHT)];
    self.viewBack.backgroundColor = [UIColor redColor];
    self.viewBack.layer.cornerRadius = 8;
    self.viewBack.alpha = 1;
    [self.viewHUB addSubview:self.viewBack];
    
    
    
    //    self.labelData = [[UILabel alloc] initWithFrame:CGRectMake(self.LABELDATA_FRAME_X, self.LABELDATA_FRAME_Y  , self.LABELDATA_FRAME_WIDTH, self.LABELDATA_FRAME_HEIGHT)];
    //    self.labelData.backgroundColor = [UIColor clearColor];
    //    self.labelData.textColor = [UIColor whiteColor];
    //    self.labelData.textAlignment = UITextAlignmentCenter;
    //    self.labelData.font = [UIFont systemFontOfdata.count:15];
    //    self.labelData.text = @"正在加载...";
    //    [self.viewBack addSubview:self.labelData];
    
    //无敌风火轮
    self.activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.SELF_ACTIVITY_FRAME_X, self.SELF_ACTIVITY_FRAME_Y, self.SELF_ACTIVITY_FRAME_WIDTH, self.SELF_ACTIVITY_FRAME_HEIGHT)];  
    [self.viewBack addSubview:activity];
    [self.activity startAnimating];
    
    
    
    self.imageBack = [[UIImageView alloc] initWithFrame:CGRectMake(self.LABELDATA_FRAME_X, self.LABELDATA_FRAME_Y  , self.LABELDATA_FRAME_WIDTH, self.LABELDATA_FRAME_HEIGHT)];
    self.imageBack.userInteractionEnabled =YES;
    self.imageBack.image = [UIImage imageNamed:@"closebtn.png"];
    [self.viewBack addSubview:self.imageBack];
    
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.backgroundColor = [UIColor clearColor];
    self.backButton.frame = CGRectMake(self.BACKBUTTON_FRAME_X, self.BACKBUTTON_FRAME_Y, self.BACKBUTTON_FRAME_WIDTH, self.BACKBUTTON_FRAME_HEIGHT);
    [self.backButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.viewBack addSubview:self.backButton];
}

-(void)initChart{
	NSMutableArray *padding = [NSMutableArray arrayWithObjects:@"20",@"20",@"20",@"20",nil];
	[self.candleChart setPadding:padding];
    [self.hcandleChart setPadding:padding];
    
	NSMutableArray *secs = [[NSMutableArray alloc] init];
	[secs addObject:@"4"];
	[secs addObject:@"0"];
	[secs addObject:@"4"];
	[self.candleChart addSections:3 withRatios:secs];
	[self.candleChart getSection:2].hidden = YES;
	[[[self.candleChart sections] objectAtIndex:0] addYAxis:0];
	[[[self.candleChart sections] objectAtIndex:1] addYAxis:0];
	[[[self.candleChart sections] objectAtIndex:2] addYAxis:0];
    
    [self.hcandleChart addSections:3 withRatios:secs];
	[self.hcandleChart getSection:2].hidden = YES;
    
    [[[self.hcandleChart sections] objectAtIndex:0] addYAxis:0];
	[[[self.hcandleChart sections] objectAtIndex:1] addYAxis:0];
	[[[self.hcandleChart sections] objectAtIndex:2] addYAxis:0];
    
	
	[self.candleChart getYAxis:2 withIndex:0].baseValueSticky = NO;
	[self.candleChart getYAxis:2 withIndex:0].symmetrical = NO;
	[self.candleChart getYAxis:0 withIndex:0].ext = 0.05;
    
    [self.hcandleChart getYAxis:2 withIndex:0].baseValueSticky = NO;
	[self.hcandleChart getYAxis:2 withIndex:0].symmetrical = NO;
	[self.hcandleChart getYAxis:0 withIndex:0].ext = 0.05;
    
	NSMutableArray *series = [[NSMutableArray alloc] init];
	NSMutableArray *secOne = [[NSMutableArray alloc] init];
	NSMutableArray *secTwo = [[NSMutableArray alloc] init];
	NSMutableArray *secThree = [[NSMutableArray alloc] init];
	
	//price
	NSMutableDictionary *serie = [[NSMutableDictionary alloc] init]; 
	NSMutableArray *data = [[NSMutableArray alloc] init];
	[serie setObject:@"price" forKey:@"name"];
	[serie setObject:@"Price" forKey:@"label"];
	[serie setObject:data forKey:@"data"];
	[serie setObject:@"candle" forKey:@"type"];
	[serie setObject:@"0" forKey:@"yAxis"];
	[serie setObject:@"0" forKey:@"section"];
	[serie setObject:@"249,222,170" forKey:@"color"];
	[serie setObject:@"249,222,170" forKey:@"negativeColor"];
	[serie setObject:@"249,222,170" forKey:@"selectedColor"];
	[serie setObject:@"249,222,170" forKey:@"negativeSelectedColor"];
	[serie setObject:@"176,52,52" forKey:@"labelColor"];
	[serie setObject:@"77,143,42" forKey:@"labelNegativeColor"];
	[series addObject:serie];
	[secOne addObject:serie];
	
	//MA10
	serie = [[NSMutableDictionary alloc] init]; 
	data = [[NSMutableArray alloc] init];
	[serie setObject:@"ema" forKey:@"name"];
	[serie setObject:@"ema" forKey:@"label"];
	[serie setObject:data forKey:@"data"];
	[serie setObject:@"line" forKey:@"type"];
	[serie setObject:@"0" forKey:@"yAxis"];
	[serie setObject:@"0" forKey:@"section"];
	[serie setObject:@"255,255,255" forKey:@"color"];
	[serie setObject:@"255,255,255" forKey:@"negativeColor"];
	[serie setObject:@"255,255,255" forKey:@"selectedColor"];
	[serie setObject:@"255,255,255" forKey:@"negativeSelectedColor"];
	[series addObject:serie];
	[secOne addObject:serie];
    
	//MA30
	serie = [[NSMutableDictionary alloc] init]; 
	data = [[NSMutableArray alloc] init];
	[serie setObject:@"sma" forKey:@"name"];
	[serie setObject:@"sma" forKey:@"label"];
	[serie setObject:data forKey:@"data"];
	[serie setObject:@"line" forKey:@"type"];
	[serie setObject:@"0" forKey:@"yAxis"];
	[serie setObject:@"0" forKey:@"section"];
	[serie setObject:@"250,232,115" forKey:@"color"];
	[serie setObject:@"250,232,115" forKey:@"negativeColor"];
	[serie setObject:@"250,232,115" forKey:@"selectedColor"];
	[serie setObject:@"250,232,115" forKey:@"negativeSelectedColor"];
	[series addObject:serie];
	[secOne addObject:serie];
	
	//MA60
	serie = [[NSMutableDictionary alloc] init]; 
	data = [[NSMutableArray alloc] init];
	[serie setObject:@"wma" forKey:@"name"];
	[serie setObject:@"wma" forKey:@"label"];
	[serie setObject:data forKey:@"data"];
	[serie setObject:@"line" forKey:@"type"];
	[serie setObject:@"0" forKey:@"yAxis"];
	[serie setObject:@"0" forKey:@"section"];
	[serie setObject:@"232,115,250" forKey:@"color"];
	[serie setObject:@"232,115,250" forKey:@"negativeColor"];
	[serie setObject:@"232,115,250" forKey:@"selectedColor"];
	[serie setObject:@"232,115,250" forKey:@"negativeSelectedColor"];
	[series addObject:serie];
	[secOne addObject:serie];
    
    //    //**************************************************************************************************************
    //    //MA60
    //	serie = [[NSMutableDictionary alloc] init]; 
    //	data = [[NSMutableArray alloc] init];
    //	[serie setObject:@"boll_upper" forKey:@"name"];
    //	[serie setObject:@"boll_upper" forKey:@"label"];
    //	[serie setObject:data forKey:@"data"];
    //	[serie setObject:@"line" forKey:@"type"];
    //	[serie setObject:@"0" forKey:@"yAxis"];
    //	[serie setObject:@"0" forKey:@"section"];
    //	[serie setObject:@"250,232,115" forKey:@"color"];
    //	[serie setObject:@"250,232,115" forKey:@"negativeColor"];
    //	[serie setObject:@"250,232,115" forKey:@"selectedColor"];
    //	[serie setObject:@"250,232,115" forKey:@"negativeSelectedColor"];
    //	[series addObject:serie];
    //	[secOne addObject:serie];
    //    
    //    //MA60
    //	serie = [[NSMutableDictionary alloc] init]; 
    //	data = [[NSMutableArray alloc] init];
    //	[serie setObject:@"boll_value" forKey:@"name"];
    //	[serie setObject:@"boll_value" forKey:@"label"];
    //	[serie setObject:data forKey:@"data"];
    //	[serie setObject:@"line" forKey:@"type"];
    //	[serie setObject:@"0" forKey:@"yAxis"];
    //	[serie setObject:@"0" forKey:@"section"];
    //	[serie setObject:@"255,255,255" forKey:@"color"];
    //	[serie setObject:@"255,255,255" forKey:@"negativeColor"];
    //	[serie setObject:@"255,255,255" forKey:@"selectedColor"];
    //	[serie setObject:@"255,255,255" forKey:@"negativeSelectedColor"];
    //	[series addObject:serie];
    //	[secOne addObject:serie];
    //    
    //    //MA60
    //	serie = [[NSMutableDictionary alloc] init]; 
    //	data = [[NSMutableArray alloc] init];
    //	[serie setObject:@"boll_lower" forKey:@"name"];
    //	[serie setObject:@"boll_lower" forKey:@"label"];
    //	[serie setObject:data forKey:@"data"];
    //	[serie setObject:@"line" forKey:@"type"];
    //	[serie setObject:@"0" forKey:@"yAxis"];
    //	[serie setObject:@"0" forKey:@"section"];
    //	[serie setObject:@"232,115,250" forKey:@"color"];
    //	[serie setObject:@"232,115,250" forKey:@"negativeColor"];
    //	[serie setObject:@"232,115,250" forKey:@"selectedColor"];
    //	[serie setObject:@"232,115,250" forKey:@"negativeSelectedColor"];
    //	[series addObject:serie];
    //	[secOne addObject:serie];
    
    //************************************************************************************************************************************
	
	//VOL
	serie = [[NSMutableDictionary alloc] init]; 
	data = [[NSMutableArray alloc] init];
	[serie setObject:@"vol" forKey:@"name"];
	[serie setObject:@"VOL" forKey:@"label"];
	[serie setObject:data forKey:@"data"];
	[serie setObject:@"column" forKey:@"type"];
	[serie setObject:@"0" forKey:@"yAxis"];
	[serie setObject:@"1" forKey:@"section"];
	[serie setObject:@"0" forKey:@"decimal"];
	[serie setObject:@"176,52,52" forKey:@"color"];
	[serie setObject:@"77,143,42" forKey:@"negativeColor"];
	[serie setObject:@"176,52,52" forKey:@"selectedColor"];
	[serie setObject:@"77,143,42" forKey:@"negativeSelectedColor"];
	[series addObject:serie];
	[secTwo addObject:serie];
	
	//candleChart init
    [self.candleChart setSeries:series];
    
	[[[self.candleChart sections] objectAtIndex:0] setSeries:secOne];
	[[[self.candleChart sections] objectAtIndex:1] setSeries:secTwo];
	[[[self.candleChart sections] objectAtIndex:2] setSeries:secThree];
	[[[self.candleChart sections] objectAtIndex:2] setPaging:YES];
    
    [self.hcandleChart setSeries:series];
	
	[[[self.hcandleChart sections] objectAtIndex:0] setSeries:secOne];
	[[[self.hcandleChart sections] objectAtIndex:1] setSeries:secTwo];
	[[[self.hcandleChart sections] objectAtIndex:2] setSeries:secThree];
	[[[self.hcandleChart sections] objectAtIndex:2] setPaging:YES];
	
	
	NSString *indicatorsString =[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"indicators" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    
	if(indicatorsString != nil){
		NSArray *indicators = [indicatorsString JSONValue];
		for(NSObject *indicator in indicators){
			if([indicator isKindOfClass:[NSArray class]]){
				NSMutableArray *arr = [[NSMutableArray alloc] init];
				for(NSDictionary *indic in indicator){
					NSMutableDictionary *serie = [[NSMutableDictionary alloc] init]; 
					[self setOptions:indic ForSerie:serie];
					[arr addObject:serie];
					[serie release];
				}
			    [self.candleChart addSerie:arr];
				[arr release];
			}else{
				NSDictionary *indic = (NSDictionary *)indicator;
				NSMutableDictionary *serie = [[NSMutableDictionary alloc] init]; 
				[self setOptions:indic ForSerie:serie];
				[self.candleChart addSerie:serie];
				[serie release];
			}
		}
	}
    
    //    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    //    pathAnimation.duration = 10.0;
    //    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    //    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    //    [self.candleChart addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
}

-(void)setOptions:(NSDictionary *)options ForSerie:(NSMutableDictionary *)serie;{
	[serie setObject:[options objectForKey:@"name"] forKey:@"name"];
	[serie setObject:[options objectForKey:@"label"] forKey:@"label"];
	[serie setObject:[options objectForKey:@"type"] forKey:@"type"];
	[serie setObject:[options objectForKey:@"yAxis"] forKey:@"yAxis"];
	[serie setObject:[options objectForKey:@"section"] forKey:@"section"];
	[serie setObject:[options objectForKey:@"color"] forKey:@"color"];
	[serie setObject:[options objectForKey:@"negativeColor"] forKey:@"negativeColor"];
	[serie setObject:[options objectForKey:@"selectedColor"] forKey:@"selectedColor"];
	[serie setObject:[options objectForKey:@"negativeSelectedColor"] forKey:@"negativeSelectedColor"];
}



- (void)doNotification:(NSNotification *)notification{
    //	UIButton *sel = (UIButton *)[self.toolBar viewWithTag:1];
    //	[self buttonPressed:sel];
}



-(BOOL)isCodesExpired{
	NSDate *date = [NSDate date];
	double now = [date timeIntervalSince1970];
	double last = now;
	NSString *autocompTime = (NSString *)[ResourceHelper  getUserDefaults:@"autocompTime"];
	if(autocompTime!=nil){
		last = [autocompTime doubleValue];
		if(now - last >3600*8){
		    return YES;
		}else{
		    return NO;
		}
    }else{
	    return YES;
	}
}

-(void)getAutoCompleteData{	
    NSString *securities =[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"securities" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    
    NSMutableArray *data = [securities JSONValue];
    self.autoCompleteDelegate.items = data;
}

-(void)getData{
    if(chartMode == 0){
        [self.candleChart getSection:2].hidden = YES;
        [self.hcandleChart getSection:2].hidden = YES;
        
    }else{
        [self.candleChart getSection:2].hidden = NO;
        [self.hcandleChart getSection:2].hidden = NO;
    }
    //[self JUHUA];
    
    
    
    NSString * strings = @"105\\AgT+D\\1\\100\\1344833100\\82.570000\\82.550000\\82.580000\\82.550000\\132.000000\\1344832200\\82.580000\\82.580000\\82.600000\\82.559900\\90.000000\\1344831300\\82.570000\\82.589900\\82.589900\\82.570000\\67.000000\\1344830400\\82.550000\\82.580000\\82.589900\\82.550000\\40.000000\\1344829500\\82.540000\\82.559900\\82.559900\\82.529900\\23.000000\\1344828600\\82.550000\\82.529900\\82.559900\\82.529900\\86.000000\\1344827700\\82.550000\\82.559900\\82.570000\\82.540000\\88.000000\\1344826800\\82.540000\\82.540000\\82.559900\\82.529900\\71.000000\\1344825900\\82.550000\\82.519900\\82.570000\\82.510000\\56.000000\\1344825000\\82.550000\\82.559900\\82.570000\\82.540000\\50.000000\\1344824100\\82.559900\\82.559900\\82.589900\\82.559900\\99.000000\\1344823200\\82.609900\\82.550000\\82.609900\\82.550000\\90.000000\\1344822300\\82.660000\\82.600000\\82.669900\\82.570000\\67.000000\\1344821400\\82.669900\\82.650000\\82.679900\\82.650000\\98.000000\\1344820500\\82.679900\\82.679900\\82.709900\\82.669900\\84.000000\\1344819600\\82.669900\\82.669900\\82.679900\\82.650000\\88.000000\\1344818700\\82.650000\\82.660000\\82.669900\\82.629900\\70.000000\\1344817800\\82.640000\\82.640000\\82.650000\\82.620000\\78.000000\\1344816900\\82.629900\\82.629900\\82.660000\\82.620000\\49.000000\\1344816000\\82.589900\\82.640000\\82.640000\\82.589900\\51.000000\\1344815100\\82.580000\\82.580000\\82.589900\\82.570000\\37.000000\\1344814200\\82.580000\\82.589900\\82.600000\\82.580000\\63.000000\\1344813300\\82.589900\\82.589900\\82.600000\\82.580000\\61.000000\\1344812400\\82.589900\\82.580000\\82.589900\\82.580000\\4.000000\\1344700800\\82.550000\\82.540000\\82.550000\\82.510000\\69.000000\\1344632400\\82.540000\\82.559900\\82.580000\\82.540000\\56.000000\\1344631500\\82.559900\\82.550000\\82.580000\\82.550000\\42.000000\\1344630600\\82.570000\\82.550000\\82.580000\\82.550000\\22.000000\\1344629700\\82.540000\\82.559900\\82.570000\\82.540000\\28.000000\\1344628800\\82.529900\\82.550000\\82.550000\\82.510000\\84.000000\\1344627900\\82.570000\\82.540000\\82.570000\\82.529900\\50.000000\\1344627000\\82.570000\\82.559900\\82.570000\\82.550000\\48.000000\\1344626100\\82.570000\\82.559900\\82.570000\\82.550000\\53.000000\\1344625200\\82.550000\\82.559900\\82.570000\\82.550000\\69.000000\\1344624300\\82.550000\\82.559900\\82.559900\\82.540000\\96.000000\\1344623400\\82.550000\\82.559900\\82.559900\\82.540000\\99.000000\\1344622500\\82.550000\\82.559900\\82.559900\\82.540000\\111.000000\\1344621600\\82.540000\\82.540000\\82.550000\\82.540000\\80.000000\\1344620700\\82.550000\\82.550000\\82.570000\\82.540000\\84.000000\\1344619800\\82.559900\\82.559900\\82.580000\\82.550000\\70.000000\\1344618900\\82.550000\\82.570000\\82.580000\\82.550000\\76.000000\\1344618000\\82.519900\\82.559900\\82.559900\\82.519900\\77.000000\\1344617100\\82.510000\\82.529900\\82.540000\\82.510000\\97.000000\\1344616200\\82.570000\\82.519900\\82.570000\\82.519900\\97.000000\\1344615300\\82.550000\\82.559900\\82.580000\\82.540000\\79.000000\\1344614400\\82.779900\\82.739900\\82.800000\\82.739900\\83.000000\\1344613500\\82.540000\\82.540000\\82.580000\\82.540000\\107.000000\\1344612600\\82.529900\\82.550000\\82.580000\\82.510000\\78.000000\\1344611700\\82.480000\\82.540000\\82.559900\\82.480000\\97.000000\\1344610800\\82.459900\\82.470000\\82.519900\\82.440000\\122.000000\\1344609900\\82.519900\\82.450000\\82.540000\\82.440000\\97.000000\\1344609000\\82.640000\\82.529900\\82.669900\\82.529900\\83.000000\\1344608100\\82.760000\\82.650000\\82.769900\\82.650000\\103.000000\\1344607200\\82.830000\\82.750000\\82.839900\\82.739900\\77.000000\\1344606300\\82.830000\\82.839900\\82.879900\\82.820000\\75.000000\\1344605400\\82.720000\\82.820000\\82.820000\\82.720000\\103.000000\\1344604500\\82.750000\\82.730000\\82.769900\\82.730000\\82.000000\\1344603600\\82.800000\\82.760000\\82.830000\\82.739900\\66.000000\\1344602700\\82.800000\\82.790000\\82.830000\\82.779900\\97.000000\\1344601800\\82.800000\\82.809900\\82.809900\\82.769900\\60.000000\\1344600900\\82.779900\\82.790000\\82.800000\\82.760000\\81.000000\\1344600000\\82.750000\\82.769900\\82.779900\\82.739900\\71.000000\\1344599100\\82.769900\\82.760000\\82.779900\\82.739900\\68.000000\\1344598200\\82.760000\\82.760000\\82.769900\\82.739900\\98.000000\\1344597300\\82.760000\\82.750000\\82.779900\\82.739900\\78.000000\\1344596400\\82.750000\\82.750000\\82.769900\\82.739900\\76.000000\\1344595500\\82.760000\\82.760000\\82.779900\\82.750000\\76.000000\\1344594600\\82.730000\\82.750000\\82.760000\\82.730000\\53.000000\\1344593700\\82.720000\\82.739900\\82.760000\\82.709900\\64.000000\\1344592800\\82.730000\\82.730000\\82.750000\\82.720000\\90.000000\\1344591900\\82.739900\\82.739900\\82.790000\\82.730000\\54.000000\\1344591000\\82.730000\\82.730000\\82.760000\\82.730000\\82.000000\\1344590100\\82.730000\\82.739900\\82.769900\\82.720000\\103.000000\\1344589200\\82.739900\\82.720000\\82.750000\\82.720000\\49.000000\\1344588300\\82.750000\\82.730000\\82.750000\\82.720000\\82.000000\\1344587400\\82.720000\\82.760000\\82.760000\\82.720000\\90.000000\\1344586500\\82.760000\\82.730000\\82.769900\\82.730000\\87.000000\\1344585600\\82.779900\\82.769900\\82.800000\\82.760000\\60.000000\\1344584700\\82.809900\\82.790000\\82.820000\\82.779900\\63.000000\\1344583800\\82.739900\\82.820000\\82.830000\\82.720000\\88.000000\\1344582900\\82.700000\\82.730000\\82.739900\\82.690000\\74.000000\\1344582000\\82.690000\\82.709900\\82.730000\\82.660000\\110.000000\\1344581100\\82.650000\\82.679900\\82.690000\\82.640000\\74.000000\\1344580200\\82.690000\\82.660000\\82.690000\\82.650000\\93.000000\\1344579300\\82.700000\\82.679900\\82.700000\\82.679900\\84.000000\\1344578400\\82.660000\\82.690000\\82.709900\\82.660000\\125.000000\\1344577500\\82.669900\\82.669900\\82.679900\\82.660000\\103.000000\\1344576600\\82.700000\\82.679900\\82.709900\\82.679900\\84.000000\\1344575700\\82.669900\\82.709900\\82.720000\\82.669900\\72.000000\\1344574800\\82.679900\\82.679900\\82.690000\\82.669900\\48.000000\\1344573900\\82.669900\\82.669900\\82.700000\\82.669900\\107.000000\\1344573000\\82.660000\\82.679900\\82.679900\\82.650000\\129.000000\\1344572100\\82.679900\\82.669900\\82.679900\\82.660000\\29.000000\\1344571200\\82.650000\\82.669900\\82.679900\\82.650000\\90.000000\\1344570300\\82.679900\\82.660000\\82.690000\\82.650000\\43.000000\\1344569400\\82.650000\\82.690000\\82.700000\\82.650000\\70.000000\\1344568500\\82.640000\\82.640000\\82.709900\\82.629900\\96.000000\\1344567600\\82.650000\\82.650000\\82.650000\\82.629900\\87.000000\\1344566700\\82.650000\\82.640000\\82.650000\\82.640000\\125.000000\\1344565800\\82.650000\\82.640000\\82.669900\\82.640000\\72.000000\\1344564900\\82.640000\\82.660000\\82.669900\\82.640000\\61.000000\\1344564000\\82.660000\\82.650000\\82.660000\\82.629900\\111.000000\\1344563100\\82.640000\\82.650000\\82.669900\\82.640000\\101.000000\\1344562200\\82.640000\\82.650000\\82.650000\\82.629900\\162.000000\\1344561300\\82.640000\\82.629900\\82.650000\\82.629900\\119.000000\\1344560400\\82.640000\\82.629900\\82.660000\\82.620000\\88.000000\\1344559500\\82.650000\\82.629900\\82.650000\\82.620000\\165.000000\\1344558600\\82.640000\\82.640000\\82.650000\\82.629900\\122.000000\\1344557700\\82.650000\\82.629900\\82.660000\\82.629900\\112.000000\\1344556800\\82.650000\\82.660000\\82.669900\\82.629900\\107.000000\\1344555900\\82.629900\\82.640000\\82.660000\\82.629900\\69.000000\\1344555000\\82.640000\\82.640000\\82.650000\\82.629900\\53.000000\\1344554100\\82.609900\\82.629900\\82.660000\\82.609900\\74.000000\\1344553200\\82.629900\\82.620000\\82.640000\\82.609900\\107.000000\\1344552300\\82.600000\\82.620000\\82.629900\\82.600000\\75.000000\\1344551400\\82.600000\\82.609900\\82.609900\\82.600000\\40.000000\\1344550500\\82.609900\\82.609900\\82.620000\\82.600000\\112.000000\\1344549600\\82.570000\\82.570000\\82.570000\\82.570000\\0.000000\\1344548700\\82.589900\\82.609900\\82.620000\\82.589900\\79.000000\\1344547800\\82.609900\\82.600000\\82.609900\\82.580000\\56.000000\\1344546900\\82.589900\\82.600000\\82.609900\\82.580000\\62.000000\\1344546000\\82.600000\\82.600000\\82.609900\\82.580000\\96.000000\\1344545100\\82.609900\\82.609900\\82.620000\\82.589900\\74.000000\\1344544200\\82.620000\\82.620000\\82.640000\\82.609900\\56.000000\\1344543300\\82.640000\\82.629900\\82.640000\\82.620000\\97.000000\\1344542400\\82.640000\\82.629900\\82.650000\\82.629900\\68.000000\\1344541500\\82.640000\\82.650000\\82.660000\\82.640000\\68.000000\\1344540600\\82.660000\\82.650000\\82.669900\\82.640000\\61.000000\\1344539700\\82.640000\\82.650000\\82.669900\\82.640000\\82.000000\\1344538800\\82.679900\\82.650000\\82.679900\\82.640000\\99.000000\\1344537900\\82.679900\\82.669900\\82.700000\\82.660000\\77.000000\\1344537000\\82.690000\\82.700000\\82.709900\\82.679900\\42.000000\\1344536100\\82.690000\\82.700000\\82.709900\\82.679900\\123.000000\\1344535200\\82.700000\\82.700000\\82.720000\\82.690000\\112.000000\\1344534300\\82.700000\\82.709900\\82.730000\\82.700000\\60.000000\\1344533400\\82.750000\\82.709900\\82.760000\\82.700000\\30.000000\\1344532500\\82.739900\\82.760000\\82.779900\\82.739900\\107.000000\\1344531600\\82.739900\\82.750000\\82.750000\\82.720000\\56.000000\\1344530700\\82.760000\\82.730000\\82.769900\\82.720000\\64.000000\\1344529800\\82.769900\\82.750000\\82.769900\\82.739900\\100.000000\\1344528900\\82.730000\\82.760000\\82.779900\\82.730000\\77.000000\\1344528000\\82.350000\\82.350000\\82.370000\\82.339900\\92.000000\\1344527100\\82.660000\\82.769900\\82.800000\\82.660000\\86.000000\\1344526200\\82.609900\\82.669900\\82.709900\\82.580000\\69.000000\\1344525300\\82.589900\\82.600000\\82.609900\\82.580000\\87.000000\\1344524400\\82.600000\\82.600000\\82.600000\\82.540000\\142.000000\\1344523500\\82.629900\\82.589900\\82.660000\\82.580000\\139.000000\\1344522600\\82.650000\\82.640000\\82.669900\\82.640000\\68.000000\\1344521700\\82.720000\\82.660000\\82.720000\\82.640000\\76.000000\\1344520800\\82.650000\\82.709900\\82.709900\\82.650000\\58.000000\\1344519900\\82.700000\\82.660000\\82.750000\\82.650000\\58.000000\\1344519000\\82.679900\\82.690000\\82.739900\\82.679900\\71.000000\\1344518100\\82.640000\\82.690000\\82.700000\\82.629900\\64.000000\\1344517200\\82.629900\\82.629900\\82.669900\\82.609900\\86.000000\\1344516300\\82.629900\\82.620000\\82.650000\\82.589900\\84.000000\\1344515400\\82.629900\\82.640000\\82.679900\\82.609900\\116.000000\\1344514500\\82.609900\\82.620000\\82.650000\\82.589900\\135.000000\\1344513600\\82.620000\\82.600000\\82.629900\\82.580000\\66.000000\\1344512700\\82.589900\\82.629900\\82.640000\\82.580000\\51.000000\\1344511800\\82.550000\\82.580000\\82.629900\\82.540000\\100.000000\\1344510900\\82.559900\\82.540000\\82.559900\\82.529900\\78.000000\\1344510000\\82.540000\\82.550000\\82.559900\\82.540000\\86.000000\\1344509100\\82.600000\\82.550000\\82.609900\\82.540000\\109.000000\\1344508200\\82.580000\\82.589900\\82.609900\\82.570000\\82.000000\\1344507300\\82.459900\\82.570000\\82.589900\\82.450000\\131.000000\\1344506400\\82.440000\\82.450000\\82.450000\\82.419900\\72.000000\\1344505500\\82.429900\\82.450000\\82.470000\\82.429900\\72.000000\\1344504600\\82.450000\\82.440000\\82.459900\\82.419900\\39.000000\\1344503700\\82.470000\\82.459900\\82.480000\\82.450000\\102.000000\\1344502800\\82.470000\\82.480000\\82.489900\\82.450000\\69.000000\\1344501900\\82.480000\\82.459900\\82.500000\\82.450000\\70.000000\\1344501000\\82.400000\\82.470000\\82.480000\\82.400000\\128.000000\\1344500100\\82.390000\\82.410000\\82.410000\\82.390000\\40.000000\\1344499200\\82.350000\\82.400000\\82.419900\\82.350000\\84.000000\\1344498300\\82.309900\\82.359900\\82.359900\\82.309900\\63.000000\\1344497400\\82.339900\\82.320000\\82.359900\\82.309900\\69.000000\\1344496500\\82.279900\\82.350000\\82.359900\\82.269900\\83.000000\\1344495600\\82.290000\\82.269900\\82.300000\\82.250000\\88.000000\\1344494700\\82.300000\\82.300000\\82.300000\\82.250000\\68.000000\\1344493800\\82.290000\\82.290000\\82.320000\\82.279900\\77.000000\\1344492900\\82.330000\\82.300000\\82.339900\\82.300000\\101.000000\\1344492000\\82.320000\\82.320000\\82.339900\\82.309900\\63.000000\\1344491100\\82.300000\\82.309900\\82.320000\\82.279900\\68.000000\\1344490200\\82.260000\\82.290000\\82.290000\\82.239900\\63.000000\\1344489300\\82.260000\\82.250000\\82.279900\\82.250000\\87.000000\\1344488400\\82.290000\\82.269900\\82.290000\\82.260000\\119.000000\\1344487500\\82.300000\\82.279900\\82.300000\\82.279900\\80.000000\\1344486600\\82.279900\\82.290000\\82.300000\\82.269900\\70.000000\\1344485700\\82.269900\\82.269900\\82.279900\\82.260000\\51.000000\\1344484800\\82.239900\\82.260000\\82.279900\\82.239900\\71.000000\\1344483900\\82.269900\\82.250000\\82.279900\\82.250000\\66.000000\\1344483000\\82.260000\\82.279900\\82.290000\\82.239900\\103.000000\\1344482100\\82.269900\\82.269900\\82.279900\\82.250000\\43.000000\\1344481200\\82.250000\\82.260000\\82.269900\\82.250000\\86.000000\\1344480300\\82.279900\\82.260000\\82.290000\\82.250000\\75.000000\\1344479400\\82.279900\\82.290000\\82.290000\\82.260000\\65.000000\\1344478500\\82.260000\\82.290000\\82.300000\\82.260000\\65.000000\\1344477600\\82.260000\\82.269900\\82.300000\\82.250000\\79.000000\\1344476700\\82.300000\\82.250000\\82.309900\\82.239900\\81.000000\\1344475800\\82.290000\\82.290000\\82.309900\\82.279900\\49.000000\\1344474900\\82.290000\\82.300000\\82.300000\\82.279900\\59.000000\\1344474000\\82.309900\\82.300000\\82.320000\\82.290000\\55.000000\\1344473100\\82.309900\\82.300000\\82.320000\\82.300000\\115.000000\\1344472200\\82.309900\\82.300000\\82.309900\\82.300000\\105.000000\\1344471300\\82.309900\\82.300000\\82.320000\\82.290000\\130.000000\\1344470400\\82.330000\\82.320000\\82.330000\\82.300000\\47.000000\\1344469500\\82.339900\\82.320000\\82.339900\\82.320000\\67.000000\\1344468600\\82.309900\\82.330000\\82.339900\\82.309900\\54.000000\\1344467700\\82.309900\\82.300000\\82.320000\\82.290000\\57.000000\\1344466800\\82.339900\\82.320000\\82.359900\\82.309900\\47.000000\\1344465900\\82.339900\\82.350000\\82.350000\\82.339900\\59.000000\\1344465000\\82.350000\\82.350000\\82.359900\\82.350000\\89.000000\\1344464100\\82.350000\\82.359900\\82.359900\\82.339900\\57.000000\\1344463200\\82.600000\\82.600000\\82.609900\\82.589900\\50.000000\\1344462300\\82.350000\\82.339900\\82.370000\\82.339900\\94.000000\\1344461400\\82.350000\\82.359900\\82.359900\\82.339900\\56.000000\\1344460500\\82.339900\\82.359900\\82.359900\\82.330000\\118.000000\\1344459600\\82.339900\\82.359900\\82.359900\\82.330000\\55.000000\\1344458700\\82.379900\\82.350000\\82.379900\\82.350000\\83.000000\\1344457800\\82.370000\\82.370000\\82.410000\\82.370000\\106.000000\\1344456900\\82.390000\\82.379900\\82.390000\\82.359900\\61.000000\\1344456000\\82.379900\\82.379900\\82.390000\\82.370000\\73.000000\\1344455100\\82.379900\\82.370000\\82.379900\\82.359900\\37.000000\\1344454200\\82.390000\\82.370000\\82.400000\\82.359900\\65.000000\\1344453300\\82.410000\\82.400000\\82.419900\\82.390000\\84.000000\\1344452400\\82.379900\\82.419900\\82.419900\\82.379900\\87.000000\\1344451500\\82.410000\\82.390000\\82.429900\\82.370000\\71.000000\\1344450600\\82.440000\\82.419900\\82.440000\\82.419900\\90.000000\\1344449700\\82.419900\\82.429900\\82.440000\\82.410000\\145.000000\\1344448800\\82.379900\\82.410000\\82.410000\\82.370000\\53.000000\\1344447900\\82.359900\\82.390000\\82.410000\\82.350000\\72.000000\\1344447000\\82.350000\\82.350000\\82.370000\\82.339900\\84.000000\\1344446100\\82.320000\\82.359900\\82.370000\\82.320000\\59.000000\\1344445200\\82.320000\\82.330000\\82.350000\\82.320000\\85.000000\\1344444300\\82.330000\\82.330000\\82.350000\\82.320000\\80.000000\\1344443400\\82.330000\\82.339900\\82.350000\\82.309900\\91.000000\\1344442500\\82.339900\\82.339900\\82.359900\\82.339900\\71.000000\\1344441600\\82.179900\\82.169900\\82.190000\\82.160000\\61.000000\\1344440700\\82.309900\\82.339900\\82.339900\\82.269900\\97.000000\\1344439800\\82.290000\\82.320000\\82.320000\\82.269900\\80.000000\\1344438900\\82.359900\\82.279900\\82.359900\\82.260000\\81.000000\\1344438000\\82.400000\\82.370000\\82.400000\\82.350000\\99.000000\\1344437100\\82.429900\\82.410000\\82.459900\\82.410000\\64.000000\\1344436200\\82.440000\\82.419900\\82.470000\\82.419900\\81.000000\\1344435300\\82.450000\\82.450000\\82.470000\\82.429900\\72.000000\\1344434400\\82.489900\\82.459900\\82.489900\\82.450000\\73.000000\\1344433500\\82.470000\\82.480000\\82.489900\\82.429900\\109.000000\\1344432600\\82.459900\\82.480000\\82.500000\\82.450000\\66.000000\\1344431700\\82.480000\\82.470000\\82.529900\\82.470000\\101.000000\\1344430800\\82.489900\\82.489900\\82.510000\\82.450000\\48.000000\\1344429900\\82.500000\\82.500000\\82.510000\\82.429900\\87.000000\\1344429000\\82.510000\\82.510000\\82.529900\\82.459900\\83.000000\\1344428100\\82.419900\\82.500000\\82.510000\\82.419900\\103.000000\\1344427200\\82.370000\\82.410000\\82.429900\\82.359900\\62.000000\\1344426300\\82.359900\\82.359900\\82.379900\\82.320000\\76.000000\\1344425400\\82.339900\\82.370000\\82.379900\\82.339900\\88.000000\\1344424500\\82.410000\\82.350000\\82.410000\\82.339900\\33.000000\\1344423600\\82.359900\\82.400000\\82.410000\\82.350000\\77.000000\\1344422700\\82.330000\\82.350000\\82.359900\\82.309900\\83.000000\\1344421800\\82.400000\\82.339900\\82.410000\\82.320000\\82.000000\\1344420900\\82.400000\\82.410000\\82.429900\\82.330000\\116.000000\\1344420000\\82.400000\\82.390000\\82.429900\\82.379900\\85.000000\\1344419100\\82.359900\\82.410000\\82.419900\\82.339900\\80.000000\\1344418200\\82.350000\\82.370000\\82.379900\\82.350000\\53.000000\\1344417300\\82.300000\\82.339900\\82.339900\\82.269900\\79.000000\\1344416400\\82.309900\\82.309900\\82.320000\\82.290000\\56.000000\\1344415500\\82.370000\\82.320000\\82.390000\\82.320000\\87.000000\\1344414600\\82.390000\\82.379900\\82.410000\\82.359900\\73.000000\\1344413700\\82.410000\\82.379900\\82.419900\\82.359900\\95.000000\\1344412800\\82.370000\\82.419900\\82.419900\\82.370000\\83.000000\\1344411900\\82.410000\\82.359900\\82.440000\\82.359900\\103.000000\\1344411000\\82.419900\\82.419900\\82.429900\\82.390000\\89.000000\\1344410100\\82.410000\\82.410000\\82.440000\\82.379900\\66.000000\\1344409200\\82.400000\\82.400000\\82.450000\\82.359900\\54.000000\\1344408300\\82.350000\\82.390000\\82.440000\\82.339900\\82.000000\\1344407400\\82.320000\\82.339900\\82.350000\\82.300000\\108.000000\\1344406500\\82.300000\\82.330000\\82.339900\\82.290000\\66.000000\\1344405600\\82.290000\\82.290000\\82.309900\\82.279900\\73.000000\\1344404700\\82.320000\\82.300000\\82.320000\\82.300000\\53.000000\\1344403800\\82.330000\\82.309900\\82.350000\\82.300000\\55.000000\\1344402900\\82.350000\\82.339900\\82.359900\\82.330000\\93.000000\\1344402000\\82.330000\\82.339900\\82.359900\\82.330000\\46.000000\\1344401100\\82.320000\\82.320000\\82.320000\\82.309900\\80.000000\\1344400200\\82.309900\\82.309900\\82.320000\\82.300000\\25.000000\\1344399300\\82.300000\\82.320000\\82.330000\\82.279900\\64.000000\\1344398400\\82.300000\\82.290000\\82.309900\\82.290000\\41.000000\\1344397500\\82.300000\\82.290000\\82.309900\\82.290000\\59.000000\\1344396600\\82.290000\\82.290000\\82.309900\\82.290000\\33.000000\\1344395700\\82.290000\\82.300000\\82.300000\\82.290000\\102.000000\\1344394800\\82.300000\\82.300000\\82.300000\\82.269900\\65.000000\\1344393900\\82.279900\\82.290000\\82.300000\\82.279900\\53.000000\\1344393000\\82.279900\\82.290000\\82.290000\\82.269900\\108.000000\\1344392100\\82.279900\\82.279900\\82.300000\\82.279900\\91.000000\\1344391200\\82.290000\\82.290000\\82.309900\\82.279900\\66.000000\\1344390300\\82.300000\\82.300000\\82.309900\\82.279900\\62.000000\\1344389400\\82.330000\\82.309900\\82.330000\\82.309900\\107.000000\\1344388500\\82.309900\\82.320000\\82.330000\\82.309900\\68.000000\\1344387600\\82.300000\\82.320000\\82.330000\\82.300000\\74.000000\\1344386700\\82.359900\\82.309900\\82.370000\\82.300000\\80.000000\\1344385800\\82.359900\\82.370000\\82.390000\\82.350000\\70.000000\\1344384900\\82.370000\\82.370000\\82.400000\\82.350000\\86.000000\\1344384000\\82.370000\\82.359900\\82.370000\\82.339900\\65.000000\\1344383100\\82.339900\\82.359900\\82.359900\\82.320000\\74.000000\\1344382200\\82.330000\\82.330000\\82.339900\\82.309900\\68.000000\\1344381300\\82.320000\\82.339900\\82.350000\\82.320000\\52.000000\\1344380400\\82.309900\\82.330000\\82.330000\\82.309900\\57.000000\\1344379500\\82.330000\\82.320000\\82.339900\\82.320000\\44.000000\\1344378600\\82.320000\\82.320000\\82.320000\\82.309900\\20.000000\\1344377700\\82.300000\\82.309900\\82.309900\\82.290000\\35.000000\\1344376800\\82.350000\\82.339900\\82.350000\\82.330000\\42.000000\\1344375900\\82.290000\\82.290000\\82.300000\\82.279900\\62.000000\\1344375000\\82.300000\\82.300000\\82.309900\\82.279900\\85.000000\\1344374100\\82.300000\\82.309900\\82.320000\\82.290000\\93.000000\\1344373200\\82.279900\\82.290000\\82.300000\\82.269900\\86.000000\\1344372300\\82.290000\\82.269900\\82.300000\\82.269900\\33.000000\\1344371400\\82.279900\\82.300000\\82.300000\\82.250000\\87.000000\\1344370500\\82.279900\\82.269900\\82.279900\\82.260000\\104.000000\\1344369600\\82.250000\\82.290000\\82.309900\\82.250000\\83.000000\\1344368700\\82.260000\\82.260000\\82.279900\\82.250000\\85.000000\\1344367800\\82.239900\\82.250000\\82.260000\\82.239900\\68.000000\\1344366900\\82.239900\\82.250000\\82.260000\\82.239900\\134.000000\\1344366000\\82.239900\\82.230000\\82.250000\\82.220000\\79.000000\\1344365100\\82.260000\\82.230000\\82.269900\\82.220000\\101.000000\\1344364200\\82.239900\\82.269900\\82.269900\\82.209900\\46.000000\\1344363300\\82.179900\\82.230000\\82.239900\\82.179900\\95.000000\\1344362400\\82.190000\\82.190000\\82.200000\\82.169900\\66.000000\\1344361500\\82.209900\\82.179900\\82.209900\\82.179900\\126.000000\\1344360600\\82.209900\\82.200000\\82.220000\\82.190000\\119.000000\\1344359700\\82.190000\\82.200000\\82.209900\\82.190000\\70.000000\\";
    
    NSString *newMessage2 = strings;//[[NSString alloc] initWithData:data encoding:NSUTF16BigEndianStringEncoding];
    
    //              NSLog(@"第%d次的数据为\n==%@",count++,newMessage2);       
    
    NSArray   *arr = [newMessage2 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\\"]];
    datas =[[NSMutableArray alloc] init];
    NSMutableArray *newData =[[NSMutableArray alloc] init];
    
    NSMutableArray *allData =[[NSMutableArray alloc] init];
    NSMutableArray *category =[[NSMutableArray alloc] init];
    
    for (int i = 4; i<[arr count]; i++) 
    {
        NSString * lines = [arr objectAtIndex:i];
        [allData addObject:lines];
        if ([allData count]%6==0) {
            
            NSString * str = [allData objectAtIndex:0];
            NSString * str1= [allData objectAtIndex:1];
            NSString * str2= [allData objectAtIndex:2];
            NSString * str3= [allData objectAtIndex:3];
            NSString * str4= [allData objectAtIndex:4];
            NSString * str5= [allData objectAtIndex:5];
            
            NSString * str6 = [NSString  stringWithFormat:@"%@,%@,%@,%@,%@,%@",str,str1,str2,str3,str4,str5];  
            [newData addObject:str6];
            [allData removeAllObjects];
        }
    }
    [newData addObject:@"Date,open,close,higt,low,volum"];
    
    //    NSLog(@"%@ , %d",newData,[newData count]);
    for (int i = [newData count]-1; i>=0; i--) {
        NSString *line = [newData objectAtIndex:i];
        if([line isEqualToString:@""]){
            //    continue;
        }
        NSArray   *arr = [line componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        
        NSDate *nd = [NSDate dateWithTimeIntervalSince1970:[[arr objectAtIndex:0] intValue]];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MM-dd HH:mm"];
        NSString *dateString = [dateFormat stringFromDate:nd];   
        
        [category addObject:dateString];
        
        NSMutableArray *item =[[NSMutableArray alloc] init];
        //    //所有数据 DATE,OPEN,HIGH LOW CLOSE VOLUME ADJ CLOSE
        
        [item addObject:[arr objectAtIndex:1]];//open
        [item addObject:[arr objectAtIndex:2]];//CLOSE
        [item addObject:[arr objectAtIndex:3]];//HIGH
        [item addObject:[arr objectAtIndex:4]];//LOW
        [item addObject:[arr objectAtIndex:5]];//volume
        [datas addObject:item];
    }
    //   NSLog(@"data = %@,data = %d",datas,[datas count]);
    if (datas.count>5) {
        
        self.viewHUB.hidden = YES;
        self.viewBack.hidden = YES;
        [self.activity stopAnimating];
        self.imageBack.hidden =YES ;
        self.backButton.hidden =YES;
        
        self.viewHUB = nil;
        self.viewBack = nil;
        self.imageBack = nil;
        self.backButton = nil;
        [self.activity stopAnimating];//风火轮停止
        
    }
    if(datas.count==0){
        UIAlertView * alertV = [[UIAlertView alloc] initWithTitle:@"服务器数据=0!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"重试",@"首页", nil];
        alertV.tag = 1000;
        [alertV show];
        //                return;
    }
    
    if (chartMode == 0) {
        if([self.req_type isEqualToString:@"T"]){
            if(self.timer != nil)
                [self.timer invalidate];
            [self.candleChart reset];
            [self.hcandleChart reset];
            
            [self.candleChart clearData];
            [self.hcandleChart clearData];
            
            [self.candleChart clearCategory];
            [self.hcandleChart clearCategory];
            
            
            if([self.req_freq hasSuffix:@"m"]){
                self.req_type = @"L";
            }
        }else{
            
            NSString *time = [category objectAtIndex:0];
            
            if([time isEqualToString:self.lastTime]){
                
                if([time hasSuffix:@"1500"]){
                    if(self.timer != nil)
                        [self.timer invalidate];
                }
                return;
            }
            
            
            
            if ([time hasSuffix:@"1130"] || [time hasSuffix:@"1500"]) {
                if(self.tradeStatus == 1){
                    self.tradeStatus = 0;
                }
            }else{
                self.tradeStatus = 1;
            }
        }
    }else{
        if(self.timer != nil)
            [self.timer invalidate];
        [self.candleChart reset];
        [self.candleChart clearData];
        [self.candleChart clearCategory];
        
        [self.hcandleChart reset];
        [self.hcandleChart clearData];
        [self.hcandleChart clearCategory];
    }
    
    self.lastTime = [category lastObject];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [self generateData:dic From:datas];
    [self setData:dic];
    // NSLog(@"dic = %d",datas.count);
    
    
    if(chartMode == 0){
        [self setCategory:category];
    }else{
        NSMutableArray *cate = [[NSMutableArray alloc] init];
        for(int i=60;i<category.count;i++){
            [cate addObject:[category objectAtIndex:i]];
        }
        [self setCategory:cate];
    }
    [self.candleChart setNeedsDisplay];
    [self.hcandleChart setNeedsDisplay];
    
    //    data1=[[data alloc]init];
    //    _data2=[[data2 alloc]init];
    //    count=2;
    //    
    //    socket1=[[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    //    
    //    NSError *err=nil;    
    //    if(![socket1 connectToHost:@"222.73.211.226" onPort:25010 error:&err]) 
    //    { 
    //        NSLog(@"连接出错");
    //    }else{
    //        NSLog(@"123123");
    //        [self addText:@"打开端口"];
    //    }
}

- (void)addText:(NSString *)str
{
    status.text = [status.text stringByAppendingFormat:@"%@\n",str];
}
#pragma mark - socket Delegate
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    
    NSLog(@"sock.isConnected = %d",sock.isConnected);
    
    requestLength =[NSString stringWithFormat:@"104\\%@\\%@\\%@\\%d",self.userName,self.passWord,self.codeName,self.Minute];
    NSLog(@"requestLength = %d",requestLength.length);
    
    request1=[NSString stringWithFormat:@"%d\\104\\%@\\%@\\%@\\%d",requestLength.length*2,self.userName,self.passWord,self.codeName,self.Minute];
    requestData1 = [request1 dataUsingEncoding: NSUTF16BigEndianStringEncoding];
    [socket1 writeData:requestData1 withTimeout:-1 tag:1];
    NSLog(@"request = %@",request1);
    
    
    [socket1 readDataWithTimeout:-1 tag:20];
    NSLog(@"**************");
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    UIAlertView * alertV = [[UIAlertView alloc] initWithTitle:@"坑爹呢?登陆不上去!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"重试",@"首页", nil];
    alertV.tag = 888;
    [alertV show];
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{ 
    newMessage = [[NSString alloc] initWithData:data encoding:NSUTF16BigEndianStringEncoding];
    
    
    _data2.messagelength=[newMessage intValue];
    if (tag ==20) {
        [socket1 readDataToLength:_data2.messagelength withTimeout:-1 tag:21];
        return;
    }
    
    //   NSLog(@"length=========%d ~~~~~~~~~%d",_data2.messagelength,newMessage.length);
    
    // NSLog(@"new = %@",newMessage);
    if (tag == 21) {
        
        if (sock==socket1)
        {                
            
            NSLog(@"第二次得到的数据");
            
            
            NSString * strings = @"105\\AgT+D\\1\\100\\1343287740\\5790.000000\\5791.000000\\5792.000000\\5790.000000\\2860.000000\\1343287680\\5790.000000\\5790.000000\\5791.000000\\5789.000000\\4040.000000\\1343287620\\5789.000000\\5790.000000\\5790.000000\\5789.000000\\3176.000000\\1343287560\\5790.000000\\5789.000000\\5790.000000\\5789.000000\\2906.000000\\1343287500\\5789.000000\\5790.000000\\5790.000000\\5789.000000\\1480.000000\\1343287440\\5789.000000\\5789.000000\\5790.000000\\5788.000000\\2108.000000\\1343287380\\5789.000000\\5789.000000\\5790.000000\\5788.000000\\994.000000\\1343287320\\5788.000000\\5788.000000\\5789.000000\\5788.000000\\2082.000000\\1343287260\\5789.000000\\5788.000000\\5789.000000\\5787.000000\\1522.000000\\1343287200\\5788.000000\\5789.000000\\5789.000000\\5788.000000\\556.000000\\1343287140\\5788.000000\\5788.000000\\5789.000000\\5787.000000\\1756.000000\\1343287080\\5788.000000\\5788.000000\\5788.000000\\5787.000000\\364.000000\\1343287020\\5788.000000\\5788.000000\\5789.000000\\5787.000000\\196.000000\\1343286960\\5789.000000\\5788.000000\\5789.000000\\5787.000000\\264.000000\\1343286900\\5788.000000\\5789.000000\\5789.000000\\5787.000000\\338.000000\\1343286840\\5787.000000\\5788.000000\\5789.000000\\5787.000000\\780.000000\\1343286780\\5787.000000\\5787.000000\\5788.000000\\5786.000000\\556.000000\\1343286720\\5786.000000\\5787.000000\\5788.000000\\5786.000000\\400.000000\\1343286660\\5787.000000\\5787.000000\\5787.000000\\5786.000000\\268.000000\\1343286600\\5786.000000\\5786.000000\\5788.000000\\5786.000000\\118.000000\\1343286540\\5784.000000\\5786.000000\\5786.000000\\5784.000000\\384.000000\\1343286480\\5784.000000\\5785.000000\\5785.000000\\5784.000000\\354.000000\\1343286420\\5782.000000\\5785.000000\\5785.000000\\5782.000000\\310.000000\\1343286360\\5786.000000\\5783.000000\\5788.000000\\5783.000000\\1258.000000\\1343286300\\5790.000000\\5788.000000\\5790.000000\\5788.000000\\980.000000\\1343286240\\5791.000000\\5790.000000\\5791.000000\\5789.000000\\786.000000\\1343286180\\5792.000000\\5791.000000\\5792.000000\\5790.000000\\116.000000\\1343286120\\5791.000000\\5792.000000\\5792.000000\\5791.000000\\210.000000\\1343286060\\5793.000000\\5792.000000\\5793.000000\\5791.000000\\284.000000\\1343286000\\5793.000000\\5792.000000\\5793.000000\\5791.000000\\836.000000\\1343285940\\5792.000000\\5792.000000\\5793.000000\\5791.000000\\790.000000\\1343285880\\5792.000000\\5792.000000\\5792.000000\\5791.000000\\530.000000\\1343285820\\5792.000000\\5792.000000\\5793.000000\\5791.000000\\526.000000\\1343285760\\5791.000000\\5792.000000\\5792.000000\\5790.000000\\378.000000\\1343285700\\5790.000000\\5790.000000\\5791.000000\\5790.000000\\262.000000\\1343285640\\5790.000000\\5790.000000\\5791.000000\\5790.000000\\718.000000\\1343285580\\5789.000000\\5790.000000\\5791.000000\\5789.000000\\406.000000\\1343285520\\5790.000000\\5789.000000\\5790.000000\\5789.000000\\1240.000000\\1343285460\\5789.000000\\5790.000000\\5790.000000\\5789.000000\\446.000000\\1343285400\\5789.000000\\5789.000000\\5790.000000\\5789.000000\\324.000000\\1343285340\\5788.000000\\5789.000000\\5790.000000\\5788.000000\\498.000000\\1343285280\\5790.000000\\5788.000000\\5790.000000\\5788.000000\\554.000000\\1343285220\\5790.000000\\5790.000000\\5791.000000\\5789.000000\\704.000000\\1343285160\\5790.000000\\5791.000000\\5791.000000\\5790.000000\\844.000000\\1343285100\\5789.000000\\5790.000000\\5790.000000\\5789.000000\\1856.000000\\1343285040\\5789.000000\\5789.000000\\5790.000000\\5788.000000\\2498.000000\\1343284980\\5789.000000\\5789.000000\\5790.000000\\5788.000000\\1130.000000\\1343284920\\5790.000000\\5788.000000\\5790.000000\\5788.000000\\716.000000\\1343284860\\5789.000000\\5790.000000\\5791.000000\\5789.000000\\796.000000\\1343284800\\5789.000000\\5789.000000\\5790.000000\\5788.000000\\1304.000000\\1343284740\\5790.000000\\5789.000000\\5790.000000\\5789.000000\\1372.000000\\1343284680\\5790.000000\\5790.000000\\5791.000000\\5789.000000\\1266.000000\\1343284620\\5791.000000\\5790.000000\\5792.000000\\5790.000000\\1128.000000\\1343284560\\5792.000000\\5792.000000\\5793.000000\\5791.000000\\1692.000000\\1343284500\\5792.000000\\5792.000000\\5793.000000\\5791.000000\\304.000000\\1343284440\\5789.000000\\5791.000000\\5793.000000\\5789.000000\\610.000000\\1343284380\\5793.000000\\5789.000000\\5794.000000\\5789.000000\\1182.000000\\1343284320\\5794.000000\\5793.000000\\5795.000000\\5793.000000\\1752.000000\\1343284260\\5797.000000\\5795.000000\\5797.000000\\5794.000000\\730.000000\\1343284200\\5799.000000\\5797.000000\\5799.000000\\5797.000000\\838.000000\\1343284140\\5798.000000\\5798.000000\\5800.000000\\5798.000000\\726.000000\\1343284080\\5799.000000\\5798.000000\\5800.000000\\5798.000000\\1688.000000\\1343284020\\5798.000000\\5799.000000\\5799.000000\\5797.000000\\1790.000000\\1343283960\\5798.000000\\5798.000000\\5799.000000\\5797.000000\\1536.000000\\1343283900\\5798.000000\\5798.000000\\5799.000000\\5798.000000\\742.000000\\1343283840\\5799.000000\\5798.000000\\5799.000000\\5798.000000\\1468.000000\\1343283780\\5799.000000\\5799.000000\\5800.000000\\5798.000000\\1936.000000\\1343283720\\5800.000000\\5800.000000\\5800.000000\\5799.000000\\1262.000000\\1343283660\\5799.000000\\5800.000000\\5800.000000\\5799.000000\\7396.000000\\1343283600\\5799.000000\\5799.000000\\5800.000000\\5799.000000\\5654.000000\\1343283540\\5799.000000\\5800.000000\\5800.000000\\5798.000000\\5190.000000\\1343283480\\5798.000000\\5799.000000\\5800.000000\\5797.000000\\3100.000000\\1343283420\\5798.000000\\5798.000000\\5799.000000\\5797.000000\\1926.000000\\1343283360\\5797.000000\\5798.000000\\5798.000000\\5797.000000\\1150.000000\\1343283300\\5798.000000\\5797.000000\\5799.000000\\5797.000000\\768.000000\\1343283240\\5798.000000\\5798.000000\\5799.000000\\5798.000000\\2092.000000\\1343283180\\5798.000000\\5798.000000\\5799.000000\\5798.000000\\2004.000000\\1343283120\\5799.000000\\5798.000000\\5799.000000\\5797.000000\\2188.000000\\1343283060\\5798.000000\\5798.000000\\5799.000000\\5798.000000\\890.000000\\1343283000\\5799.000000\\5798.000000\\5800.000000\\5798.000000\\2432.000000\\1343282940\\5799.000000\\5799.000000\\5800.000000\\5798.000000\\3396.000000\\1343282880\\5798.000000\\5799.000000\\5799.000000\\5797.000000\\2240.000000\\1343282820\\5798.000000\\5797.000000\\5798.000000\\5796.000000\\1622.000000\\1343282760\\5794.000000\\5797.000000\\5798.000000\\5794.000000\\2196.000000\\1343282700\\5793.000000\\5794.000000\\5795.000000\\5793.000000\\5550.000000\\1343282640\\5793.000000\\5794.000000\\5794.000000\\5793.000000\\2696.000000\\1343282580\\5790.000000\\5792.000000\\5792.000000\\5790.000000\\3370.000000\\1343282520\\5790.000000\\5790.000000\\5791.000000\\5790.000000\\2408.000000\\1343282460\\5791.000000\\5791.000000\\5791.000000\\5789.000000\\3394.000000\\1343282340\\5790.000000\\5791.000000\\5792.000000\\5789.000000\\3028.000000\\1343282280\\5789.000000\\5789.000000\\5790.000000\\5789.000000\\534.000000\\1343282220\\5789.000000\\5789.000000\\5790.000000\\5788.000000\\168.000000\\1343282160\\5789.000000\\5789.000000\\5790.000000\\5788.000000\\374.000000\\1343282100\\5790.000000\\5789.000000\\5790.000000\\5789.000000\\166.000000\\1343282040\\5787.000000\\5789.000000\\5789.000000\\5787.000000\\788.000000\\1343281980\\5789.000000\\5788.000000\\5789.000000\\5788.000000\\422.000000\\1343281920\\5788.000000\\5788.000000\\5788.000000\\5788.000000\\92.000000\\1343281860\\5790.000000\\5789.000000\\5790.000000\\5788.000000\\98.000000\\1343281800\\5792.000000\\5790.000000\\5793.000000\\5790.000000\\542.000000\\1343281740\\5792.000000\\5792.000000\\5793.000000\\5792.000000\\532.000000\\";
            
            NSString *newMessage2 = strings;//[[NSString alloc] initWithData:data encoding:NSUTF16BigEndianStringEncoding];
            
            //              NSLog(@"第%d次的数据为\n==%@",count++,newMessage2);       
            
            NSArray   *arr = [newMessage2 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\\"]];
            datas =[[NSMutableArray alloc] init];
            NSMutableArray *newData =[[NSMutableArray alloc] init];
            
            NSMutableArray *allData =[[NSMutableArray alloc] init];
            NSMutableArray *category =[[NSMutableArray alloc] init];
            
            for (int i = 4; i<[arr count]; i++) 
            {
                NSString * lines = [arr objectAtIndex:i];
                [allData addObject:lines];
                if ([allData count]%6==0) {
                    
                    NSString * str = [allData objectAtIndex:0];
                    NSString * str1= [allData objectAtIndex:1];
                    NSString * str2= [allData objectAtIndex:2];
                    NSString * str3= [allData objectAtIndex:3];
                    NSString * str4= [allData objectAtIndex:4];
                    NSString * str5= [allData objectAtIndex:5];
                    
                    NSString * str6 = [NSString  stringWithFormat:@"%@,%@,%@,%@,%@,%@",str,str1,str2,str3,str4,str5];  
                    [newData addObject:str6];
                    [allData removeAllObjects];
                }
            }
            [newData addObject:@"Date,open,close,higt,low,volum"];
            
            //   NSLog(@"%@ , %d",newData,[newData count]);
            for (int i = [newData count]-1; i>=0; i--) {
                NSString *line = [newData objectAtIndex:i];
                if([line isEqualToString:@""]){
                    //    continue;
                }
                NSArray   *arr = [line componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
                
                NSDate *nd = [NSDate dateWithTimeIntervalSince1970:[[arr objectAtIndex:0] intValue]];
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"MM-dd HH:mm"];
                NSString *dateString = [dateFormat stringFromDate:nd];   
                
                [category addObject:dateString];
                
                NSMutableArray *item =[[NSMutableArray alloc] init];
                //    //所有数据 DATE,OPEN,HIGH LOW CLOSE VOLUME ADJ CLOSE
                
                [item addObject:[arr objectAtIndex:1]];//open
                [item addObject:[arr objectAtIndex:2]];//CLOSE
                [item addObject:[arr objectAtIndex:3]];//HIGH
                [item addObject:[arr objectAtIndex:4]];//LOW
                [item addObject:[arr objectAtIndex:5]];//volume
                [datas addObject:item];
            }
            //   NSLog(@"data = %@,data = %d",datas,[datas count]);
            if (datas.count>5) {
                
                self.viewHUB.hidden = YES;
                self.viewBack.hidden = YES;
                [self.activity stopAnimating];
                self.imageBack.hidden =YES ;
                self.backButton.hidden =YES;
                
                self.viewHUB = nil;
                self.viewBack = nil;
                self.imageBack = nil;
                self.backButton = nil;
                [self.activity stopAnimating];//风火轮停止
                
            }
            if(datas.count==0){
                UIAlertView * alertV = [[UIAlertView alloc] initWithTitle:@"服务器数据=0!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"重试",@"首页", nil];
                alertV.tag = 1000;
                [alertV show];
                //                return;
            }
            
            if (chartMode == 0) {
                if([self.req_type isEqualToString:@"T"]){
                    if(self.timer != nil)
                        [self.timer invalidate];
                    [self.candleChart reset];
                    [self.hcandleChart reset];
                    
                    [self.candleChart clearData];
                    [self.hcandleChart clearData];
                    
                    [self.candleChart clearCategory];
                    [self.hcandleChart clearCategory];
                    
                    
                    if([self.req_freq hasSuffix:@"m"]){
                        self.req_type = @"L";
                    }
                }else{
                    
                    NSString *time = [category objectAtIndex:0];
                    
                    if([time isEqualToString:self.lastTime]){
                        
                        if([time hasSuffix:@"1500"]){
                            if(self.timer != nil)
                                [self.timer invalidate];
                        }
                        return;
                    }
                    
                    
                    
                    if ([time hasSuffix:@"1130"] || [time hasSuffix:@"1500"]) {
                        if(self.tradeStatus == 1){
                            self.tradeStatus = 0;
                        }
                    }else{
                        self.tradeStatus = 1;
                    }
                }
            }else{
                if(self.timer != nil)
                    [self.timer invalidate];
                [self.candleChart reset];
                [self.candleChart clearData];
                [self.candleChart clearCategory];
                
                [self.hcandleChart reset];
                [self.hcandleChart clearData];
                [self.hcandleChart clearCategory];
            }
            
            self.lastTime = [category lastObject];
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [self generateData:dic From:datas];
            [self setData:dic];
            // NSLog(@"dic = %d",datas.count);
            
            
            if(chartMode == 0){
                [self setCategory:category];
            }else{
                NSMutableArray *cate = [[NSMutableArray alloc] init];
                for(int i=60;i<category.count;i++){
                    [cate addObject:[category objectAtIndex:i]];
                }
                [self setCategory:cate];
            }
            [self.candleChart setNeedsDisplay];
            [self.hcandleChart setNeedsDisplay];
        }
    }
}
#pragma mark -————————————————————————————————————————————————————————————
#pragma mark - 技术指标
#pragma mark - EMA 
-(void)ema:(NSMutableDictionary *)dic From:(NSArray *)data
{
    //    self.periodEma = 10;
    
    //************* EMA *********************************************************************************************************************
    NSMutableArray *emaArray = [[NSMutableArray alloc] init];
    float ema = 0.0;
    float K =  2.0/(1.0 + [[self.allProiod objectAtIndex:2] intValue]);
    
    for (int i = 60; i<data.count; i++) {
        
        if(i == 60){
            float sma = 0.0;
            for(int j=i;j<i+[[self.allProiod objectAtIndex:2] intValue];j++){
                sma += [[[data objectAtIndex:j] objectAtIndex:1] floatValue];
            }
            ema = sma / [[self.allProiod objectAtIndex:2] intValue];
        }
        else {
            float point =  [[[data objectAtIndex:i] objectAtIndex:1] floatValue];
            ema = point * K + ema * (1.0 - K);
        }
        
        
        NSMutableArray *item = [[NSMutableArray alloc] init];
        [item addObject:[@"" stringByAppendingFormat:@"%f",ema]];
        [emaArray addObject:item];
    }
    [dic setObject:emaArray forKey:@"ema"];//ma10
}

#pragma mark - SMA
-(void)sma:(NSMutableDictionary *)dic From:(NSArray *)data
{
    //    self.periodSma = 10;
    NSMutableArray *sma = [[NSMutableArray alloc] init];
    for(int i = 60;i < data.count;i++){
        float val = 0;
        for(int j=i;j>i-[[self.allProiod objectAtIndex:0] intValue];j--){
            val += [[[data objectAtIndex:j] objectAtIndex:1] floatValue];
        }
        val = val/[[self.allProiod objectAtIndex:0] intValue];
        NSMutableArray *item = [[NSMutableArray alloc] init];
        [item addObject:[@"" stringByAppendingFormat:@"%f",val]];
        [sma addObject:item];
        [item release];
    }
    [dic setObject:sma forKey:@"sma"];//ma30
    
    
}

#pragma mark - WMA
-(void)wma:(NSMutableDictionary *)dic From:(NSArray *)data
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    NSMutableArray *arrayWMA = [[NSMutableArray alloc] init];
    
    
    //    int size =data.count;
    
    float sum = 0.0, lsum = 0.0;
    float prices;
    int i;
    int weight = 0;
    
    //    self.periodWma = 10;
    int pos = data.count  - 1;
    
    
    
    for (i = 1; i <=[[self.allProiod objectAtIndex:1] intValue]; i++, pos--) {
        prices = [[[data objectAtIndex:pos] objectAtIndex:1] floatValue];
        sum += prices * i;
        lsum += prices;
        weight += i;
    }
    // ---- main calculation loop
    pos++;
    i = pos + [[self.allProiod objectAtIndex:1] intValue];
    while (pos >= 0) {
        [results addObject: [NSNumber numberWithFloat: (sum/weight)] ];
        if (pos == 0)
            break;
        pos--;
        i--;
        prices = [[[data objectAtIndex:pos] objectAtIndex:1] floatValue];
        sum = sum - lsum + prices * [[self.allProiod objectAtIndex:1] intValue];
        lsum -=[[[data objectAtIndex:i] objectAtIndex:1] floatValue];
        lsum += prices;
    }
    
    
    for(i=[results count]-1;i>50;i--){
        
        NSMutableArray *item = [[NSMutableArray alloc] init];
        [item addObject:[@"" stringByAppendingFormat:@"%f",[[results objectAtIndex:i] floatValue]]];
        [arrayWMA addObject:item];
        
        
    }
    
    [dic setObject:arrayWMA forKey:@"wma"];
    
}

#pragma mark - KDJ
-(void)kdj:(NSMutableDictionary *)dic From:(NSArray *)data
{
    
    
    NSMutableArray *kdj_k = [[NSMutableArray alloc] init];
    NSMutableArray *kdj_d = [[NSMutableArray alloc] init];
    NSMutableArray *kdj_j = [[NSMutableArray alloc] init];
    float prev_k = [[self.allProiod objectAtIndex:9] intValue];
    float prev_d = [[self.allProiod objectAtIndex:10] intValue];
    float rsv = 0;
    for(int i = 60;i < data.count;i++){
        float h  =[[[data objectAtIndex:i] objectAtIndex:2] floatValue];
        float l = [[[data objectAtIndex:i] objectAtIndex:3] floatValue];
        float c = [[[data objectAtIndex:i] objectAtIndex:1] floatValue];
        for(int j=i;j>i-10;j--){
            if([[[data objectAtIndex:j] objectAtIndex:2] floatValue] > h){
                h = [[[data objectAtIndex:j] objectAtIndex:2] floatValue];
            }
            
            if([[[data objectAtIndex:j] objectAtIndex:3] floatValue] < l){
                l = [[[data objectAtIndex:j] objectAtIndex:3] floatValue];
            }
        }
        
        if(h!=l)
            rsv = (c-l)/(h-l)*100;
        float k = 2*prev_k/3+1*rsv/3;
        float d = 2*prev_d/3+1*k/3;
        float j = d+2*(d-k);
        
        prev_k = k;
        prev_d = d;
        
        NSMutableArray *itemK = [[NSMutableArray alloc] init];
        [itemK addObject:[@"" stringByAppendingFormat:@"%f",k]];
        [kdj_k addObject:itemK];
        [itemK release];
        NSMutableArray *itemD = [[NSMutableArray alloc] init];
        [itemD addObject:[@"" stringByAppendingFormat:@"%f",d]];
        [kdj_d addObject:itemD];
        [itemD release];
        NSMutableArray *itemJ = [[NSMutableArray alloc] init];
        [itemJ addObject:[@"" stringByAppendingFormat:@"%f",j]];
        [kdj_j addObject:itemJ];
        [itemJ release];
    }
    [dic setObject:kdj_k forKey:@"kdj_k"];
    [dic setObject:kdj_d forKey:@"kdj_d"];
    [dic setObject:kdj_j forKey:@"kdj_j"];
    
}

#pragma mark - BOLL
-(void)boll:(NSMutableDictionary *)dic From:(NSArray *)data
{
    //************* BOLL *********************************************************************************************************************
    //    self.periodBoll =10;
    
    
    
    NSMutableArray *bollArray_upper = [[NSMutableArray alloc] init];
    NSMutableArray *bollArray_value = [[NSMutableArray alloc] init];
    NSMutableArray *bollArray_lower = [[NSMutableArray alloc] init]; 
    
    NSMutableArray *sma = [[NSMutableArray alloc] init];
    for(int i = 60;i < data.count;i++){
        float val = 0;
        for(int j=i;j>i-[[self.allProiod objectAtIndex:3] intValue];j--){
            val += [[[data objectAtIndex:j] objectAtIndex:1] floatValue];
        }
        val = val/[[self.allProiod objectAtIndex:3] intValue];
        NSMutableArray *item = [[NSMutableArray alloc] init];
        [item addObject:[@"" stringByAppendingFormat:@"%f",val]];
        [sma addObject:item];
    }
    
    for (int i = 0; i<[sma count]; i++) {
        
        float sum = 0.0;
        int k = i + [[self.allProiod objectAtIndex:3] intValue] - 1;
        float value = [[[sma objectAtIndex:i] objectAtIndex:0] floatValue];
        
        while (k >= i) {
            float newres = [[[data objectAtIndex:k] objectAtIndex:1] floatValue] - value;
            sum += newres * newres;
            k--;
        }
        float deviation = 2.0 * sqrt(sum / [[self.allProiod objectAtIndex:3] intValue]);
        
        float lower = value - deviation;
        float upper = value + deviation;
        
        
        NSMutableArray *itemU = [[NSMutableArray alloc] init];
        [itemU addObject:[@"" stringByAppendingFormat:@"%f",upper]];
        [bollArray_upper addObject:itemU];
        
        NSMutableArray *itemV = [[NSMutableArray alloc] init];
        [itemV addObject:[@"" stringByAppendingFormat:@"%f",value]];
        [bollArray_value addObject:itemV];
        
        NSMutableArray *itemL = [[NSMutableArray alloc] init];
        [itemL addObject:[@"" stringByAppendingFormat:@"%f",lower]];
        [bollArray_lower addObject:itemL];
        
        
    }
    [dic setObject:bollArray_upper forKey:@"boll_upper"];
    [dic setObject:bollArray_value forKey:@"boll_value"];
    [dic setObject:bollArray_lower forKey:@"boll_lower"];
    
}

#pragma mark - RSI-6
-(void)rsi6:(NSMutableDictionary *)dic From:(NSArray *)data
{
    
    
    //RSI6
    NSMutableArray *rsi6 = [[NSMutableArray alloc] init];
    for(int i = 60;i < data.count;i++){
        float incVal  = 0;
        float decVal = 0;
        float rs = 0;
        for(int j=i;j>i-[[self.allProiod objectAtIndex:5] intValue];j--){
            float interval = [[[data objectAtIndex:j] objectAtIndex:1] floatValue]-[[[data objectAtIndex:j] objectAtIndex:0] floatValue];
            if(interval >= 0){
                incVal += interval;
            }else{
                decVal -= interval;
            }
        }
        
        rs = incVal/decVal;
        float rsi =100-100/(1+rs);
        
        NSMutableArray *item = [[NSMutableArray alloc] init];
        [item addObject:[@"" stringByAppendingFormat:@"%f",rsi]];
        [rsi6 addObject:item];
        
    }
    [dic setObject:rsi6 forKey:@"rsi6"];
    NSLog(@"[[self.allProiod objectAtIndex:1] intValue]  = %d",[[self.allProiod objectAtIndex:5] intValue]);
    
}

#pragma mark - ADX
-(void)adx:(NSMutableDictionary *)dic From:(NSArray *)data//
{
    
    //    self.periodAdx = 10;
    
    
    //    int size  = [data count];
    
    float dx[data.count];
    float adx[data.count];
    
    //*** Calculate DM+ / DM-
    float dmPos[data.count];
    float dmNeg[data.count];
    
    for(int i = 0;i < data.count-1;i++){
    	
        //    	StockPoint p1 = srcSeries.Points.get(i);
        //    	StockPoint p2 = srcSeries.Points.get(i+1);
    	
        //    	float deltaHigh = (float)(p1.High - p2.High);
        float deltaHigh = [[[data objectAtIndex:i] objectAtIndex:3] floatValue] - [[[data objectAtIndex:i+1] objectAtIndex:3] floatValue];
        //    	float deltaLow = (float)(p2.Low - p1.Low);
        float deltaLow = [[[data objectAtIndex:i+1] objectAtIndex:4] floatValue] - [[[data objectAtIndex:i] objectAtIndex:4] floatValue];
    	if ( (deltaHigh<0 && deltaLow<0) || (deltaHigh == deltaLow) ) {      
            dmPos[i] = 0;      
        	dmNeg[i] = 0;    
        	
        }
    	else if ( deltaHigh > deltaLow )    {      
            dmPos[i] = deltaHigh;      
            dmNeg[i] = 0;    
        }    
    	else if ( deltaLow > deltaHigh )    
        {      
        	dmPos[i] = 0;      
        	dmNeg[i] = deltaLow;    
        }
    }
    
    //### Calculate ATR
    //    float[] tr = new float[data.count];
    float tr[data.count];
    //    Float[] atr = new Float[data.count];
    float atr[data.count];
    for (int i=0; i<data.count-2; i++)   {  
        //    	StockPoint p1 = srcSeries.Points.get(i);
        //    	StockPoint p2 = srcSeries.Points.get(i+1);
        //    	
        //    	float r1 = (float) Math.abs( p1.High - p1.Low ); 
        float r1 = abs([[[data objectAtIndex:i] objectAtIndex:3] floatValue]-[[[data objectAtIndex:i] objectAtIndex:4] floatValue]);
        //    	float r2 = (float) Math.abs( p1.High - p2.Close );    
        float r2 = abs([[[data objectAtIndex:i] objectAtIndex:3]floatValue] - [[[data objectAtIndex:i+1] objectAtIndex:2] floatValue]);
        //    	float r3 = (float) Math.abs( p1.Low - p2.Close );
        float r3 = abs([[[data objectAtIndex:i] objectAtIndex:4] floatValue]- [[[data objectAtIndex:i+1] objectAtIndex:2] floatValue]);
        
    	//find the greatest among three
    	float max1 = MAX(r1, r2);  
    	tr[i] = MAX(max1, r3);
    }
    
    
    
    for (int i=data.count-[[self.allProiod objectAtIndex:14] intValue]-2; i>=0; i--)   {    
    	float total = 0;    
    	for (int x=0; x<[[self.allProiod objectAtIndex:14] intValue]; x++)     {      
            total = total + tr[i+x];    
    	}    
    	if (i == data.count-[[self.allProiod objectAtIndex:14] intValue]-2) {
            //# first ATR      
            atr[i] = total / [[self.allProiod objectAtIndex:14] intValue];    
    	}    
    	else     {      
            atr[i] = ( (atr[i+1]*([[self.allProiod objectAtIndex:14] intValue]-1)) + tr[i] ) / [[self.allProiod objectAtIndex:14] intValue];    
    	}  
    }
    
    //*** Calculate ADM+ / ADM-
    //    float[] admPos = new float[data.count];
    //    float[] admNeg = new float[data.count];
    float admPos[data.count];
    float admNeg[data.count];
    
    for (int i=data.count-[[self.allProiod objectAtIndex:14] intValue]-1; i>=0; i--)    {        
      	if (i == data.count-[[self.allProiod objectAtIndex:14] intValue]-1) {      
            float totalPos = 0;      
            float totalNeg = 0;      
            for (int c=0; c<[[self.allProiod objectAtIndex:14] intValue]; c++)      {        
                totalPos = totalPos + dmPos[i+c];      
                totalNeg = totalNeg + dmNeg[i+c];      
            }
            
            admPos[i] = totalPos / [[self.allProiod objectAtIndex:14] intValue];      
            admNeg[i] = totalNeg / [[self.allProiod objectAtIndex:14] intValue];        
      	}    
      	else    {      
            admPos[i] = ((admPos[i+1]*([[self.allProiod objectAtIndex:14] intValue]-1))+dmPos[i]) / [[self.allProiod objectAtIndex:14] intValue];      
            admNeg[i] = ( (admNeg[i+1] * ([[self.allProiod objectAtIndex:14] intValue]-1)) + dmNeg[i]) / [[self.allProiod objectAtIndex:14] intValue];    
      	}
        
        //### Calculate DI+/DI-        
        
        //      	float[] diPos = new float[data.count];
        //        float[] diNeg = new float[data.count];
        float diPos[data.count];
        float diNeg[data.count];
        
        if ( atr[i] != 0)        {          
        	diPos[i] = ( admPos[i] / atr[i] ) * 100;          
        	diNeg[i] = ( admNeg[i] / atr[i] ) * 100;
            
            //### Calculate DX          
            
            if ( diPos[i] != 0   &&  diPos[i] != 0 )          {            
            	dx[i] = 100 * (abs(diPos[i] - diNeg[i]) ) / (diPos[i] + diNeg[i]);          
            }        
        }
        
    }
    
    
    //### Calculate ADX  
    
    for (int i=data.count-[[self.allProiod objectAtIndex:14] intValue]; i>=0; i--)  {    
    	if (i==data.count-[[self.allProiod objectAtIndex:14] intValue]  ||  (adx[i+1] == 0) )    {      
            float total = 0;      
            for (int c=0; c<[[self.allProiod objectAtIndex:14] intValue]; c++)      {        
                if ( dx[i]!=0 ) {          
                    total = total + dx[i];        
                }        
                else {          
                    break;        
                }        
                adx[i] = total / [[self.allProiod objectAtIndex:14] intValue];      
            }  
    	}  
    	else    {      
            adx[i] = ( (adx[i+1]*([[self.allProiod objectAtIndex:14] intValue]-1)) + dx[i] ) / [[self.allProiod objectAtIndex:14] intValue];    
    	}  
    	
    	
    	
    }
    
    
    NSMutableArray * adxArray = [[NSMutableArray alloc] init];
    
    for(int i=data.count-[[self.allProiod objectAtIndex:14] intValue]-2; i>50; i--){
        //                if(adx[i] != null){
        //                    dstSeries.addPoint(adx[i]);
        //                }
        if(adx[i] != 0){
            NSMutableArray *item = [[NSMutableArray alloc] init];
            [item addObject:[@"" stringByAppendingFormat:@"%f",adx[i]]];
            [adxArray addObject:item];
        }
        
    }
    [dic setObject:adxArray forKey:@"adx"];
    
}

#pragma mark - CCI
-(void)cci:(NSMutableDictionary *)dic From:(NSArray *)data
{
    //    NSLog(@"%@",data);
    //    NSLog(@"higt = %f",[[[data objectAtIndex:1]objectAtIndex:1] floatValue]);
    //    self.periodCci = 10;
    
    //    int size = [data count];
    
    //    Float[] cci = new Float[data.count];
    float cci[data.count];
    //    Float[] ma = new Float[data.count];
    float ma[data.count];
    float  sums = 0.0;
    
    
    
    for(int i = 0; i < [[self.allProiod objectAtIndex:12] intValue] - 1; i++){
        //        StockPoint p = (StockPoint)Src.getPointAt(i);
        //        sum += (p.High + p.Low + p.Close) / 3F;
        sums +=([[[data objectAtIndex:i] objectAtIndex:3] floatValue]+[[[data objectAtIndex:i] objectAtIndex:4] floatValue]+[[[data objectAtIndex:i] objectAtIndex:2] floatValue])/3;
    }
    
    float prec = 0.0;
    for(int i = [[self.allProiod objectAtIndex:12] intValue] - 1; i < data.count; i++) {
        //        StockPoint p = (StockPoint)Src.getPointAt(i);
        sums -= prec;
        //        sum += (p.High + p.Low + p.Close) / 3F;
        sums += ([[[data objectAtIndex:i] objectAtIndex:3] floatValue]+[[[data objectAtIndex:i] objectAtIndex:4] floatValue]+[[[data objectAtIndex:i] objectAtIndex:2] floatValue]) /3;
        ma[i] = (float)(sums /[[self.allProiod objectAtIndex:12] intValue]);
        
        //        StockPoint p2 = (StockPoint)Src.getPointAt((i - period) + 1);
        //        prec = (float)(p2.High + p2.Low + p2.Close) / 3F;
        prec = ([[[data objectAtIndex:i-[[self.allProiod objectAtIndex:12] intValue]+1] objectAtIndex:3] floatValue]+[[[data objectAtIndex:i-[[self.allProiod objectAtIndex:12] intValue]+1] objectAtIndex:4] floatValue]+[[[data objectAtIndex:i-[[self.allProiod objectAtIndex:12] intValue]+1] objectAtIndex:2] floatValue])/3;
    }
    
    cci[[[self.allProiod objectAtIndex:12] intValue] - 2] = 0.0;
    for(int i = [[self.allProiod objectAtIndex:12] intValue] - 1; i < data.count; i++) {
        sums = 0.0;
        for(int j = (i - [[self.allProiod objectAtIndex:12] intValue]) + 1; j <= i; j++){
            //            StockPoint p = (StockPoint)Src.getPointAt(j);
            //            sum += Math.abs((p.High + p.Low + p.Close) / 3F - ma[i]);
            sums += abs(([[[data objectAtIndex:j] objectAtIndex:3] floatValue]+[[[data objectAtIndex:j] objectAtIndex:4] floatValue]+[[[data objectAtIndex:j] objectAtIndex:2] floatValue]) /3 - ma[i]);
        }
        
        if(sums == 0.0)
            cci[i] = cci[i - 1];
        else{
            //            NSLog(@"sums != 0");
            cci[i] = (([[[data objectAtIndex:i] objectAtIndex:3] floatValue]+[[[data objectAtIndex:i] objectAtIndex:4] floatValue]+[[[data objectAtIndex:i] objectAtIndex:2] floatValue]) / 3 - ma[i]) / ((0.014999999999999999 * sums)/(float)[[self.allProiod objectAtIndex:12] intValue]);
        }
    }
    NSMutableArray *cciArray = [[NSMutableArray alloc] init];
    
    
    for(int i=data.count-60; i>0; i--){
        if(cci[i] != 0){
            NSMutableArray *item = [[NSMutableArray alloc] init];
            [item addObject:[@"" stringByAppendingFormat:@"%f",cci[i]]];
            [cciArray addObject:item];
            //        NSLog(@"%f",cci[i]);        
        }
        
        [dic setObject:cciArray forKey:@"cci"];
        
    }
}


#pragma mark - MACD
-(void)macd:(NSMutableDictionary *)dic From:(NSArray *)data//三条线
{
    //    [NSString stringWithFormat:@"%d",self.periodSma],
    //    [NSString stringWithFormat:@"%d",self.periodWma],
    //    [NSString stringWithFormat:@"%d",self.periodEma],
    //    [NSString stringWithFormat:@"%d",self.periodBoll],
    //    [NSString stringWithFormat:@"%.f",self.bandDeviation],
    //    [NSString stringWithFormat:@"%d",self.periodRsi],
    //    [NSString stringWithFormat:@"%d",self.periodMacd],
    //    [NSString stringWithFormat:@"%d",self.longMacdPeriod],
    //    [NSString stringWithFormat:@"%d",self.shortMacdPeriod],
    //    [NSString stringWithFormat:@"%d",self.kPeriod],
    //    [NSString stringWithFormat:@"%d",self.dPeriod],
    //    [NSString stringWithFormat:@"%d",self.jPeriod],
    //    [NSString stringWithFormat:@"%d",self.periodCci],
    //    [NSString stringWithFormat:@"%d",self.periodMom],
    //    [NSString stringWithFormat:@"%d",self.periodAdx], nil];
    
    
    //************* EMA *********************************************************************************************************************
    NSMutableArray * ShortEma =[[NSMutableArray alloc] init];
    
    //    self.ShortperiodEma = 12;
    
    float ema = 0.0;
    
    float K =  2.0/(1.0 + [[self.allProiod objectAtIndex:8] intValue]);
    
    for (int i = 60; i<data.count; i++) {
        
        if(i == 60){
            float sma = 0.0;
            for(int j=i;j<i+[[self.allProiod objectAtIndex:8] intValue];j++){
                sma += [[[data objectAtIndex:j] objectAtIndex:1] floatValue];
            }
            ema = sma / [[self.allProiod objectAtIndex:8] intValue];
        }
        else {
            float point =  [[[data objectAtIndex:i] objectAtIndex:1] floatValue];
            ema = point * K + ema * (1.0 - K);
            
        }
        NSMutableArray *item = [[NSMutableArray alloc] init];
        [item addObject:[@"" stringByAppendingFormat:@"%f",ema]];
        [ShortEma addObject:item];
        
        
    }
    
    //************* EMA *********************************************************************************************************************
    NSMutableArray * LongEma =[[NSMutableArray alloc] init];
    
    //    self.LongperiodEma = 26;
    float ema1 = 0.0;
    
    float K1 =  2.0/(1.0 + [[self.allProiod objectAtIndex:7] intValue]);
    
    for (int i = 60; i<data.count; i++) {
        
        if(i == 60){
            float sma = 0.0;
            for(int j=i;j<i+[[self.allProiod objectAtIndex:7] intValue];j++){
                sma += [[[data objectAtIndex:j] objectAtIndex:1] floatValue];
            }
            ema1 = sma / [[self.allProiod objectAtIndex:7] intValue];
        }
        else {
            float point =  [[[data objectAtIndex:i] objectAtIndex:1] floatValue];
            ema1 = point * K + ema1 * (1.0 - K1);
            
        }
        NSMutableArray *item = [[NSMutableArray alloc] init];
        [item addObject:[@"" stringByAppendingFormat:@"%f",ema]];
        [LongEma addObject:item];
    }
    //************* SignaEMA *********************************************************************************************************************
    
    
    
    
    
    //    float fLongEma = ema10;
    //    float fShortEma = ema30;
    //    float fSignalEma = ema60;
    //    
    //    int valueIndex = 0;
    //
    //    int dstMacd = 0;
    //
    //    int dstSignal = 0;
    //    
    //    int dstHistorgram = 0;
    //    
    //    int LongMacdPeriod;
    //    int ShortMacdPeriod;
    //    int SignalPeriod;
    
    
    //        public MacdIndicator(SeriesBase src, int valueIndex, LinearSeries dstMacd,LinearSeries dstSignal,BarSeries dstHistogram,int longMacdPeriod,int shortMacdPeriod, int signalPeriod)
    //        {
    //            super(src,valueIndex);
    //            DstMacd = dstMacd;
    //            DstSignal = dstSignal;
    //            DstHistogram = dstHistogram;
    //            LongMacdPeriod = longMacdPeriod;
    //            ShortMacdPeriod = shortMacdPeriod;
    //            SignalPeriod = signalPeriod;
    //            fLongEma = new EmaIndicator(src,valueIndex,null,longMacdPeriod);
    //            fShortEma = new EmaIndicator(src,valueIndex,null,shortMacdPeriod);
    //            fSignalEma = new EmaIndicator(DstMacd,0,null,signalPeriod);
    //        }
    //        public final LinearSeries DstMacd;
    //        public final LinearSeries DstSignal;
    //        public final BarSeries DstHistogram;
    //        public int LongMacdPeriod;
    //        public int ShortMacdPeriod;
    //        public int SignalPeriod;
    //        
    //        @Override
    //        public void recalc()
    //        {	
    //            this.prepareDst(DstMacd, LongMacdPeriod);
    //            this.prepareDst(DstSignal, LongMacdPeriod + SignalPeriod - 1);
    //            this.prepareDst(DstHistogram, LongMacdPeriod + SignalPeriod - 1);
    //            fLongEma.PeriodsCount = LongMacdPeriod;
    //            EmaIterator longIterator  = fLongEma.iterator();
    //            fShortEma.PeriodsCount = ShortMacdPeriod;
    //            EmaIterator shortIterator = fShortEma.iterator();
    //            
    //            int i = ShortMacdPeriod;10
    //            while(shortIterator.hasNext())
    //            {
    //                double shortMacd = shortIterator.getNext();
    //                if(i >= LongMacdPeriod)
    //                {
    //                    if(!longIterator.hasNext()) return;
    //                    double longMacd = longIterator.getNext();
    //                    DstMacd.addPoint(shortMacd - longMacd);
    //                }
    //                i++;
    //      }
    
    //dif
    NSMutableArray *DifMcad = [[NSMutableArray alloc] init];
    int i = self.ShortperiodEma;
    
    for (int j = 0; j <[ShortEma count]; j++) {
        float shortMacd = [[[ShortEma objectAtIndex:j] objectAtIndex:0]floatValue]-[[[LongEma objectAtIndex:j] objectAtIndex:0]floatValue];
        
        //        if (i>=LongperiodEma) {
        //            float longMacd = [[LongEma objectAtIndex:j] floatValue];
        //            float dst = shortMacd - longMacd;
        NSMutableArray *item = [[NSMutableArray alloc] init];
        [item addObject:[@"" stringByAppendingFormat:@"%f",shortMacd]];
        [DifMcad addObject:item];
        //    }
        
        i++;
    }
    
    [dic setObject:DifMcad forKey:@"macd"];
    //    NSLog(@"DifMcad = %d",DifMcad.count);
    
    
    
    self.SignaperiodEma = [[self.allProiod objectAtIndex:6] intValue];
    float ema2 = 0.0;
    
    NSMutableArray * dea =[[NSMutableArray alloc] init];
    float K2 =  2.0/(1.0 + [[self.allProiod objectAtIndex:6] intValue]);
    
    for (int i = 0; i<DifMcad.count; i++) {
        
        if(i == 0){
            float sma = 0.0;
            for(int j=i;j<i+[[self.allProiod objectAtIndex:6] intValue];j++){
                sma += [[[data objectAtIndex:j] objectAtIndex:1] floatValue];
            }
            ema2 = sma / [[self.allProiod objectAtIndex:6] intValue];
            
        }
        else {
            float point =  [[[data objectAtIndex:i] objectAtIndex:1] floatValue];
            ema2 = point * K + ema2 * (1.0 - K2);
        }
        NSMutableArray *item = [[NSMutableArray alloc] init];
        [item addObject:[@"" stringByAppendingFormat:@"%f",ema2]];
        [dea addObject:item];
    }
    [dic setObject:dea forKey:@"dea"];
    
    //    NSLog(@"dea = %d",dea.count);
    
    //    
    //    for (int w = 0; w <[DstMcad count]; w++) {
    //        for (int t = 0; t<9; t++) {
    //            float dif =dif + [[DstMcad objectAtIndex:w] floatValue];
    //
    //            dif = dif/9;
    //        }
    //    }
    
    //    for (int s = 0; s <[SignaEma count]; s++) {
    //        float signal = [[SignaEma objectAtIndex:s]floatValue];
    //        
    //    }
    
}


//            fSignalEma.PeriodsCount = SignalPeriod;
//            EmaIterator signalIterator = fSignalEma.iterator();
//            int k = SignalPeriod - 1;
//            while(signalIterator.hasNext())
//            {
//                double signal = signalIterator.getNext();
//                double macd = DstMacd.Points.get(k).Value;
//                DstSignal.addPoint(signal);
//                DstHistogram.addPoint(0.0, macd - signal);
//                k++;
//            }



#pragma mark - MOM
-(void)mom:(NSMutableDictionary *)dic From:(NSArray *)data
{
    
    //************* MOM *********************************************************************************************************************
    NSMutableArray *momArray = [[NSMutableArray alloc] init];
    for(int i = 60;i < data.count-[[self.allProiod objectAtIndex:13] intValue];i++){
        
        
        float close = [[[data objectAtIndex:i] objectAtIndex:1] floatValue];
        float close2 =[[[data objectAtIndex:i+[[self.allProiod objectAtIndex:13] intValue]] objectAtIndex:1] floatValue];
        float mom = close*100/close2;
        
        NSMutableArray *item = [[NSMutableArray alloc] init];
        [item addObject:[@"" stringByAppendingFormat:@"%f",mom]];
        [momArray addObject:item];
    }
    [dic setObject:momArray forKey:@"Mom"];
}
#pragma  mark - 技术指标generateData
-(void)generateData:(NSMutableDictionary *)dic From:(NSArray *)data{
    
	if(self.chartMode == 1){
		//price 
        //        NSLog(@"data  = %@ , data.count = %d",data,data.count);
        
		NSMutableArray *price = [[NSMutableArray alloc] init];
	    for(int i = 60;i < data.count;i++){
			[price addObject: [data objectAtIndex:i]];
		}
		[dic setObject:price forKey:@"price"];
		[price release];
		
		//VOL
		NSMutableArray *vol = [[NSMutableArray alloc] init];
	    for(int i = 60;i < data.count;i++){
			NSMutableArray *item = [[NSMutableArray alloc] init];
			[item addObject:[@"" stringByAppendingFormat:@"%f",[[[data objectAtIndex:i] objectAtIndex:4] floatValue]/100]];
			[vol addObject:item];
			[item release];
		}
		[dic setObject:vol forKey:@"vol"];
		
        [self   ema:dic From:data];
        [self   sma:dic From:data];
        [self   wma:dic From:data];
        [self   kdj:dic From:data];
        [self  boll:dic From:data];
        [self   mom:dic From:data];
        [self  rsi6:dic From:data];
        //        [self rsi12:dic From:data];
        [self  macd:dic From:data];
        [self   cci:dic From:data];
        [self   adx:dic From:data];
        
		
		
		
        //************* WR *********************************************************************************************************************
        
        
        //		NSMutableArray *wr = [[NSMutableArray alloc] init];
        //	    for(int i = 60;i < data.count;i++){
        //			float h  = [[[data objectAtIndex:i] objectAtIndex:2] floatValue];
        //			float l = [[[data objectAtIndex:i] objectAtIndex:3] floatValue];
        //			float c = [[[data objectAtIndex:i] objectAtIndex:1] floatValue];
        //		    for(int j=i;j>i-10;j--){
        //				if([[[data objectAtIndex:j] objectAtIndex:2] floatValue] > h){
        //				    h = [[[data objectAtIndex:j] objectAtIndex:2] floatValue];
        //				}
        //                
        //				if([[[data objectAtIndex:j] objectAtIndex:3] floatValue] < l){
        //					l = [[[data objectAtIndex:j] objectAtIndex:3] floatValue];
        //				}
        //			}
        //			
        //			float val = (h-c)/(h-l)*100;
        //			NSMutableArray *item = [[NSMutableArray alloc] init];
        //			[item addObject:[@"" stringByAppendingFormat:@"%f",val]];
        //			[wr addObject:item];
        //		}
        //		[dic setObject:wr forKey:@"wr"];
        //		
        //    
        //		//VR
        //		NSMutableArray *vr = [[NSMutableArray alloc] init];
        //	    for(int i = 60;i < data.count;i++){
        //			float inc = 0;
        //			float dec = 0;
        //			float eq  = 0;
        //		    for(int j=i;j>i-24;j--){
        //				float o = [[[data objectAtIndex:j] objectAtIndex:0] floatValue];
        //				float c = [[[data objectAtIndex:j] objectAtIndex:1] floatValue];
        //                
        //				if(c > o){
        //				    inc += [[[data objectAtIndex:j] objectAtIndex:4] intValue];
        //				}else if(c < o){
        //				    dec += [[[data objectAtIndex:j] objectAtIndex:4] intValue];
        //				}else{
        //				    eq  += [[[data objectAtIndex:j] objectAtIndex:4] intValue];
        //				}
        //			}
        //			
        //			float val = (inc+1*eq/2)/(dec+1*eq/2);
        //			NSMutableArray *item = [[NSMutableArray alloc] init];
        //			[item addObject:[@"" stringByAppendingFormat:@"%f",val]];
        //			[vr addObject:item];
        //			[item release];
        //		}
        //		[dic setObject:vr forKey:@"vr"];
        
	}else{
		//price 
		NSMutableArray *price = [[NSMutableArray alloc] init];
	    for(int i = 0;i < data.count;i++){
			[price addObject: [data objectAtIndex:i]];
		}
		[dic setObject:price forKey:@"price"];
		[price release];
		
		//VOL
		NSMutableArray *vol = [[NSMutableArray alloc] init];
	    for(int i = 0;i < data.count;i++){
			NSMutableArray *item = [[NSMutableArray alloc] init];
			[item addObject:[@"" stringByAppendingFormat:@"%f",[[[data objectAtIndex:i] objectAtIndex:4] floatValue]/100]];
			[vol addObject:item];
			[item release];
		}
		[dic setObject:vol forKey:@"vol"];
		
	}
}

-(void)setData:(NSDictionary *)dic{
	[self.candleChart appendToData:[dic objectForKey:@"price"] forName:@"price"];
	[self.candleChart appendToData:[dic objectForKey:@"vol"] forName:@"vol"];
	
	[self.candleChart appendToData:[dic objectForKey:@"ema"] forName:@"ema"];
	[self.candleChart appendToData:[dic objectForKey:@"sma"] forName:@"sma"];
	[self.candleChart appendToData:[dic objectForKey:@"wma"] forName:@"wma"];
	
	[self.candleChart appendToData:[dic objectForKey:@"rsi6"] forName:@"rsi6"];
	[self.candleChart appendToData:[dic objectForKey:@"rsi12"] forName:@"rsi12"];
	
    //	[self.candleChart appendToData:[dic objectForKey:@"wr"] forName:@"wr"];
	[self.candleChart appendToData:[dic objectForKey:@"Mom"] forName:@"Mom"];
	
	[self.candleChart appendToData:[dic objectForKey:@"adx"] forName:@"adx"];
	[self.candleChart appendToData:[dic objectForKey:@"cci"] forName:@"cci"];
    [self.candleChart appendToData:[dic objectForKey:@"macd"] forName:@"macd"];
    [self.candleChart appendToData:[dic objectForKey:@"dea"] forName:@"dea"];
    
    
	[self.candleChart appendToData:[dic objectForKey:@"kdj_k"] forName:@"kdj_k"];
	[self.candleChart appendToData:[dic objectForKey:@"kdj_d"] forName:@"kdj_d"];
	[self.candleChart appendToData:[dic objectForKey:@"kdj_j"] forName:@"kdj_j"];
    
    [self.candleChart appendToData:[dic objectForKey:@"boll_upper"] forName:@"boll_upper"];
	[self.candleChart appendToData:[dic objectForKey:@"boll_value"] forName:@"boll_value"];
	[self.candleChart appendToData:[dic objectForKey:@"boll_lower"] forName:@"boll_lower"];
	
	NSMutableDictionary *serie = [self.candleChart getSerie:@"price"];
	if(serie == nil)
		return;
	if(self.chartMode == 1){
		[serie setObject:@"candle" forKey:@"type"];
	}else{
		[serie setObject:@"line" forKey:@"type"];
	}
}

-(void)setCategory:(NSArray *)category{
	[self.candleChart appendToCategory:category forName:@"price"];
	[self.candleChart appendToCategory:category forName:@"line"];
	
}



#pragma mark - 横竖屏shouldAuto
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    if (interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        
        NSLog(@"横屏横屏横屏横屏横屏横屏横屏横屏横屏横屏横屏横屏横屏横屏横屏横屏");
        
        self.view.frame =CGRectMake(0, 0,480, 320);
        
        self.viewHUB.frame = CGRectMake(0, 0, 480,320);
        
        self.activity.frame = CGRectMake(0, 0,45, 45);
        
        self.viewBack.frame = CGRectMake(195, 127.5, 90, 45);
        
        self.imageBack.frame = CGRectMake(47.5+10.5, 12.5,20, 20);
        
        self.backButton.frame = CGRectMake(45,0, 45, 45);
        
        self.hcandleChart.frame = CGRectMake(0,0,self.view.frame.size.width, 320-32-49);
        
        [self.view addSubview:self.hcandleChart];
        
        [self.candleChart  removeFromSuperview];
        
        self.SELF_VIEW_FRAME_X = self.view.frame.origin.x;
        self.SELF_VIEW_FRAME_Y = self.view.frame.origin.y;
        self.SELF_VIEW_FRAME_WIDTH = self.view.frame.size.width;
        self.SELF_VIEW_FRAME_HEIGHT= self.view.frame.size.height;
        
        self.SELF_CANDLECHART_FRAME_X = self.candleChart.frame.origin.x;
        self.SELF_CANDLECHART_FRAME_Y = self.candleChart.frame.origin.y;
        self.SELF_CANDLECHART_FRAME_WIDTH = self.candleChart.frame.size.width;
        self.SELF_CANDLECHART_FRAME_HEIGHT= self.candleChart.frame.size.height;
        
        self.VIEWHUB_FRAME_X = self.viewHUB.frame.origin.x;
        self.VIEWHUB_FRAME_Y = self.viewHUB.frame.origin.y;
        self.VIEWHUB_FRAME_WIDTH = 480;
        self.VIEWHUB_FRAME_HEIGHT = 320;
        
        self.SELF_ACTIVITY_FRAME_X = 0;
        self.SELF_ACTIVITY_FRAME_Y = 0;
        self.SELF_ACTIVITY_FRAME_WIDTH = 45;
        self.SELF_ACTIVITY_FRAME_HEIGHT = 45;
        
        self.VIEWBACK_FRAME_X = 195;
        self.VIEWBACK_FRAME_Y = 127.5;
        self.VIEWBACK_FRAME_WIDTH = 90;
        self.VIEWBACK_FRAME_HEIGHT =45;
        
        self.LABELDATA_FRAME_X = 47.5+10.5;;
        self.LABELDATA_FRAME_Y = 12.5;
        self.LABELDATA_FRAME_WIDTH = 20;
        self.LABELDATA_FRAME_HEIGHT =20; 
        
        self.BACKBUTTON_FRAME_X = 45;
        self.BACKBUTTON_FRAME_Y = 0;
        self.BACKBUTTON_FRAME_WIDTH = 45; 
        self.BACKBUTTON_FRAME_HEIGHT= 45;
        
        upView  =YES;
        [backgroundViews setHidden:YES];
        
    }
    else {
        
        upView =NO;
        backgroundViews.backgroundColor = [UIColor colorWithRed:20/255.0f green:20/255.0f blue:20/255.0f alpha:1.0f];
        [backgroundViews setHidden:NO];
        
        NSLog(@"竖屏竖屏竖屏竖屏竖屏竖屏竖屏竖屏竖屏竖屏竖屏竖屏竖屏竖屏竖屏竖屏");
        
        
        self.view.frame =CGRectMake(0, 0, 320,480);
        
        self.candleChart.frame             = CGRectMake(0, 120, self.view.frame.size.width, 250);
        
        self.activity.frame                = CGRectMake(0, 0,45, 45);
        
        self.viewHUB.frame                 = CGRectMake(0, 0, 320,480);
        
        self.viewBack.frame                = CGRectMake(115, 200, 90, 45);
        
        self.imageBack.frame               = CGRectMake(47.5+10.5, 12.5,20, 20);
        
        self.backButton.frame              = CGRectMake(45,0, 45, 45);
        
        [self.view addSubview:self.candleChart];
        
        [self.hcandleChart removeFromSuperview];
        
        
        self.SELF_VIEW_FRAME_X             = self.view.frame.origin.x;
        self.SELF_VIEW_FRAME_Y             = self.view.frame.origin.y;
        self.SELF_VIEW_FRAME_WIDTH         = self.view.frame.size.width;
        self.SELF_VIEW_FRAME_HEIGHT        = self.view.frame.size.height;
        
        self.SELF_CANDLECHART_FRAME_X      = self.candleChart.frame.origin.x;
        self.SELF_CANDLECHART_FRAME_Y      = self.candleChart.frame.origin.y;
        self.SELF_CANDLECHART_FRAME_WIDTH  = self.candleChart.frame.size.width;
        self.SELF_CANDLECHART_FRAME_HEIGHT = self.candleChart.frame.size.height;
        
        self.VIEWHUB_FRAME_X               = self.viewHUB.frame.origin.x;
        self.VIEWHUB_FRAME_Y               = self.viewHUB.frame.origin.y;
        self.VIEWHUB_FRAME_WIDTH           =320;
        self.VIEWHUB_FRAME_HEIGHT          =480;
        
        self.SELF_ACTIVITY_FRAME_X         = 0;
        self.SELF_ACTIVITY_FRAME_Y         = 0;
        self.SELF_ACTIVITY_FRAME_WIDTH     = 45;
        self.SELF_ACTIVITY_FRAME_HEIGHT    = 45;
        
        self.VIEWBACK_FRAME_X              = 115;
        self.VIEWBACK_FRAME_Y              = 200;
        self.VIEWBACK_FRAME_WIDTH          = 90;
        self.VIEWBACK_FRAME_HEIGHT         = 45;
        
        self.LABELDATA_FRAME_X             = 47.5+10.5;
        self.LABELDATA_FRAME_Y             = 12.5;
        self.LABELDATA_FRAME_WIDTH         = 20;
        self.LABELDATA_FRAME_HEIGHT        = 20; 
        
        self.BACKBUTTON_FRAME_X            = 45;
        self.BACKBUTTON_FRAME_Y            = 0;
        self.BACKBUTTON_FRAME_WIDTH        = 45; 
        self.BACKBUTTON_FRAME_HEIGHT       = 45;
        
    }
    
    return YES;
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration{
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated{
	[self.timer invalidate];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {
    [super dealloc];
	[candleChart release];
	[autoCompleteView release];
	[toolBar release];
	[candleChartFreqView release];
	[autoCompleteDelegate release];
	[req_security_id release];
	[timer release];
	[lastTime release];
	[status release];
	[req_freq release];
	[req_type release];
	[req_url release];
	[req_security_id release];
}
@end