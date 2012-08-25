//
//  MarketViewController.m
//  iChart
//
//  Created by bin huang on 12-7-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.fvbss
////////////////////////////////////////////////////////////////////////把25011改成25010sssss999

#import "MarketViewController.h"
#import "MarketCell.h"
#import "MarketTableViewController.h"
#import "data2.h"
#import "LoginViewController.h"
#import "Personaldetail.h"
#import "CandleViewController.h"
#import "ProductSelectViewController.h"
#import "FileSelectViewController.h"
#import "eightbyte.h"
@interface MarketViewController (){
    NSMutableArray * array_quanbuziduan;//所有的字段
    NSMutableArray *array_quanbuproductname;//所有的产品的名字
    NSMutableArray *array_ziduan;//用来接收字段
    NSMutableArray *array_mark;//用来判断当前的字段
    NSMutableArray *array_product;//用来接收产品的名字
    NSMutableArray *array_chanpin;//用来判断当前的产品
    NSArray *array1000;//没有实际意义
    NSString *string_bianhuanhengshuping;
    
    data2 *_data2;
    data *data1;
    
    NSString *stringhostlogin;
    NSString *stringportlogin;
}
@end

@implementation MarketViewController
@synthesize biaozhiwei,stringhost,sessionid,captchas,stringport,signin;
@synthesize self_view_frame_size_width;
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
    //字段
    NSLog(@"111111");
    // [self shouldAutorotateToInterfaceOrientation:UIInterfaceOrientationPortrait|UIInterfaceOrientationPortraitUpsideDown|UIInterfaceOrientationLandscapeLeft|UIInterfaceOrientationLandscapeRight];
    // [self performSelector:@selector(shouldAutorotateToInterfaceOrientation:)];
    //[alertviewdenglujieguo show];
    if (alertview_denglu==nil) {
        alertview_denglu=[[UIAlertView alloc]initWithTitle:@"iChartID Password" message:nil delegate:self cancelButtonTitle:@"注册" otherButtonTitles:@"登陆", nil];
    }
    if (signin==0) {
        [alertview_denglu show];
        signin=1;
        
    }
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    array_ziduan=[user objectForKey:@"ziduan"];
    string_yanse=[user objectForKey:@"style"];
    string_bianhuanhengshuping=[user objectForKey:@"480"];
    
    self.self_view_frame_size_width = [string_bianhuanhengshuping intValue];
    
    NSLog(@"self.self_view_frame_size_width = %d",self.self_view_frame_size_width);
    
    //产品
    NSUserDefaults *user_forex=[NSUserDefaults standardUserDefaults];
    switch (biaozhiwei) {
        case 0:
            array_product=[user_forex objectForKey:@"forex"];
            break;
        case 1:
            array_product=[user_forex objectForKey:@"preciousmetal"];
            
            break;
        case 2:
            array_product=[user_forex objectForKey:@"exponent"];
            
            break;
        default:
            break;
    }
    
    //aview=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    aview.frame=[UIScreen mainScreen].bounds;
    NSLog(@"aview.frame.size.height=%f",aview.frame.size.height);
    
    NSLog(@"waihui=======%@",array_product);
    if (array_chanpin!=array_product||array_mark!=array_ziduan||[string_yanse isEqualToString:string_color]==NO) 
    {
        [self viewDidLoad];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    
}
//login

- (void)viewDidLoad
{     [super viewDidLoad];
    
    NSLog(@"asdfghjklasdfghjklsdfghjklzxcvbnm,wertyuiodfghjk");
    //判断如果字段为空的话就等于全部的字段
    if (array_quanbuziduan==nil) {
        array_quanbuziduan = [[NSMutableArray alloc]initWithObjects:@"报价",@"开盘",@"最高",@"最低",@"涨跌",@"更新",nil];
    }    
    if ([array_ziduan count]==0) {
        array_mark=array_quanbuziduan;
        array_ziduan=array_quanbuziduan;
    }
    else {
        array_mark=array_ziduan;
    }
    //判断如果产品名字为空的话就等于全部的产品名字
    array_quanbuproductname = [[NSMutableArray alloc ] initWithObjects:@"美元指数",nil];
    if (array_product==nil) {
        array_product=array_quanbuproductname;
        array_chanpin=array_quanbuproductname;
    }else {
        array_chanpin=array_product;
    }
    //判断是高亮状态还是黑暗状态
    if (string_yanse==nil) {
        string_yanse=@"dark";
        string_color=@"dark";
    }else {
        string_color=[NSString stringWithFormat:string_yanse];
    }
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.title=nil;
    
    UISegmentedControl * segmentC = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"外汇",@"贵金属",@"指数", nil]];
    segmentC.frame = CGRectMake(20, 6, 150,30);               
    segmentC.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentC.momentary = NO;    //设置在点击后是否恢复原样 
    segmentC.multipleTouchEnabled=YES;  //可触摸
    segmentC.tintColor = [UIColor blackColor];
    [segmentC addTarget:self action:@selector(mySegment:) forControlEvents:UIControlEventValueChanged];
    
    
    UIView *view_rightheader=[[UIView alloc]initWithFrame:CGRectMake(80, 3, 186, 40)];
    view_rightheader.backgroundColor=[UIColor clearColor];
    [view_rightheader addSubview:segmentC];
    self.navigationItem.titleView=view_rightheader;
    
    
    UIBarButtonItem * setupbtn = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(setup)];
    self.navigationItem.rightBarButtonItem = setupbtn;
    
    
    UIButton* button_logo=[[UIButton alloc]initWithFrame:CGRectMake(0, 2, 38, 30)];
    button_logo.multipleTouchEnabled=NO;//不可触摸
    button_logo.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"3730.png"]];
    //  button_logo.backgroundColor=[UIColor yellowColor];
    UIBarButtonItem* buttonleft=[[UIBarButtonItem alloc]initWithCustomView:button_logo];
    self.navigationItem.leftBarButtonItem=buttonleft;
    
    
    self.view.frame=[UIScreen mainScreen].bounds;
    aview=[[UIView alloc]initWithFrame:rect_aview];
    [self.view addSubview:aview];
    
    mytableview_productname=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 100, [array_product count]*44+100)];
    mytableview_productname.delegate=self;
    mytableview_productname.dataSource=self;
    
    mytableview_productdetail=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,[array_ziduan count]*110,[array_product count]*44+100)
                                                          style:UITableViewStylePlain];
    mytableview_productdetail.delegate=self;
    mytableview_productdetail.dataSource=self;
    
    scrowview_cellsc=[[UIScrollView alloc]init];
    NSLog(@"self.self_view_frame_size_width - 1 = %d",self.self_view_frame_size_width);
    if (self.view.frame.size.width==self.self_view_frame_size_width) {
        if (self.self_view_frame_size_width == 480) {
            scrowview_cellsc.frame=CGRectMake(100, 0, 480-100, [array_product count]*44+100);
        }else {
            scrowview_cellsc.frame=CGRectMake(100, 0, 320-100,[array_product count]*44+100);
            NSLog(@"竖屏");
        }
    }else {
        scrowview_cellsc.frame=CGRectMake(100, 0, 480-100, [array_product count]*44+100);
        
    }
    scrowview_cellsc.backgroundColor=[UIColor clearColor];
    [scrowview_cellsc addSubview:mytableview_productdetail];
    scrowview_cellsc.delegate=self;
    scrowview_cellsc.bounces = NO;
    scrowview_cellsc.showsVerticalScrollIndicator=NO;
    scrowview_cellsc.showsHorizontalScrollIndicator=NO;
    scrowview_cellsc.contentSize = CGSizeMake([array_mark count]*110, 0);
    // mytableview_productname.backgroundColor=[UIColor colorWithRed:20/255.0f green:20/255.0f blue:20/255.0f alpha:1.0f];
    //mytableview_productdetail.backgroundColor=[UIColor colorWithRed:20/255.0f green:20/255.0f blue:20/255.0f alpha:1.0f];
    mytableview_productname.userInteractionEnabled=YES;
    mytableview_productdetail.userInteractionEnabled=YES;
    mytableview_productname.scrollEnabled=NO;
    mytableview_productdetail.scrollEnabled=NO;
    
    
    
    view_productnameheader=[[UIView alloc]initWithFrame:rect_viewproductnameheader];
    label_nameheader=[[UILabel alloc]initWithFrame:view_productnameheader.frame];
    label_nameheader.text=@"产品";
    view_productnameheader.backgroundColor=[UIColor clearColor];
    label_nameheader.textAlignment=UITextAlignmentCenter;
    [view_productnameheader addSubview:label_nameheader];
    [aview addSubview:view_productnameheader];
    
    
    view_productdetailheader=[[UIView alloc]initWithFrame:rect_prodcuctdetailheader];
    view_productdetailheader.backgroundColor=[UIColor clearColor];
    if ([array_mark count]==1) {
        label_headerheader = [[UILabel alloc] initWithFrame:CGRectMake(110, 0, 100, 30)];
        label_headerheader.text = [array_mark objectAtIndex:0];
        label_headerheader.textAlignment = UITextAlignmentCenter;
        label_headerheader.backgroundColor = [UIColor blackColor];
        //label.textColor = [UIColor blackColor];
        if ([string_color isEqualToString:@"dark"]) {
            label_headerheader.textColor=[UIColor whiteColor];
        }
        else {
            label_headerheader.textColor=[UIColor blackColor];
        }
        
        [view_productdetailheader addSubview:label_headerheader];
        
    }
    else {
        for (int i = 0; i<[array_mark count]; i++) {
            
            label_headerheader = [[UILabel alloc] initWithFrame:CGRectMake(0+i*110, 0, 100, 30)];
            label_headerheader.text = [array_mark objectAtIndex:i];
            label_headerheader.textAlignment = UITextAlignmentCenter;
            label_headerheader.backgroundColor = [UIColor clearColor];
            if ([string_color isEqualToString:@"dark"]) {
                label_headerheader.textColor=[UIColor whiteColor];
            }
            else {
                label_headerheader.textColor=[UIColor blackColor];
            }
            [view_productdetailheader addSubview:label_headerheader];
        }
    }
    scrowviewheader=[[UIScrollView alloc]initWithFrame:rect_scrowviewheader];
    scrowviewheader.bounces=NO;
    scrowviewheader.pagingEnabled=YES;
    [scrowviewheader addSubview:view_productdetailheader];
    scrowviewheader.delegate=self;
    scrowviewheader.showsVerticalScrollIndicator=NO;
    scrowviewheader.showsHorizontalScrollIndicator=NO;
    scrowviewheader.backgroundColor=[UIColor clearColor];
    [aview addSubview:scrowviewheader];
    
    // [scrowview_cellsc addSubview:view_productdetailheader ];
    
    scr_total=[[UIScrollView alloc]initWithFrame:rect_scr_total];
    [aview addSubview:scr_total];
    [scr_total addSubview:scrowview_cellsc];
    [scr_total addSubview:mytableview_productname];
    scr_total.backgroundColor=[UIColor clearColor];
    scr_total.contentSize=CGSizeMake(0, [array_chanpin count]*55);
    NSLog(@"chapin%d",[array_chanpin count]);
    scr_total.bounces=YES;
    scr_total.backgroundColor=[UIColor clearColor];
    scr_total.showsVerticalScrollIndicator=NO;
    scr_total.showsHorizontalScrollIndicator=NO; 
    
    if ([string_color isEqualToString:@"dark"]) {
        NSLog(@"当前是暗黑状态");
        aview.backgroundColor=[UIColor blackColor];
        
        mytableview_productname.separatorColor=[UIColor colorWithRed:250/255.0f green:250/255.0f blue:250/255.0f alpha:0.9f];
        mytableview_productdetail.separatorColor=[UIColor colorWithRed:250/255.0f green:250/255.0f blue:250/255.0f alpha:0.9f];
        mytableview_productname.backgroundColor=[UIColor blackColor];
        mytableview_productdetail.backgroundColor=[UIColor blackColor];
        label_nameheader.textColor=[UIColor whiteColor];
        
        label_headerheader.backgroundColor=[UIColor clearColor];
        label_nameheader.backgroundColor=[UIColor clearColor];
        label_nameheader.textColor=[UIColor whiteColor];
        
        
    }else {
        aview.backgroundColor=[UIColor whiteColor];
        mytableview_productname.separatorColor=[UIColor blackColor];
        mytableview_productdetail.separatorColor=[UIColor blackColor];
        mytableview_productdetail.backgroundColor=[UIColor whiteColor];
        mytableview_productname.backgroundColor=[UIColor whiteColor];
        label_nameheader.textColor=[UIColor blackColor];
        label_headerheader.backgroundColor=[UIColor clearColor];
        label_nameheader.backgroundColor=[UIColor clearColor];
        label_nameheader.textColor=[UIColor blackColor];
        
    }
    //**************************登陆 *****注册************
    
    
    
    
    //  [self lianjie];
    
}
#pragma mark - TableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array_chanpin count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *string=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:string];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (tableView==mytableview_productname) {
        NSLog(@"rect_tableviewproductname.size.height=%f",rect_tableviewproductname.size.height);
        
        NSLog(@"%f",cell.contentView.frame.size.height);
        label_productname=[[UILabel alloc]initWithFrame:CGRectMake(0, 2, 90, 40)];
        label_productname.text=[array_chanpin objectAtIndex:indexPath.row];
        label_productname.backgroundColor=[UIColor clearColor];
        label_productname.textAlignment=UITextAlignmentCenter;
        [cell.contentView addSubview:label_productname];
        
        if ([string_color isEqualToString:@"dark"]) {
            label_productname.textColor=[UIColor whiteColor];
            lable_zhibiao.textColor=[UIColor whiteColor];
            lable_zhibiao.backgroundColor=[UIColor clearColor];
            cell.backgroundColor=[UIColor colorWithHue:20/255.0f saturation:20/255.0f brightness:20/255.0f alpha:1];
            
        }else {
            lable_zhibiao.textColor=[UIColor blackColor];
            label_productname.textColor=[UIColor blackColor];
            lable_zhibiao.backgroundColor=[UIColor clearColor];
        }
    }
    
    if (tableView==mytableview_productdetail) 
        
    {
        Personaldetail *userproduct=[[Personaldetail alloc]init];
        //  NSLog(@"");
        userproduct = [Personaldetail findpersonaldetailwithproductname:[array_chanpin objectAtIndex:indexPath.row]];
        
        NSLog(@"productArray ============================= %@ open=%@",[array_chanpin objectAtIndex:indexPath.row],userproduct.open);
        
        NSLog(@"当前是第二个tableview");
        if ([array_mark count]==1) {
            
            scrowview_cellsc.contentSize=CGSizeMake(0,30);
            // mytableview_productdetail.frame=rect_tableviewproductdetail;
            NSLog(@"==%d",[array_mark count]);
            lable_zhibiao=[[UILabel alloc]initWithFrame:CGRectMake(110, 2, 100, 40)];
            
            lable_zhibiao.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];
            
            NSString *string_ziduan=[array_mark objectAtIndex:0];
            if ([string_color isEqualToString:@"dark"]) {
                // lable_zhibiao.textColor=[UIColor whiteColor];
                lable_zhibiao.backgroundColor=[UIColor clearColor];
                cell.contentView.backgroundColor=[UIColor colorWithHue:20/255.0f saturation:20/255.0f brightness:20/255.0f alpha:1];
                cell.backgroundColor=[UIColor colorWithHue:20/255.0f saturation:20/255.0f brightness:20/255.0f alpha:1];
                
            }else {
                //lable_zhibiao.textColor=[UIColor blackColor];
                lable_zhibiao.backgroundColor=[UIColor clearColor];
                
            }
            
            if ([string_ziduan isEqualToString:@"报价"]) {
                if ([lable_zhibiao.text floatValue]-[userproduct.last floatValue]<0) {
                    lable_zhibiao.textColor=[UIColor redColor];
                    
                }else {
                    lable_zhibiao.textColor=[UIColor greenColor];
                }
                lable_zhibiao.text=userproduct.last;
                
            }
            if ([string_ziduan isEqualToString:@"开盘"]) {
                if ([lable_zhibiao.text floatValue]-[userproduct.open floatValue]<0) {
                    lable_zhibiao.textColor=[UIColor redColor];
                }else {
                    lable_zhibiao.textColor=[UIColor greenColor];
                }
                
            }
            
            if ([string_ziduan isEqualToString:@"最高"]) {
                if ([lable_zhibiao.text floatValue]-[userproduct.high floatValue]<0) {
                    lable_zhibiao.textColor=[UIColor redColor];
                }else {
                    lable_zhibiao.textColor=[UIColor greenColor];
                }
                lable_zhibiao.text=userproduct.high;
            }
            if ([string_ziduan isEqualToString:@"最低"]) {
                if ([lable_zhibiao.text floatValue]-[userproduct.low floatValue]<0) {
                    lable_zhibiao.textColor=[UIColor redColor];
                }else {
                    lable_zhibiao.textColor=[UIColor greenColor];
                }
                lable_zhibiao.text=userproduct.low;
            }
            if ([string_ziduan isEqualToString:@"涨跌"]) {
                if ([userproduct.volume floatValue]>0) {
                    lable_zhibiao.textColor=[UIColor redColor];
                }else {
                    lable_zhibiao.textColor=[UIColor greenColor];
                }
                
                lable_zhibiao.text=[NSString stringWithFormat:@"%%%.5f",[userproduct.volume floatValue]];
            }
            if ([string_ziduan isEqualToString:@"更新"]) {
                int time=[userproduct.time intValue];
                NSDate *nd = [NSDate dateWithTimeIntervalSince1970:time];
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"MMdd HH:mm"];//时间格式，YYYY-MM-dd HH:mm:ss:SSSS
                NSString *dateString = [dateFormat stringFromDate:nd];
                lable_zhibiao.text=dateString;
                if ([string_color isEqualToString:@"dark"]) {
                    lable_zhibiao.backgroundColor=[UIColor colorWithHue:20/255.0f saturation:20/255.0f brightness:20/255.0f alpha:1];
                    cell.backgroundColor=[UIColor colorWithHue:20/255.0f saturation:20/255.0f brightness:20/255.0f alpha:1];
                    cell.contentView.backgroundColor=[UIColor colorWithHue:20/255.0f saturation:20/255.0f brightness:20/255.0f alpha:1];
                    
                    lable_zhibiao.textColor=[UIColor whiteColor];
                }else {
                    lable_zhibiao.backgroundColor=[UIColor whiteColor];
                    lable_zhibiao.textColor=[UIColor blackColor];
                }
            }
            [cell.contentView addSubview:lable_zhibiao];
            scrowviewheader.contentSize=scrowview_cellsc.contentSize;
        }
        
        
        else {
            NSLog(@"wocaokengdie=%d",[array_chanpin count]);
            //            scrowview_cellsc.frame=rect_scrowview_cellsc;
            //            scrowview_cellsc.contentSize=CGSizeMake(([array_mark count])*110, 0);
            // NSLog(@"rect_tableviewproductname.size.height=%f",rect_tableviewproductname.size.height);
            mytableview_productdetail.frame=CGRectMake(0, 0, 140*[array_mark count],[array_chanpin count]*44+100);
            
            scrowview_cellsc.frame=CGRectMake(100, 0, 220, [array_chanpin count]*44+100);
            NSLog(@"self.self_view_frame_size_width - 2= %d",self.self_view_frame_size_width);
            if (self.view.frame.size.width == self.self_view_frame_size_width) {
                if (self.self_view_frame_size_width == 480) {
                    scrowview_cellsc.frame=CGRectMake(100, 0, 480-100, [array_product count]*44+100);
                    NSLog(@"ElseElseElseElseElseElseElseElseElseElseElse");
                    
                }else {
                    scrowview_cellsc.frame=CGRectMake(100, 0, 320-100,[array_product count]*44+100);
                    NSLog(@"ififififififififififififififiiffiiffifififii");
                }
                
            }else {
                scrowview_cellsc.frame=CGRectMake(100, 0, 480-100, [array_product count]*44+100);
                NSLog(@"ElseElseElseElseElseElseElseElseElseElseElse");
            }
            
            
            for (int i=0; i<[array_mark count]; i++) {
                NSLog(@"==%d",[array_mark count]);
                lable_zhibiao=[[UILabel alloc]initWithFrame:CGRectMake(110*i, 2, 100, 40)];
                lable_zhibiao.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];
                
                if ([string_color isEqualToString:@"dark"]) {
                    // lable_zhibiao.textColor=[UIColor whiteColor];
                    lable_zhibiao.backgroundColor=[UIColor clearColor];
                    cell.contentView.backgroundColor=[UIColor colorWithHue:20/255.0f saturation:20/255.0f brightness:20/255.0f alpha:1];
                    cell.backgroundColor=[UIColor colorWithHue:20/255.0f saturation:20/255.0f brightness:20/255.0f alpha:1];
                    
                }else {
                    // lable_zhibiao.textColor=[UIColor blackColor];
                    lable_zhibiao.backgroundColor=[UIColor clearColor];
                    
                }
                
                NSString *string_ziduan=[array_mark objectAtIndex:i];
                
                if ([string_ziduan isEqualToString:@"报价"]) 
                {
                    if (userproduct.last == nil) {
                        lable_zhibiao.text = @"N/A";
                    }else {
                        if ([lable_zhibiao.text floatValue]-[userproduct.last floatValue]<0) {
                            lable_zhibiao.textColor=[UIColor redColor];
                        }else {
                            lable_zhibiao.textColor=[UIColor greenColor];
                        }
                        
                        lable_zhibiao.text= userproduct.last;
                    }
                }
                if ([string_ziduan isEqualToString:@"开盘"]) 
                {
                    if (userproduct.open == nil) {
                        lable_zhibiao.text = @"N/A";
                    }else {
                        if ([lable_zhibiao.text floatValue]-[userproduct.open floatValue]<0) {
                            lable_zhibiao.textColor=[UIColor redColor];
                        }else {
                            lable_zhibiao.textColor=[UIColor greenColor];
                        }
                        
                        lable_zhibiao.text= userproduct.open;
                    }
                }
                
                if ([string_ziduan isEqualToString:@"最高"]) {
                    if (userproduct.high == nil) {
                        lable_zhibiao.text = @"N/A";
                    }else {
                        if ([lable_zhibiao.text floatValue]-[userproduct.high floatValue]<0) {
                            lable_zhibiao.textColor=[UIColor redColor];
                        }else {
                            lable_zhibiao.textColor=[UIColor greenColor];
                        }
                        
                        lable_zhibiao.text= userproduct.high;
                    }               
                }
                if ([string_ziduan isEqualToString:@"最低"]) {
                    if (userproduct.low == nil) {
                        lable_zhibiao.text = @"N/A";
                    }else {
                        if ([lable_zhibiao.text floatValue]-[userproduct.low floatValue]<0) {
                            lable_zhibiao.textColor=[UIColor redColor];
                        }else {
                            lable_zhibiao.textColor=[UIColor greenColor];
                        }
                        
                        lable_zhibiao.text= userproduct.low;
                    }               
                }
                if ([string_ziduan isEqualToString:@"涨跌"]) {
                    if ([userproduct.volume floatValue]>0) {
                        lable_zhibiao.textColor=[UIColor redColor];
                    }else {
                        lable_zhibiao.textColor=[UIColor greenColor];
                    }
                    
                    lable_zhibiao.text=[NSString stringWithFormat:@"     %.2f%%",[userproduct.volume floatValue]];
                    
                }
                if ([string_ziduan isEqualToString:@"更新"]) {
                    int time=[userproduct.time intValue];
                    NSDate *nd = [NSDate dateWithTimeIntervalSince1970:time];
                    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                    [dateFormat setDateFormat:@"MMdd HH:mm"];//时间格式，YYYY-MM-dd HH:mm:ss:SSSS
                    NSString *dateString = [dateFormat stringFromDate:nd];
                    lable_zhibiao.text=dateString;
                    if ([string_color isEqualToString:@"dark"]) {
                        lable_zhibiao.backgroundColor=[UIColor redColor];
                        lable_zhibiao.textColor=[UIColor whiteColor];
                        cell.contentView.backgroundColor=[UIColor colorWithHue:20/255.0f saturation:20/255.0f brightness:20/255.0f alpha:1];
                        
                        cell.backgroundColor=  [UIColor colorWithHue:20/255.0f saturation:20/255.0f brightness:20/255.0f alpha:1];
                    }else {
                        lable_zhibiao.backgroundColor=[UIColor whiteColor];
                        lable_zhibiao.textColor=[UIColor blackColor];
                    }
                    
                }
                
                
                [cell.contentView addSubview:lable_zhibiao];
                scrowviewheader.contentSize=scrowview_cellsc.contentSize;
                scrowview_cellsc.pagingEnabled=YES;
                
            }
            
        }
        
    } 
    
    if ([string_color isEqualToString:@"dark"]) {
        
        label_productname.textColor=[UIColor whiteColor];
        // lable_zhibiao.textColor=[UIColor whiteColor];
        lable_zhibiao.backgroundColor=[UIColor clearColor];
        cell.backgroundColor=[UIColor colorWithHue:20/255.0f saturation:20/255.0f brightness:20/255.0f alpha:1];
        cell.contentView.backgroundColor=[UIColor colorWithHue:20/255.0f saturation:20/255.0f brightness:20/255.0f alpha:1];
    }else {
        label_productname.textColor=[UIColor blackColor];
        lable_zhibiao.backgroundColor=[UIColor clearColor];
        
    }
    
    return cell;  
}

#pragma mark - TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   
    
    CandleViewController *aview1=[[CandleViewController alloc]init];
    aview1.biaoji=indexPath.row;
    aview1.array_pro=array_chanpin;
    [self.navigationController pushViewController:aview1 animated:NO];
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    scrowviewheader.contentOffset= scrowview_cellsc.contentOffset;
    // NSLog(@"header%f\n%f",scrowviewheader.contentOffset.x,scrowview_cellsc.contentOffset.x);
    
}


#pragma mark - UISegmentedControl
- (void)mySegment:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
        case 0:
        {
            NSLog(@"当前是外汇产品0");
            biaozhiwei=0;
            [self viewWillAppear:YES];
            
        }
            break;
        case 1:
        {
            NSLog(@"当前是贵金属1");
            biaozhiwei=1;
            [self viewWillAppear:YES];
        }
            break;
        case 2:
        {
            NSLog(@"当前是技术指标2");
            biaozhiwei=2;
            [self viewWillAppear:YES];
        }
            break;
            
            
        default:
            break;
    }
}
#pragma mark-alertviewdelegate
-(void)willPresentAlertView:(UIAlertView *)alertView
{
    if (alertView==alertview_denglu) {
        CGRect fram=alertview_denglu.frame;
        fram.origin.y=120;
        fram.size.height+=80;
        alertview_denglu.frame=fram;
        
        for (UIView *view in alertview_denglu.subviews) {
            if (view.tag==1) {
                //处理第一个按钮，也就是cancelbutton
                CGRect btnfram1=CGRectMake(30, fram.size.height-65, 105, 30);
                view.frame=btnfram1;
                
            }
            else if (view.tag==2) {
                //处理第二个按钮，也就是otherbutton
                CGRect buttonfram2=CGRectMake(142, fram.size.height-65, 105, 30);
                view.frame=buttonfram2;
            }
        }
        NSUserDefaults *user_qushu=[NSUserDefaults standardUserDefaults];
        textfield_dengluusername=[[UITextField alloc]initWithFrame:CGRectMake( 45, 50,190, 30 )];
        textfield_dengluusername.placeholder=@"用户名";
        [texfield_zhuceusername resignFirstResponder];
        textfield_dengluusername.borderStyle=UITextBorderStyleRoundedRect;
        textfield_dengluusername.text=[user_qushu objectForKey:@"name"];
        [alertView addSubview:textfield_dengluusername ];
        
        
        textfield_denglumin=[[UITextField alloc]initWithFrame:CGRectMake( 45, 91,190, 30 )];
        textfield_denglumin.placeholder=@"密码";
        textfield_denglumin.secureTextEntry=YES;
        textfield_denglumin.text=[user_qushu objectForKey:@"min"];
        textfield_denglumin.borderStyle=UITextBorderStyleRoundedRect;
        [alertView addSubview:textfield_denglumin ];
        //  [SFHFKeychainUtils storeUsername:@"dd" andPassword:@"aa"forServiceName:SERVICE_NAME updateExisting:1 error:nil];
        //  [SFHFKeychainUtils storeUsername:textfield_dengluusername.text andPassword:textfield_denglumin.text forServiceName:@"iChartApp" updateExisting:1 error:nil];
        //   textfield_denglumin.text=[SFHFKeychainUtils getPasswordForUsername:textfield_dengluusername.text andServiceName:@"iChartApp" error:nil];
    }
    
    if (alertView==alertview_zhuce) {
        CGRect fram=alertview_zhuce.frame;
        fram.origin.y=120;
        fram.size.height+=122;
        alertview_zhuce.frame=fram;
        
        for (UIView *view in alertview_zhuce.subviews) 
        {
            if (view.tag==1)
            {
                //处理第一个按钮，也就是cancelbutton
                CGRect btnfram1=CGRectMake(30, fram.size.height-52, 105, 30);
                view.frame=btnfram1;
                
            }
            else if (view.tag==2) 
            {
                //处理第二个按钮，也就是otherbutton
                CGRect buttonfram2=CGRectMake(142, fram.size.height-52, 105, 30);
                view.frame=buttonfram2;
            }
        }
        
        texfield_zhuceusername=[[UITextField alloc]initWithFrame:CGRectMake( 45, 40,190, 25 )];
        texfield_zhuceusername.placeholder=@"用户名";
        texfield_zhuceusername.delegate = self;
        texfield_zhuceusername.borderStyle=UITextBorderStyleRoundedRect;
        [alertview_zhuce addSubview:texfield_zhuceusername ];
        
        textfield_zhucemin=[[UITextField alloc]initWithFrame:CGRectMake( 45, 70,190, 25 )];
        textfield_zhucemin.placeholder=@"密码";
        textfield_zhucemin.delegate = self;
        textfield_zhucemin.borderStyle=UITextBorderStyleRoundedRect;
        textfield_zhucemin.secureTextEntry=YES;
        [alertview_zhuce addSubview:textfield_zhucemin ];
        
        textfield_zhuceqmin=[[UITextField alloc]initWithFrame:CGRectMake( 45, 100,190, 25 )];
        textfield_zhuceqmin.placeholder=@"确认密码";
        textfield_zhuceqmin.delegate = self;
        textfield_zhuceqmin.secureTextEntry=YES;
        textfield_zhuceqmin.borderStyle=UITextBorderStyleRoundedRect;
        [alertview_zhuce addSubview:textfield_zhuceqmin ];
        
        textfileld_zhuceemail=[[UITextField alloc]initWithFrame:CGRectMake( 45, 130,190, 25 )];
        textfileld_zhuceemail.placeholder=@"邮箱";
        textfileld_zhuceemail.delegate = self;
        textfileld_zhuceemail.borderStyle=UITextBorderStyleRoundedRect;
        [alertview_zhuce addSubview:textfileld_zhuceemail ];
        
        textfield_zhucephonenumber=[[UITextField alloc]initWithFrame:CGRectMake( 45,160,190, 25 )];
        textfield_zhucephonenumber.placeholder=@"手机号码";
        textfield_zhucephonenumber.delegate = self;
        textfield_zhucephonenumber.borderStyle=UITextBorderStyleRoundedRect;
        [alertview_zhuce addSubview:textfield_zhucephonenumber ];
        
        
        
        
        
        
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}




-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView==alertview_denglu) {
        if (buttonIndex==0) {
            NSLog(@"zhuce");
            [self zhuce];
        }else {
            NSLog(@"denglu");
            [self denglu];
        }
        
    }
    if (alertView==alertview_zhuce) {
        if (buttonIndex==0) {
            NSLog(@"取消");
            [alertview_denglu show];
        }
        else {
            NSLog(@"发送注册数据");
            [self zhucexieru];
        }
    }
    if (alertView==alertviewdenglujieguo) {
        signin=0;
        
        [alertview_denglu show];
        NSLog(@"wocao!!!caocao");
        if (buttonIndex==0) {
            NSLog(@"wocao");
        }
        else {
            NSLog(@"wori");
        }
        
        
    }
    if (alertView==alertviewzhucejieguo) {
        
        [alertview_denglu show];
        
        
        
        
        // [self viewWillAppear:YES];
        
    }
}

#pragma mark-socket连接
-(void)lianjie{
    if (_data2==nil) {
        _data2=[[data2 alloc]init];
        
    }
    
    if (socket1==nil) {
        socket1=[[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    NSError *err=nil;
    if(![socket1 connectToHost:stringhostlogin onPort:[stringportlogin intValue] error:&err]) 
    { 
        NSLog(@"连接出错");
    }else
    {
        NSLog(@"ok");
    }
    
}
#pragma mark--注册
-(void)zhuce{
    NSLog(@"zhuce");
    
    alertview_zhuce=[[UIAlertView alloc]initWithTitle:@"注册" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"注册", nil];
    [alertview_zhuce show];
    
}
-(void)zhucexieru{
    NSLog(@"zoulezhucexieru");
    if (socket_zhuce==nil) {
        socket_zhuce=[[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    NSError *err=nil;
    if(![socket_zhuce connectToHost:@"222.73.211.226" onPort:26010 error:&err]) 
    { 
        NSLog(@"连接出错");
    }else
    {
        NSLog(@"ok");
    }
}
#pragma mark-登陆
-(void)denglu{
    NSUserDefaults *user_nameandmin=[NSUserDefaults standardUserDefaults];
    [user_nameandmin setObject:textfield_dengluusername.text forKey:@"name"];
    [user_nameandmin setObject:textfield_denglumin.text forKey:@"min"];
    [user_nameandmin synchronize];
    
    
    if (data1==nil) {
        data1=[[data alloc]init];
    }
    if (socket_denglu==nil) {
        socket_denglu=[[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    NSError *err=nil;
    if(![socket_denglu connectToHost:@"222.73.211.226" onPort:26010 error:&err]) 
    { 
        NSLog(@"连接出错");
    }else
    {
        NSLog(@"ok");
    }
    
}
#pragma mark-socket写入数据
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    
    NSLog(@"socket写入数据");
    if (sock==socket_zhuce) {
        NSLog(@"zoulezhuce de delegate");
        
        NSString *string_l=[NSString stringWithFormat:@"\\%@\\%@\\%@\\%@",texfield_zhuceusername.text,textfield_zhucemin.text,textfileld_zhuceemail.text,textfield_zhucephonenumber.text];
        
        short length_zhuce=string_l.length*2;
        int8_t ch[2];
        ch[0] = (length_zhuce & 0x0ff00)>>8;  
        ch[1] = (length_zhuce & 0x0ff);  
        
        
        //  NSLog(@"=====%d",sizeof(length_zhuce));
        short type=1106;
        int8_t mm[2];
        mm[0] = (type & 0x0ff00)>>8;  
        mm[1] = (type & 0x0ff);  
        
        
        int zero=0;
        //   NSData *data_length=[NSData da];
        NSMutableData *alldata=[[NSMutableData alloc]init];
        
        NSData * zeroData = [NSData dataWithBytes:&zero length:4];
        NSData *data=[string_l dataUsingEncoding:NSUTF16BigEndianStringEncoding];
        
        [alldata appendBytes:ch length:2];
        [alldata appendBytes:mm length:2];
        [alldata appendData:zeroData];
        
        [alldata appendData:data];
        NSData *requestData = [[NSMutableData alloc]init];
        requestData=alldata;
        
        [socket_zhuce writeData:requestData withTimeout:1000 tag:0];
        
        NSData *testdata=[[NSData alloc]init];
       // eightbyte *yaoxi=[[eightbyte alloc]init];
       testdata= [eightbyte shengchengdata:string_l type:type];
        NSLog(@"testdata===%@",testdata);
        NSLog(@"zhucedata===%@",requestData);
        
        
        
        NSData * separator = [@"\\" dataUsingEncoding:NSUTF16BigEndianStringEncoding];
        NSLog(@"separtor====%@",separator);
        
        // [socket_zhuce readDataToData:separator withTimeout:1000 tag:1];
              // for (int i=0; i<4; i++) {
            //       [socket_zhuce readDataWithTimeout:1000 tag:i+1];
            //  }
        [socket_zhuce readDataToLength:2 withTimeout:1000 tag:1];
        [socket_zhuce readDataToLength:2 withTimeout:1000 tag:2];
        [socket_zhuce readDataToLength:4 withTimeout:1000 tag:3];
        [socket_zhuce readDataWithTimeout:1000 tag:4];
        
    }
    
    if (sock==socket_denglu) {
        NSLog(@"进入了登陆的方法");
        NSString *request_l=[NSString stringWithFormat:@"%@\\%@",textfield_dengluusername.text,textfield_denglumin.text];
        NSLog(@"%d",request_l.length);
        
        NSData *requestData1=[[NSData alloc]init];
        requestData1=[eightbyte shengchengdata:request_l type:1101];
        [socket_denglu writeData:requestData1 withTimeout:1000 tag:0];
        
        [socket_denglu readDataToLength:2 withTimeout:1000 tag:1];
        [socket_denglu readDataToLength:2 withTimeout:1000 tag:2];
        [socket_denglu readDataToLength:4 withTimeout:1000 tag:3];
 //      [socket_denglu readDataToLength:2 withTimeout:1000 tag:4];
//        [socket_denglu readDataToLength:4 withTimeout:1000 tag:5];
      //  [socket_denglu readDataWithTimeout:1000 tag:4];
        NSData * separator = [@"\\" dataUsingEncoding:NSUTF16BigEndianStringEncoding];
        
         for (int i=0; i<4; i++) {
             [socket_denglu readDataToData:separator withTimeout:1000 tag:i+4];

       }
        

        
       // NSData * separator = [@"\\" dataUsingEncoding:NSUTF16BigEndianStringEncoding];
        
        NSLog(@"requestdata====%@",requestData1);
//        for (int i=0; i<7; i++) {
//            if (i<6) {
//                [socket_denglu readDataToData:separator withTimeout:1000 tag:i];
//                NSLog(@"%d....",i);
//            }
//            if (i==6) {
//                [socket_denglu readDataWithTimeout:1000 tag:6];
//                NSLog(@"%d....",i);
//                
//            }
//        }
    }
    
    if (sock==socket1)
    {
        NSLog(@"2cilianjie");
        NSLog(@"sessionid==%@",self.sessionid);
        NSString *request_l=[NSString stringWithFormat:@"501\\%@\\%@",data1.sessionID,data1.captchas];
        
        NSString *request1=[NSString stringWithFormat:@"%d\\%@",request_l.length*2,request_l];
        NSData *requestData1 = [request1 dataUsingEncoding:NSUTF16BigEndianStringEncoding];
        [socket1 writeData:requestData1 withTimeout:1000 tag:100];
        NSLog(@"request1=%@",request1);
        //  [self performSelectorInBackground:@selector(xianchengreaddata) withObject:nil];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            while (1) {
                sleep(2);
                [socket1 readDataWithTimeout:1000 tag:1000];
            }
            dispatch_async(dispatch_get_main_queue(),^{
                
            });
        });
    }
    
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"socket连接error");
    //  sleep(30);
    // [self lianjie];
}
#pragma mark--data的转化
//-(int32_t)read{
//    int8_t v;
//    
//}
#pragma mark-socket读出数据

-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{ //获取注册的数据
    if (sock==socket_zhuce) {
        NSLog(@"socket_zhuce读取数据%@",data);
        //NSStringEncoding *enc1=CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
        // NSData *data_zhuce=[[NSData alloc]initWithData:data];
        //newMessage = [newMessage stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        switch (tag) {
            case 1:{
               // NSData *data_length;
                int8_t v;
                [ data getBytes:&v range:NSMakeRange(0, 1)];
                int32_t ch1=(v & 0x0ff); 
                [ data getBytes:&v range:NSMakeRange(1, 1)];
                int32_t ch2=(v & 0x0ff);
                short ms=(int16_t)((ch1 << 8) + (ch2 << 0));
                NSLog(@"ms1===%d",ms);
                
            }
                // short length=[newMessage intValue]
                //NSLog(@"length=%d",length);
                //int32_t ch[2]=data;
   
                break;
            case 2:
                
            {
                int8_t v;
                [ data getBytes:&v range:NSMakeRange(0, 1)];
                int32_t ch1=(v & 0x0ff); 
                [ data getBytes:&v range:NSMakeRange(1, 1)];
                int32_t ch2=(v & 0x0ff);
                short ms=(int16_t)((ch1 << 8) + (ch2 << 0));
                NSLog(@"ms2===%d",ms);

                           break;
                
            }
            case 3:{
                int8_t v;
                [ data getBytes:&v range:NSMakeRange(0, 1)];
                int32_t ch1=(v & 0x0ff); 
                [ data getBytes:&v range:NSMakeRange(1, 1)];
                int32_t ch2=(v & 0x0ff);
               // [ data getBytes:&v range:NSMakeRange(2, 1)];
                int32_t ch3=(v & 0x0ff);
               // [ data getBytes:&v range:NSMakeRange(3, 1)];
                int32_t ch4=(v & 0x0ff);
                int ms=((ch1 << 24) + (ch2 << 16) + (ch3 << 8) + (ch4 << 0));
                NSLog(@"ms3===%d",ms);

                
            }
                break;
            case 4:{
                NSString *newMessage = [[NSString alloc] initWithData:data encoding:NSUTF16BigEndianStringEncoding];

                NSLog(@"=====================%@",newMessage);
                if ([newMessage isEqualToString:@"1"]) {
                    alertviewzhucejieguo=[[UIAlertView alloc]initWithTitle:@"恭喜" message:@"注册成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertviewzhucejieguo show];
                }else {
                    alertviewzhucejieguo=[[UIAlertView alloc]initWithTitle:@"提示" message:@"注册失败" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                    [alertviewzhucejieguo show];

                }
            }
                
                break;
                
                
            default:
                break;
        }   
        
    }
    
    //获取登陆的数据
    if (sock==socket_denglu) {
        NSLog(@"登陆取数据啊");
        NSString *newMessage = [[NSString alloc] initWithData:data encoding:NSUTF16BigEndianStringEncoding];
        newMessage = [newMessage stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        // NSLog(@"=======%@",newMessage);
        switch (tag) {
            case 1:{
                NSLog(@"取得长度");
            }
                break;
            case 2:
            {
                NSLog(@"取得type");
            }
                break;
            case 3:
            {
                NSLog(@"取得什么");
                
//                if ([newMessage intValue]>0) {
//                    data1.publisherIPandPort=[NSString stringWithFormat:newMessage];
//                    NSString *stringbiaoshi=@":";
//                    NSRange range1=[data1.publisherIPandPort rangeOfString:stringbiaoshi];
//                    stringhostlogin=[data1.publisherIPandPort substringWithRange:NSMakeRange(0, range1.location)];
//                    stringportlogin = [data1.publisherIPandPort substringFromIndex:range1.location+1];
//                    NSLog(@"publisherIPandPort======================%@",data1.publisherIPandPort);
//                    NSLog(@"stringport====%@",stringportlogin);
//                    NSLog(@"host===%@",stringhostlogin);
//                    NSUserDefaults *userstringhost=[NSUserDefaults standardUserDefaults];
//                    [userstringhost setObject:stringhostlogin forKey:@"host"];
//                    [userstringhost synchronize];
//                    
//                    NSUserDefaults *userstringport=[NSUserDefaults standardUserDefaults];
//                    [userstringport setObject:stringportlogin forKey:@"port"];
//                    [userstringport synchronize];
//                }
                
                
                break;
                
            }
            case 4:{
                
                NSLog(@"newmessage4=========================%@",newMessage);
               // newmessage=========================1222.73.211.226:2600085966015110784066761234XAGUSD,45,1/AgT+D,30,1/AuT+D,31,1/USD,32,3/AG1207,33,1/AG1208,34,1/AG1209,35,1/AG1210,36,1/AG1211,37,1/AG1212,38,1/AG1301,39,1/AG1302,40,1/AG1303,41,1/AG1304,42,1/AG1305,43,1/AG1306,44,1/PD,46,1/PT,47,1
                data1.result=[[newMessage substringToIndex:1]intValue];
                NSLog(@"data1.result===%d",data1.result);
                
                
                

                
//                data1.sessionID=[NSString stringWithFormat:newMessage];
//                data1.sessionidlength=data1.sessionID.length;
//                NSLog(@"data1.sessionID======%@",data1.sessionID);
//                NSUserDefaults *userid=[NSUserDefaults standardUserDefaults];
//                [userid setObject:data1.sessionID forKey:@"id"];
//                [userid synchronize];
                
                
                break;}
            case 5:
            {                NSLog(@"newmessage5=========================%@",newMessage);
                
                
                                if (newMessage!=nil) {
                                   data1.publisherIPandPort=[NSString stringWithFormat:newMessage];
                                   NSString *stringbiaoshi=@":";
                                   NSRange range1=[data1.publisherIPandPort rangeOfString:stringbiaoshi];
                                   stringhostlogin=[data1.publisherIPandPort substringWithRange:NSMakeRange(0, range1.location)];
                                   stringportlogin = [data1.publisherIPandPort substringFromIndex:range1.location+1];
                                   NSLog(@"publisherIPandPort======================%@",data1.publisherIPandPort);
                                   NSLog(@"stringport====%@",stringportlogin);
                                   NSLog(@"host===%@",stringhostlogin);
                                   NSUserDefaults *userstringhost=[NSUserDefaults standardUserDefaults];
                                   [userstringhost setObject:stringhostlogin forKey:@"host"];
                                  [userstringhost synchronize];
                                   
                                   NSUserDefaults *userstringport=[NSUserDefaults standardUserDefaults];
                                    [userstringport setObject:stringportlogin forKey:@"port"];
                                   [userstringport synchronize];
                               }

                
                
                

//                data1.captchas=[NSString stringWithFormat:newMessage];
//                NSLog(@"captchas===%@",data1.captchas);
//                data1.captchaslength=data1.captchas.length;
//                data1.totallength=(3+1+data1.sessionidlength+1+data1.captchaslength)*2;
//                NSLog(@"totallength===========%d",data1.totallength);
//                NSUserDefaults *usercaptchas=[NSUserDefaults standardUserDefaults];
//                [usercaptchas setObject:data1.captchas forKey:@"captchas"];
//                [usercaptchas synchronize];
                break;
            }
                
            case 6:{
                NSLog(@"resultstring6====%@",newMessage);
                //data1.result=[newMessage intValue];
            }            
                // [self performSelectorInBackground:@selector(nihao) withObject:nil];
                
                break;
            case 7:{
                NSLog(@"newMessage7======%@",newMessage);
               // data1.ndicate=[NSString stringWithFormat:newMessage];
                // [Personaldetail addproductname:@"ss" id:@"12" type:@"32"];
                // NSString * str = @"AgT+D,1,1/AuT+D,2,1/USD,3,3/AG1207,4,1/AG1208,5,1/AG1209,6,1/AG1210,7,1/AG1211,8,1/AG1212,9,1/AG1301,10,1/AG1302,11,1/AG1303,12,1/AG1304,13,1/AG1305,14,1/AG1306,15,1/XAGUSD,16,1/PD,17,1/PT,18,1";
//                NSString * str = [NSString stringWithFormat:newMessage];
//                
//                
//                NSArray   *arr = [str componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/"]];//去掉斜杠，把字符串转化成数组
//                NSLog(@"%@",arr);
//                NSString * str1=@",";
//                NSMutableArray * array_name = [[NSMutableArray alloc] init];
//                NSMutableArray * array_id = [[NSMutableArray alloc] init];
//                NSMutableArray * array_type = [[NSMutableArray alloc] init];
//                for (NSString * ing in arr) {
//                    NSRange range = [ing rangeOfString:str1];
//                    NSString * str3 = [ing substringToIndex:range.location] ;
//                    NSString * str4 = [ing substringFromIndex:range.location+1];
//                    
//                    NSRange range1 =[str4 rangeOfString:str1];
//                    NSString * str5 = [str4 substringToIndex:range1.location];
//                    NSString * str6 = [str4 substringFromIndex:range1.location+1];
//                    [array_id addObject:str5];
//                    [array_type addObject:str6];
//                    [array_name addObject:str3];
//                }
//                NSMutableArray *array_totalname=[Personaldetail findall];
//                NSLog(@"totanarray=%d",[array_totalname count]);
//                
//                NSLog(@"arrayname = %@,%d",array_name,array_name .count);
//                NSLog(@"arrayid = %@,%d",array_id,array_id .count);
//                NSLog(@"arraytype = %@,%d",array_type,array_type .count);
//                if ([array_totalname count]<[array_name count]) {
//                    for (int i=[array_name count]; i>[array_totalname count]; i--) {
//                        [ Personaldetail addproductname:[array_name objectAtIndex:i-1] id:[array_id objectAtIndex:i-1] type:[array_type objectAtIndex:i-1]];
//                    }
//                }else {
//                    NSLog(@"数据库不需要更新");
//                }
                
              //  [self performSelector:@selector(backtorootviewC)];
                
                // data1.re=[newMessage intValue];
            }            
                
                break;
                
                
                
            default:
                break;
        }   
        
    }
    
    
    
    
    
    
    //连接取得数据
    if (sock==socket1) {
        NSLog(@"%ld",tag);
        // NSLog(@"第二次得到的数据%");
        NSString *newMessage2 = [[NSString alloc] initWithData:data encoding:NSUTF16BigEndianStringEncoding];
        count++;
        
        if (count>3) {
            NSArray * arr = [newMessage2 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\\"]];
            NSLog(@"第%d次arr=======%@",count,arr);
            for (int i=0; i<[arr count]; i++) 
            {
                if ([[arr objectAtIndex:i]isEqualToString:@"1000"]||[[arr objectAtIndex:i]isEqualToString:@"1001"]) {
                    if ((i+7)<[arr count]) {
                        _data2.type=@"1000";
                        _data2.code=[arr objectAtIndex:i+1];
                        NSLog(@"code======%@",_data2.code);
                        _data2.quotetime=[arr objectAtIndex:i+2];
                        _data2.last=[arr objectAtIndex:i+3];
                        _data2.open=[arr objectAtIndex:i+4];
                        _data2.high=[arr objectAtIndex:i+5];
                        _data2.low=[arr objectAtIndex:i+6];
                        _data2.volumne=[arr objectAtIndex:i+7];
                        NSLog(@"data2.open==%@",_data2.open);
                        
                    }
                    
                    if (![_data2.code isEqualToString:@"16"]&&![_data2.code isEqualToString:@"17"]&&![_data2.code isEqualToString:@"18"]&&(i+32)<[arr count]) {
                        _data2.changne=[arr objectAtIndex:i+32];
                    }
                    array1000=[[NSArray alloc]initWithObjects:_data2.code,_data2.last,_data2.high,_data2.low,_data2.changne, nil];
                    NSLog(@"array1000%@",array1000);
                    // [Personaldetail upDateWithOpen:_data2.open High:_data2.high Low:_data2.low Vlume:_data2.changne Time:_data2.quotetime fromid:_data2.code];
                    [Personaldetail upDateWithOpen:_data2.open High:_data2.high Low:_data2.low Vlume:_data2.changne Time:_data2.quotetime Last:_data2.last fromid:_data2.code];
                    [mytableview_productdetail reloadData];
                    
                }
            }
        }
        
    }
    
    
}


-(void)backtorootviewC{
    NSLog(@"data1.result==%d",data1.result);
    
    switch (data1.result) {
        case 1:
        {
            // [self dismissModalViewControllerAnimated:NO];
            [self lianjie];
            // MarketViewController *aview=[[MarketViewController alloc]init];
            // [self.navigationController pushViewController:aview animated:NO];
            // [self presentModalViewController:aview animated:NO];
            
        }
            break;
        case 2:{
            alertviewdenglujieguo=[[UIAlertView alloc]initWithTitle:@"登录失败" message:@"用户不存在" delegate:self cancelButtonTitle:@"请重新登录"otherButtonTitles:@"确定", nil];
            signin=0;
            [alertviewdenglujieguo show];
            
        }
            
            break;
        case 3:
        {
            alertviewdenglujieguo=[[UIAlertView alloc]initWithTitle:@"登录失败" message:@"密码不正确" delegate:self cancelButtonTitle:@"请重新登录" otherButtonTitles:@"取消", nil];
            signin=0;
            
            [alertviewdenglujieguo show];
            
        }
            break;
        case 4:
        {
            alertviewdenglujieguo=[[UIAlertView alloc]initWithTitle:@"登陆失败" message:@"服务器未启动" delegate:self cancelButtonTitle:@"请稍后登陆" otherButtonTitles:nil, nil];
            signin=0;
            
            [alertviewdenglujieguo show];
        }
            break;
        case 8:
        {
            alertviewdenglujieguo=[[UIAlertView alloc]initWithTitle:@"登录失败" message:@"帐号过期" delegate:self cancelButtonTitle:@"请重新申请帐号" otherButtonTitles:nil, nil];
            signin=0;
            
            [alertviewdenglujieguo show];
        }
            break;
        case 9:
        {
            alertviewdenglujieguo=[[UIAlertView alloc]initWithTitle:@"登陆失败" message:@"帐号未激活" delegate:self cancelButtonTitle:@"请激活后登陆" otherButtonTitles:nil, nil];
            [alertviewdenglujieguo show];
            signin=0;
            
        }
            break;
            
        default:
            break;
    }
}


#pragma mark-设置产品和字段
-(void)setup{
    ProductSelectViewController *productselect=[[ProductSelectViewController alloc]init];
    [self.navigationController pushViewController:productselect animated:YES];
    
}
#pragma mark-取消第一响应
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"dasdasdsadsa");
    [textfileld_zhuceemail resignFirstResponder];
    [textfield_zhuceqmin resignFirstResponder];
    [textfield_zhucephonenumber resignFirstResponder];
    [textfield_zhucemin resignFirstResponder];
    [textfield_dengluusername resignFirstResponder];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    NSLog(@"22222");
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    array_ziduan=[user objectForKey:@"ziduan"];
    
    NSUserDefaults *user_forex=[NSUserDefaults standardUserDefaults];
    switch (biaozhiwei) {
        case 0:
            array_product=[user_forex objectForKey:@"forex"];
            break;
        case 1:
            array_product=[user_forex objectForKey:@"preciousmetal"];
            
            break;
        case 2:
            array_product=[user_forex objectForKey:@"exponent"];
            
            break;
            
        default:
            break;
    }
    NSLog(@"countarray_product=%d",[array_product count]);
    
    if (interfaceOrientation==UIInterfaceOrientationPortrait||interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        rect_aview=CGRectMake(0, 0, 320, 480-44-49-17);
        rect_viewproductnameheader=CGRectMake(0, 0, 100, 30);
        rect_prodcuctdetailheader=CGRectMake(0, 0, 220, 30);
        rect_scrowview_cellsc=CGRectMake(100, 0, 320-100,[array_product count]*44+100);
        rect_scrowviewheader=CGRectMake(100, 0, 220, 30);
        rect_scr_total=CGRectMake(0, 30, 320, 480-17-44-49);
        rect_tableviewproductname=CGRectMake(0, 0, 100, [array_product count]*44+100);
        rect_tableviewproductdetail=CGRectMake(0, 0,[array_ziduan count]*110,[array_product count]*44+100);
        
        aview.frame=CGRectMake(0, 0, 320, 480-44-49-17);
        view_productnameheader.frame=CGRectMake(0, 0, 100, 30);
        view_productdetailheader.frame=CGRectMake(0, 0, 220, 30);
        scrowview_cellsc.frame=CGRectMake(100, 0, 320-100,[array_product count]*44+100);
        scrowviewheader.frame=CGRectMake(100, 0, 220, 30);
        scr_total.frame=rect_scr_total;
        mytableview_productname.frame=rect_tableviewproductname;
        mytableview_productdetail.frame=rect_tableviewproductdetail;
        
        scrowview_cellsc.contentSize=CGSizeMake([array_ziduan count]*110, 0);
        scrowviewheader.contentSize=scrowview_cellsc.contentSize;
        
        
        self.self_view_frame_size_width = 320;
    }
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft||interfaceOrientation==UIInterfaceOrientationLandscapeRight) {
        rect_aview=CGRectMake(0, 0, 480, 320-44-49);
        rect_viewproductnameheader=CGRectMake(0, 0, 100, 30);
        rect_prodcuctdetailheader=CGRectMake(0, 0, 370, 30);
        rect_scrowviewheader=CGRectMake(100, 0, 370, 30);
        rect_scrowview_cellsc=CGRectMake(100, 0, 480-100, [array_product count]*44+100);
        rect_scr_total=CGRectMake(0, 30, 480, 320-44-49);
        rect_tableviewproductname=CGRectMake(0, 0, 100, [array_product count]*44+100);
        rect_tableviewproductdetail=CGRectMake(0, 0, [array_ziduan count]*110,[array_product count]*44+100);
        
        aview.frame=rect_aview;
        view_productnameheader.frame=rect_viewproductnameheader;
        view_productdetailheader.frame=rect_viewproductdetailheader;
        scrowview_cellsc.frame=rect_scrowview_cellsc;
        scrowviewheader.frame=rect_scrowviewheader;
        scr_total.frame=rect_scr_total;
        mytableview_productname.frame=rect_tableviewproductname;
        mytableview_productdetail.frame=rect_tableviewproductdetail;
        scrowview_cellsc.contentSize=CGSizeMake([array_ziduan count]*110, 0);
        scrowviewheader.contentSize=scrowview_cellsc.contentSize;
        self.self_view_frame_size_width = 480;
        
    }
    return YES;
    NSLog(@"执行了改变tableviewfram");
    
}

@end
