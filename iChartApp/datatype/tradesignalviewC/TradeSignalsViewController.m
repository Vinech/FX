//
//  TradeSignalsViewController.m
//  iChart
//
//  Created by bin huang on 12-7-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TradeSignalsViewController.h"
#import "TradeSignalCell.h"
#import "MarketTableViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface TradeSignalsViewController (){
    NSString *string;
    NSString *style;
    NSArray * array;
    NSArray * array1;
    NSArray * array2;
    NSArray * array3;
    NSArray * array4;
    NSArray * array5;
    UISearchBar * searchBar1;

    UIView * aView;
    UIScrollView * scrollV;
    UITableView * tabV;
    
    CGRect rect_aview;
    CGRect rect_scrollV;
    CGRect rect_tabV;

    
    
    UISearchBar * seacrhView ;
    UIBarButtonItem * cancelBar;
    UIBarButtonItem * userNameButton;
    UIBarButtonItem * searchBar;
    UIBarButtonItem * bar;
    //    UIBarButtonItem *buttonleft;
    NSArray * barArray;
    NSArray * barArray1;
    
    
}


@end

@implementation TradeSignalsViewController
@synthesize Aa;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    
    NSUserDefaults *user_hengshuping=[NSUserDefaults standardUserDefaults];
    NSString *string_hengshuping=[user_hengshuping objectForKey:@"hengshuping"];
    if ([string_hengshuping isEqualToString:@"hengping"]) {
        aView.frame=CGRectMake(0, 0, 480, 320-44-49);
        rect_aview=CGRectMake(0, 0, 480, 320-44-49);
        
        scrollV.frame=CGRectMake(0, 0, 480, 320-44-49);
        rect_scrollV=CGRectMake(0, 0, 480, 320-44-49);
        
        tabV.frame=CGRectMake(0, 0,700, 320-44-49);
        rect_tabV=CGRectMake(0, 0,700, 320-44-49);
        
        scrollV.contentSize=CGSizeMake(650, 80);
        string_hengshuping=@"hengping";
        [user_hengshuping setObject:string_hengshuping forKey:@"hengshuping"];
        [user_hengshuping synchronize];
        

    }else {
        aView.frame=CGRectMake(0, 0, 320, 480-44-49);
        rect_aview=CGRectMake(0, 0, 320, 480-44-49); 
        
        scrollV.frame=CGRectMake(0, 0, 320, 480-44-49);
        rect_scrollV=CGRectMake(0, 0, 320, 480-44-49);
        
        tabV.frame=CGRectMake(0, 0, 640, 460-44-49);
        tabV.frame=CGRectMake(0, 0, 640, 460-44-49);
        [scrollV setContentSize:CGSizeMake(640,0)];
        
        scrollV.contentSize=CGSizeMake(650, 80);
        string_hengshuping=@"shuping";
        [user_hengshuping setObject:string_hengshuping forKey:@"hengshuping"];
        [user_hengshuping synchronize];
        
    }
    
    
    
    
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    string = [user objectForKey:@"style"];
    NSLog(@"viewvillappear..string ==================== ========================================%@",string);
    if ([style isEqualToString:string]==NO) {
        NSLog(@"执行了```");
        [self viewDidLoad];

    }

    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (string==nil) {
        string=@"dark";
        style=@"dark";
    }
    else {
        style=[NSString stringWithFormat:string];
    }
    
    
    
    self.navigationItem.title = nil;
    
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    
//    userNameButton = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleDone target:self action:nil];
//    self.navigationItem.leftBarButtonItem = userNameButton;
    UIButton *logobutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 29, 29)];
    logobutton.multipleTouchEnabled=NO;
    
    UIButton* bulo=[[UIButton alloc]initWithFrame:CGRectMake(0, 2, 38, 30)];
    bulo.multipleTouchEnabled=NO;//不可触摸
    bulo.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"3730.png"]];
    //  button_logo.backgroundColor=[UIColor yellowColor];
    UIBarButtonItem* leftitem=[[UIBarButtonItem alloc]initWithCustomView:bulo];
    self.navigationItem.leftBarButtonItem=leftitem;
    
    
    UIView * seacV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 44)];
    seacV.backgroundColor = [UIColor clearColor];
    
    seacrhView = [[UISearchBar alloc] initWithFrame:seacV.bounds];
    seacrhView.delegate = self;
    seacrhView.keyboardType = UIKeyboardTypeDefault;
    [[seacrhView.subviews objectAtIndex:0] removeFromSuperview];
    seacrhView.placeholder = @"search...";
    
    [seacV addSubview:seacrhView];
    
    bar = [[UIBarButtonItem alloc] initWithCustomView:seacV];
    
    cancelBar = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(searchContentText:)];
    
    UIBarButtonItem * sep = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleDone target:self action:nil];
    
    barArray1 = [NSArray arrayWithObjects:cancelBar,sep,nil];
    
    
    
    searchBar = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStyleDone target:self action:@selector(searchContentText:)];
    UIBarButtonItem * screeningBar = [[ UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStyleDone target:self action:@selector(screeningDate:)];
    barArray = [NSArray arrayWithObjects:searchBar,screeningBar,nil];
    
    self.navigationItem.rightBarButtonItems = barArray;
    
    aView = [[UIView alloc] initWithFrame:rect_aview];
    self.view = aView;

    
    scrollV = [[UIScrollView alloc] initWithFrame:rect_scrollV];
    
    scrollV.showsHorizontalScrollIndicator = YES;
    scrollV.showsVerticalScrollIndicator = NO;
    scrollV.pagingEnabled = YES;
    scrollV.bounces = NO;
    scrollV.backgroundColor=[UIColor clearColor];
    [aView addSubview:scrollV];    
    
    tabV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStylePlain];
    tabV.delegate = self;
    tabV.dataSource=self;
    tabV.rowHeight = 70;
    tabV.backgroundColor=[UIColor clearColor];

    [scrollV addSubview:tabV];
    
    array = [[NSArray alloc ] initWithObjects:@"买入",@"卖出",@"买入",@"卖出",@"买入",@"卖出",@"买入",@"卖出",@"买入",@"卖出",@"买入",@"卖出",@"买入",@"卖出",@"买入",@"卖出",@"买入",@"卖出",@"买入",@"卖出", nil];
    
    array1 = [[NSArray alloc ] initWithObjects:@"EUR/USD",@"USD/EUR",@"GBP/AUD",@"NZD/USD",@"EUR/JPY",@"GBP/CHF",@"EUR/USD",@"USD/EUR",@"GBP/AUD",@"NZD/USD",@"EUR/JPY",@"GBP/CHF",@"EUR/USD",@"USD/EUR",@"GBP/AUD",@"NZD/USD",@"EUR/JPY",@"GBP/CHF",@"EUR/JPY",@"GBP/CHF",nil];
    
    array2= [[NSArray alloc ] initWithObjects:@"125.43",@"236.2",@"2425.3",@"988.664",@"4323.3",@"3.3200",@"12.53",@"23.43",@"5.65",@"103.2",@"678.4",@"342",@"43",@"6.44",@"6.433",@"765.76",@"901",@"623.32",@"999.99",@"432.31", nil];
    
    array3= [[NSArray alloc ] initWithObjects:@"120.43",@"43",@"999.99",@"432.31",@"28",@"2865.7",@"2324.2",@"973",@"421",@"6.423",@"3732.3",@"2346.4",@"3456.6",@"888.88",@"4323.3",@"3.3200",@"12.53",@"23.43",@"5.65",@"6.44",nil];
    
    array4= [[NSArray alloc ] initWithObjects:@"1213.43",@"4323.3",@"3.3200",@"12.53",@"23.43",@"5.65",@"6.44",@"6.433",@"765.76",@"901",@"623.32",@"103.2",@"678.4",@"342",@"6.423",@"3732.3",@"2346.4",@"3456.6",@"888.88",@"432.4", nil];
    
    array5= [[NSArray alloc ] initWithObjects:@"13.43",@"-323.3",@"3.30",@"-2.53",@"83.43",@"-45.65",@"6.44",@"-8.433",@"65.76",@"-901",@"623.32",@"-03.2",@"-8.4",@"342",@"-6.423",@"-332.3",@"46.4",@"-96.6",@"78.88",@"-52.23",nil];
    
    Aa = 1;
    if ([style isEqualToString:@"dark"]) {
        aView.backgroundColor = [UIColor blackColor];
        //        dateLabel.textColor = [UIColor whiteColor];
        //        searchDateButton.backgroundColor = [UIColor colorWithRed:100/255.0f green:100/255.0f blue:100/255.0f alpha:1];
      //  tabV .backgroundColor = [UIColor blackColor];
        //        searchView.backgroundColor = [UIColor blackColor];
        
        
        
        
    }
    else {
        aView.backgroundColor = [UIColor whiteColor];
        //        dateLabel.textColor = [UIColor blackColor];
        //        searchDateButton.backgroundColor = [UIColor lightGrayColor];
       // tabV .backgroundColor = [UIColor whiteColor];
        //        searchView.backgroundColor = [UIColor whiteColor];
        
        
        
        
        
    }
    
    
	// Do any additional setup after loading the view.
}
//不让弹出键盘

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return NO;
}
-(void)searchDate
{
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"按时间查找" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"一天前",@"一周前",@"一月前",nil];
    actionSheet.frame = CGRectMake(0,300,320,160);
    
    [actionSheet showInView:self.view.window];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array  count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * stringcell = @"cell";
    TradeSignalCell * cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
    if (cell == nil) {
        cell = [[TradeSignalCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:stringcell];
    }
    
    cell.label1.text = [array objectAtIndex:indexPath.row];
    cell.label2.text = [array1 objectAtIndex:indexPath.row];
    cell.label3.text = [array2 objectAtIndex:indexPath.row];
    cell.label4.text = [array3 objectAtIndex:indexPath.row];
    cell.label5.text = [array4 objectAtIndex:indexPath.row];
    cell.label6.text = [array5 objectAtIndex:indexPath.row];
    cell.label7.text = @"2012-06-24 9:45:34";
    if ([style isEqualToString:@"dark"]) {
        cell.label1.textColor=[UIColor whiteColor];
        cell.label2.textColor=[UIColor whiteColor];
        cell.label3.textColor=[UIColor whiteColor];
        cell.label4.textColor=[UIColor whiteColor];
        cell.label5.textColor=[UIColor whiteColor];
        cell.label6.textColor=[UIColor whiteColor];
        cell.label7.textColor=[UIColor whiteColor];
        cell.backgroundColor=[UIColor colorWithRed:20/255.0f green:20/255.0f blue:20/255.0f alpha:1];
        
    }
    else {
        cell.label1.textColor=[UIColor blackColor];
        cell.label2.textColor=[UIColor blackColor];
        cell.label3.textColor=[UIColor blackColor];
        cell.label4.textColor=[UIColor blackColor];
        cell.label5.textColor=[UIColor blackColor];
        cell.label6.textColor=[UIColor blackColor];
        cell.label7.textColor=[UIColor blackColor];
        
        
        
    }
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MarketTableViewController * marketTab = [[MarketTableViewController   alloc] init];
    marketTab.Aa =Aa;
    //[self.navigationController pushViewController:marketTab animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
   // viewHeader.alpha = 0.7;
    NSArray * arrays = [NSArray arrayWithObjects:@"指令",@"产品",@"价格",@"止损",@"目标",@"盈亏",nil];
    for (int i = 0; i<6; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0+i*110, -5, 100, 30)];
        label.text = [arrays objectAtIndex:i];
        label.textAlignment = UITextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        if ([style isEqualToString:@"dark"]) {
            label.textColor = [UIColor whiteColor];
            viewHeader.backgroundColor = [UIColor blackColor];

            
            
            
        }else {
            label.textColor=[UIColor blackColor];
            viewHeader.backgroundColor = [UIColor whiteColor];

        }
        [viewHeader addSubview:label];
    }
    return viewHeader;
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    NSUserDefaults *user_hengshuping=[NSUserDefaults standardUserDefaults];
    NSString *string_hengshuping=[[NSString alloc]init];
    
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft||interfaceOrientation==UIInterfaceOrientationLandscapeRight) { 
        aView.frame=CGRectMake(0, 0, 480, 320-44-49);
        rect_aview=CGRectMake(0, 0, 480, 320-44-49);
        
        scrollV.frame=CGRectMake(0, 0, 480, 320-44-49);
        rect_scrollV=CGRectMake(0, 0, 480, 320-44-49);
        
        tabV.frame=CGRectMake(0, 0,700, 320-44-49);
        rect_tabV=CGRectMake(0, 0,700, 320-44-49);
        
        scrollV.contentSize=CGSizeMake(650, 80);
        string_hengshuping=@"hengping";
        [user_hengshuping setObject:string_hengshuping forKey:@"hengshuping"];
        [user_hengshuping synchronize];

    } 
    if (interfaceOrientation==UIInterfaceOrientationPortrait||interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) { 
        aView.frame=CGRectMake(0, 0, 320, 480-44-49);
        rect_aview=CGRectMake(0, 0, 320, 480-44-49); 
        
        scrollV.frame=CGRectMake(0, 0, 320, 480-44-49);
        rect_scrollV=CGRectMake(0, 0, 320, 480-44-49);
        
        tabV.frame=CGRectMake(0, 0, 640, 460-44-49);
        tabV.frame=CGRectMake(0, 0, 640, 460-44-49);
        [scrollV setContentSize:CGSizeMake(640,0)];
        
        scrollV.contentSize=CGSizeMake(650, 80);
        string_hengshuping=@"shuping";
        [user_hengshuping setObject:string_hengshuping forKey:@"hengshuping"];
        [user_hengshuping synchronize];



    } 
    
    return YES;
}




#pragma mark-search

-(void)searchContentText:(UIBarButtonItem *)sender
{
    static BOOL isSearch;
    isSearch = !isSearch;
    if (isSearch) 
    {
        self.navigationItem.rightBarButtonItems = barArray1;
        self.navigationItem.leftBarButtonItem = bar;
    }else 
    {
        self.navigationItem.leftBarButtonItem= userNameButton;
        self.navigationItem.rightBarButtonItems = barArray;
    }   
}

#pragma mark-actionsheet


-(void)screeningDate:(UIBarButtonItem *)sender
{
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"按时间查找" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"一天前",@"一周前",@"一月前",nil];
    
    [actionSheet showInView:self.view.window];
    
}
@end





