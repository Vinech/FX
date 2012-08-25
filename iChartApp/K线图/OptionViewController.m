//
//  OptionViewController.m
//  chartee
//
//  Created by Tcy vinech on 12-7-25.
//  Copyright 2011 vinech_Tcy. All rights reserved.
//

#import "OptionViewController.h"
#import "CandleViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface OptionViewController ()

@end

@implementation OptionViewController
@synthesize delegate = _delegate;
@synthesize periodEma,periodAdx,periodCci,periodMom,periodRsi,periodSma,periodWma,periodBoll,periodMacd,longMacdPeriod,shortMacdPeriod,kPeriod,dPeriod,jPeriod,bandDeviation;//技术指标周期
@synthesize dataArray;
@synthesize dataArraynew;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//- (void)initWithviewframe:(CGRect)frame

- (void)initWithframe:(CGRect)frame Text:(NSString *)texts theviews:(UIView *)theview tag:(int )tag 
{
    
    tf = [[UITextField alloc] initWithFrame:frame];
    tf.tag =tag;
    tf.text = texts;    
    tf.delegate = self;
    tf.layer.cornerRadius= 8;
    tf.keyboardType = UIKeyboardTypePhonePad;
    tf.textAlignment = UITextAlignmentCenter;
    tf.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:25];
    tf.backgroundColor = [UIColor orangeColor];
    tf.textColor = [UIColor whiteColor];
    [theview addSubview:tf];
}

- (void)initWithframeLabel:(CGRect )frame Text:(NSString *)text theviews:(UIView*)theviews
{
    labeName = [[UILabel alloc]initWithFrame:frame];
    labeName.textColor = [UIColor whiteColor];
    labeName.backgroundColor = [UIColor clearColor];
    labeName.text = text;
    [theviews addSubview:labeName];
    
}
- (void)barbutton
{
    // backviews.frame = CGRectMake(480, 480, 50, 30);
    self.dataArray = [NSMutableArray arrayWithObjects:@"7",@"10",@"10",@"20",@"2.0",@"10",@"26",@"12",@"9",@"60",@"60",@"60",@"14",@"10",@"9", nil];
    
    //backviews.frame = CGRectMake(backviews_frame_origin_x, backviews_frame_origin_y,backviews_frame_size_width,backviews_frame_size_height);
    switchs.on = NO;
    //    [tabV reloadData];
    
    
    for (int s = 0;s<self.dataArray.count;s++) 
    {
        
        UITextField * textField = (UITextField *)[self.view viewWithTag:s+1001];
        textField.text = [self.dataArray objectAtIndex:s];
        
    }
    
}

- (void)backButton:(UIBarButtonItem *)sender
{
    if (sender.tag!=99) 
    {
        UITextField * tfs = (UITextField *)[self.view viewWithTag:sender.tag];
        [self.dataArray replaceObjectAtIndex:tfs.tag-1001 withObject:tfs.text];
    }
    //        if (_delegate==nil && [_delegate respondsToSelector:@selector(popToRoot:)]) 
    //      {
    [delegate popToRoot:self.dataArray pointPhone:pointPhone];
    //        }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    NSLog(@"dayinlejici");
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
    barback = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backButton:)];
    self.navigationItem.leftBarButtonItem= barback;
    barback.tag = 99;
    
    
    
    aView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    aView.backgroundColor = [UIColor blackColor];
    self.view = aView;
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"默认值" style:UIBarButtonItemStyleDone target:self action:@selector(barbutton)];
    self.navigationItem.rightBarButtonItem = bar;
    
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    CGSize newSize = CGSizeMake(320,1560);
    [scrollView setContentSize:newSize];
    //是否自由滑动 
    [scrollView setPagingEnabled:NO];
    //不显示垂直滚动条
    [scrollView setShowsVerticalScrollIndicator:YES];
    //不显示水平滚动条
    [scrollView setShowsHorizontalScrollIndicator:NO];
    //代理方法
    [scrollView setDelegate:self];
    [scrollView setBackgroundColor:[UIColor clearColor]];//设置背景以区分view与scrollview
    [self.view addSubview:scrollView];
    
    
    tabV =[[UITableView alloc]initWithFrame:CGRectMake(0,0, 320, 1400) style:UITableViewStyleGrouped];
    tabV.delegate = self;
    tabV.dataSource=self;
    tabV.separatorColor = [UIColor whiteColor];
    tabV.backgroundColor = [UIColor clearColor];
    tabV.scrollEnabled = NO;
    [scrollView addSubview:tabV];
    
    
    backviews = [[UIView alloc] initWithFrame:CGRectMake(260, 480, 50, 50)];
    backviews.backgroundColor= [UIColor clearColor];
    [self.view addSubview:backviews];
    
    button = [UIButton  buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake(0, 0,50, 50);
    [button addTarget:self action:@selector(tfButton:) forControlEvents:UIControlEventTouchUpInside];
    [backviews  addSubview:button];
    
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.frame = CGRectMake(10, 15, 30, 30);
    imageV.image = [UIImage imageNamed:@"dele.png"];
    [backviews addSubview:imageV];
    
    arratPreiod = [[NSArray alloc] initWithObjects:@"SMA",@"WMA",@"EMA",@"Boll",@"RSI",@"MACD",@"KDJ",@"CCI",@"Mom",@"ADX", nil];
    arrayDetia  = [[NSArray alloc] initWithObjects:@"Simple Moving Average",@"Weighted Moving Average",@"Exponential Moving Average" ,@"Bollinger Bands ",@"Relative Strength Index",@"Moving Average Convergence Divergence",@"Stochastic Ossilator",@"Commodity Channel Index",@"Momentum",@"Average Directional Movement Index",nil];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 5 &&indexPath.row == 0) {
        return 150;
    }
    if (indexPath.section == 6 &&indexPath.row == 0) {
        return 150;
    }
    if (indexPath.section == 3 &&indexPath.row ==0) {
        return 100;
    }
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    headerview =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320,40)];
    headerview.backgroundColor = [UIColor clearColor];
    
    headerlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 40)];
    headerlabel.textColor = [UIColor whiteColor];
    headerlabel.text = [arratPreiod objectAtIndex:section];
    headerlabel.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:20];
    headerlabel.backgroundColor = [UIColor clearColor];
    [headerview  addSubview:headerlabel];
    
    headerlabeldetia = [[UILabel alloc] initWithFrame:CGRectMake(80,0, 230, 40)];
    headerlabeldetia.textColor = [UIColor whiteColor];
    headerlabeldetia.text = [arrayDetia objectAtIndex:section];
    headerlabeldetia.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:15];
    headerlabeldetia.backgroundColor = [UIColor clearColor];
    [headerview  addSubview:headerlabeldetia];
    
    return headerview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    
//    return [arratPreiod objectAtIndex:section];
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strCell = @"Cells";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
    }
    
    for ( UIView * view in cell.contentView.subviews) {
        [view  removeFromSuperview];
    }
    
    
    cell.backgroundColor = [UIColor blackColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.tag = 99999;
    
    
    switchs =[[UISwitch alloc] initWithFrame:CGRectMake(swichs_frame_origin_x,swichs_frame_origin_y, swichs_frame_size_width, swichs_frame_size_height)];
    switchs.tag = indexPath.row;
    
    [switchs addTarget:self action:@selector(switchs:) forControlEvents:UIControlEventValueChanged];
    [cell.contentView addSubview:switchs];
    
    
    
    
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        
        
        [self initWithframe:CGRectMake(text_frarm_origin_x,text_frarm_origin_y, text_frarm_size_width, text_frarm_size_height) Text:[self.dataArray objectAtIndex:0] theviews:cell.contentView tag:1001];
        [self initWithframeLabel:CGRectMake(label_frarm_origin_x,label_frarm_origin_y,label_frarm_size_width,label_frarm_size_height) Text:@"参数:" theviews:cell.contentView];
        
        
        switchs.on = YES;
        
    }if (indexPath.section == 1 && indexPath.row == 0) {
        
        
        
        [self initWithframe:CGRectMake(text_frarm_origin_x,text_frarm_origin_y, text_frarm_size_width, text_frarm_size_height)  Text:[self.dataArray objectAtIndex:1] theviews:cell.contentView tag:1002];
        [self initWithframeLabel:CGRectMake(label_frarm_origin_x,label_frarm_origin_y,label_frarm_size_width,label_frarm_size_height) Text:@"参数:" theviews:cell.contentView];
        
    }if (indexPath.section == 2 && indexPath.row == 0) {
        
        [self initWithframe:CGRectMake(text_frarm_origin_x,text_frarm_origin_y, text_frarm_size_width, text_frarm_size_height) Text:[self.dataArray objectAtIndex:2] theviews:cell.contentView tag:1003];
        [self initWithframeLabel:CGRectMake(label_frarm_origin_x,label_frarm_origin_y,label_frarm_size_width,label_frarm_size_height) Text:@"参数:" theviews:cell.contentView];
        switchs.on =YES;
        
    }if (indexPath.section == 3 && indexPath.row == 0) {
        
        [self initWithframe:CGRectMake(text_frarm_origin_x,text_frarm_origin_y, text_frarm_size_width, text_frarm_size_height) Text:[self.dataArray objectAtIndex:3] theviews:cell.contentView tag:1004];
        [self initWithframe:CGRectMake(text_frarm_origin_x1,text_frarm_origin_y1, text_frarm_size_width1, text_frarm_size_height1)  Text:[self.dataArray objectAtIndex:4] theviews:cell.contentView tag:1005];
        [self initWithframeLabel:CGRectMake(label_frarm_origin_x,label_frarm_origin_y,label_frarm_size_width,label_frarm_size_height) Text:@"参数" theviews:cell.contentView];
        [self initWithframeLabel:CGRectMake(label_frarm_origin_x1,label_frarm_origin_y1,label_frarm_size_width1,label_frarm_size_height1) Text:@"bandDeviation" theviews:cell.contentView];
        switchs.on =YES;
        
    }if (indexPath.section == 4 && indexPath.row == 0) {
        
        [self initWithframe:CGRectMake(text_frarm_origin_x,text_frarm_origin_y, text_frarm_size_width, text_frarm_size_height)  Text:[self.dataArray objectAtIndex:5] theviews:cell.contentView tag:1006];
        [self initWithframeLabel:CGRectMake(label_frarm_origin_x,label_frarm_origin_y,label_frarm_size_width,label_frarm_size_height)Text:@"参数:" theviews:cell.contentView];
        
        switchs.on =YES;
        
        
    }if (indexPath.section == 5 && indexPath.row == 0) {
        
        [self initWithframe:CGRectMake(text_frarm_origin_x,text_frarm_origin_y, text_frarm_size_width, text_frarm_size_height)  Text:[self.dataArray objectAtIndex:6] theviews:cell.contentView tag:1007];
        [self initWithframe:CGRectMake(text_frarm_origin_x1,text_frarm_origin_y1, text_frarm_size_width1, text_frarm_size_height1)  Text:[self.dataArray objectAtIndex:7] theviews:cell.contentView tag:1008];
        
        [self initWithframe:CGRectMake(text_frarm_origin_x2,text_frarm_origin_y2, text_frarm_size_width2, text_frarm_size_height2) Text:[self.dataArray objectAtIndex:8] theviews:cell.contentView tag:1009];
        
        [self initWithframeLabel:CGRectMake(label_frarm_origin_x,label_frarm_origin_y,label_frarm_size_width,label_frarm_size_height) Text:@"参数:" theviews:cell.contentView];
        [self initWithframeLabel:CGRectMake(label_frarm_origin_x1,label_frarm_origin_y1,label_frarm_size_width1,label_frarm_size_height1) Text:@"LongMacd:" theviews:cell.contentView];
        [self initWithframeLabel:CGRectMake(label_frarm_origin_x2,label_frarm_origin_y2,label_frarm_size_width2,label_frarm_size_height2) Text:@"ShortMacd:" theviews:cell.contentView];
        switchs.on =YES;
        
        
    }if (indexPath.section == 6 && indexPath.row == 0) {
        
        [self initWithframe:CGRectMake(text_frarm_origin_x,text_frarm_origin_y, text_frarm_size_width, text_frarm_size_height)  Text:[self.dataArray objectAtIndex:9] theviews:cell.contentView tag:1010];
        [self initWithframe:CGRectMake(text_frarm_origin_x1,text_frarm_origin_y1, text_frarm_size_width1, text_frarm_size_height1)  Text:[self.dataArray objectAtIndex:10] theviews:cell.contentView tag:1011];
        [self initWithframe:CGRectMake(text_frarm_origin_x2,text_frarm_origin_y2, text_frarm_size_width2, text_frarm_size_height2) Text:[self.dataArray objectAtIndex:11] theviews:cell.contentView tag:1012];
        
        
        [self initWithframeLabel:CGRectMake(label_frarm_origin_x,label_frarm_origin_y,label_frarm_size_width,label_frarm_size_height) Text:@"KPeriod:" theviews:cell.contentView];
        [self initWithframeLabel:CGRectMake(label_frarm_origin_x1,label_frarm_origin_y1,label_frarm_size_width1,label_frarm_size_height1) Text:@"DPeriod" theviews:cell.contentView];
        [self initWithframeLabel:CGRectMake(label_frarm_origin_x2,label_frarm_origin_y2,label_frarm_size_width2,label_frarm_size_height2) Text:@"JPeriod" theviews:cell.contentView];
        
        switchs.on =YES;
        
    }if (indexPath.section == 7 && indexPath.row == 0) {
        
        [self initWithframe:CGRectMake(text_frarm_origin_x,text_frarm_origin_y, text_frarm_size_width, text_frarm_size_height)  Text:[self.dataArray objectAtIndex:12] theviews:cell.contentView tag:1013];
        
        [self initWithframeLabel:CGRectMake(label_frarm_origin_x,label_frarm_origin_y,label_frarm_size_width,label_frarm_size_height) Text:@"参数:" theviews:cell.contentView];
        switchs.on =YES;
        
    }if (indexPath.section == 8 && indexPath.row == 0) {
        
        [self initWithframe:CGRectMake(text_frarm_origin_x,text_frarm_origin_y, text_frarm_size_width, text_frarm_size_height)  Text:[self.dataArray objectAtIndex:13] theviews:cell.contentView tag:1014];
        
        [self initWithframeLabel:CGRectMake(label_frarm_origin_x,label_frarm_origin_y,label_frarm_size_width,label_frarm_size_height) Text:@"参数:" theviews:cell.contentView];
        
        switchs.on =YES;
        
    }if (indexPath.section == 9 && indexPath.row == 0) {
        
        [self initWithframe:CGRectMake(text_frarm_origin_x,text_frarm_origin_y, text_frarm_size_width, text_frarm_size_height)  Text:[self.dataArray objectAtIndex:14] theviews:cell.contentView tag:1015];
        
        [self initWithframeLabel:CGRectMake(label_frarm_origin_x,label_frarm_origin_y,label_frarm_size_width,label_frarm_size_height) Text:@"参数:" theviews:cell.contentView];
        
        switchs.on =YES;
    }
    
    
    
    
    return cell;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"textField == %d",textField.tag);
    button.tag  =  textField.tag;
    barback.tag =  textField.tag;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    if (pointPhone == 480) {
        backviews.frame = CGRectMake(420,55,60,50);
    }else {
        backviews.frame = CGRectMake(backviews_frame_origin_x,backviews_frame_origin_y,backviews_frame_size_width,backviews_frame_size_height);
        
    }
    [UIView commitAnimations];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    
    
    if ([[self.dataArray objectAtIndex:(textField.tag-1001)] isEqual:textField.text]) 
    {
        
    }else
    {
        //        NSMutableArray * array1 = [[NSMutableArray alloc] init];
        //        array1 = self.dataArray;
        NSLog(@"selfffffffuck = %@",self.dataArray);
        // NSLog(@"tag == %@",[self.dataArray objectAtIndex:(textField.tag-1001)]);
        [self.dataArray replaceObjectAtIndex:(textField.tag-1001) withObject:textField.text];
        
        //        self.dataArray = array1;
        //        [self.dataArray removeObjectAtIndex:(textField.tag-1001)];
        //        [self.dataArray insertObject:textField.text atIndex:(textField.tag-1001)];
        
        
        
    }
    
    
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)tfButton:(UIButton *)sender
{   
    
    UITextField *tt=(UITextField *)[self.view viewWithTag:sender.tag];
    
    [tt resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    backviews.frame = CGRectMake(260, 480, 50, 50);
    [UIView commitAnimations];
}

- (void)switchs:(UISwitch *)sender
{
    if (sender.on) {
        switch (sender.tag) {
            case 0:
            {
                NSLog(@"0");
            }
                break;
            case 1:
            {
                NSLog(@"1");
            }
                break;
            case 2:
            {
                NSLog(@"2");
            }
                break;
            case 3:
            {
                NSLog(@"3");
            }
                break;
            case 4:
            {
                NSLog(@"4");
            }
                break;
            case 5:
            {
                NSLog(@"5");
            }
                break;
            case 6:
            {
                NSLog(@"6");
            }
                break;
            case 7:
            {
                NSLog(@"7");
            }
                break;
            case 8:
            {
                NSLog(@"8");
            }
                break;
            case 9:
            {
                NSLog(@"9");
            }
                break;
                
            default:
                break;
        }
    }else {
        switch (sender.tag) {
            case 0:
            {
                NSLog(@"0off");
            }
                break;
            case 1:
            {
                NSLog(@"1off");
            }
                break;
            case 2:
            {
                NSLog(@"2off");
            }
                break;
            case 3:
            {
                NSLog(@"3off");
            }
                break;
            case 4:
            {
                NSLog(@"4off");
            }
                break;
            case 5:
            {
                NSLog(@"5off");
            }
                break;
            case 6:
            {
                NSLog(@"6off");
            }
                break;
            case 7:
            {
                NSLog(@"7off");
            }
                break;
            case 8:
            {
                NSLog(@"8off");
            }
                break;
            case 9:
            {
                NSLog(@"9off");
            }
                break;
                
            default:
                break;
        }
        NSLog(@"oFF");
    }
}


-(void)setDelegate:(id<OptionViewControllerDelegate>)theDelegate
{
    delegate = theDelegate;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        
        NSLog(@"---------------------------------------");
        aView.frame                 = CGRectMake(0, 0, 480, 320);
        scrollView.frame            = CGRectMake(0, 0, 480, 320);
        scrollView.contentSize      = CGSizeMake(480,1480);
        tabV.frame                  = CGRectMake(0,0, 480, 1270);
        backviews.frame             = CGRectMake(480, 320, 60, 50);
        switchs.frame               = CGRectMake(320, 10, 60, 30);
        tf.frame                    = CGRectMake(150, 10, 150, 30);
        labeName.frame              = CGRectMake(20, 10, 130, 30);
        
        swichs_frame_origin_x       = 350;
        swichs_frame_origin_y       = 10;
        swichs_frame_size_width     = 60;
        swichs_frame_size_height    = 30;
        
        text_frarm_origin_x         = 150;
        text_frarm_origin_y         = 10;
        text_frarm_size_width       = 150;
        text_frarm_size_height      = 30;
        
        
        text_frarm_origin_x1        = 150;
        text_frarm_origin_y1        = 50;
        text_frarm_size_width1      = 150;
        text_frarm_size_height1     = 30;
        
        
        text_frarm_origin_x2        = 150;
        text_frarm_origin_y2        = 90;
        text_frarm_size_width2      = 150;
        text_frarm_size_height2     = 30;
        
        
        label_frarm_origin_x        = 20;
        label_frarm_origin_y        = 10;
        label_frarm_size_width      = 130;
        label_frarm_size_height     = 30;
        
        label_frarm_origin_x1       = 20;
        label_frarm_origin_y1       = 50;
        label_frarm_size_width1     = 130;
        label_frarm_size_height1    = 30;
        
        label_frarm_origin_x2       = 20;
        label_frarm_origin_y2       = 90;
        label_frarm_size_width2     = 130;
        label_frarm_size_height2    = 30;
        pointPhone = 480;
        
        [tabV reloadData];
        // self.tabBarController.tabBar.frame = CGRectMake(0,271,480,49);
        
    }else {
        
        pointPhone = 320;
        NSLog(@"+++++++++++++++++++++++++++++++++++++++++");
        aView.frame                 = CGRectMake(0, 0, 320, 480);
        scrollView.frame            = CGRectMake(0, 0, 320, 480);
        scrollView.contentSize      = CGSizeMake(320,1560);
        tabV.frame                  = CGRectMake(0,0, 320, 1400);
        backviews.frame             = CGRectMake(260, 480, 50, 50);
        switchs.frame               = CGRectMake(220, 10, 60, 50);
        tf.frame                    = CGRectMake(100, 10, 100, 30);
        labeName.frame              = CGRectMake(10, 10, 90, 30);
        
        swichs_frame_origin_x       = 220;
        swichs_frame_origin_y       = 10;
        swichs_frame_size_width     = 150;
        swichs_frame_size_height    = 30;
        
        
        backviews_frame_origin_x    = 260;
        backviews_frame_origin_y    = 150;
        backviews_frame_size_width  = 50;
        backviews_frame_size_height = 50;
        
        text_frarm_origin_x         = 100;
        text_frarm_origin_y         = 10;
        text_frarm_size_width       = 100;
        text_frarm_size_height      = 30;
        
        
        text_frarm_origin_x1        = 100;
        text_frarm_origin_y1        = 50;
        text_frarm_size_width1      = 100;
        text_frarm_size_height1     = 30;
        
        text_frarm_origin_x2        = 100;
        text_frarm_origin_y2        = 90;
        text_frarm_size_width2      = 100;
        text_frarm_size_height2     = 30;
        
        
        label_frarm_origin_x        = 10;
        label_frarm_origin_y        = 10;
        label_frarm_size_width      = 90;
        label_frarm_size_height     = 30;
        
        label_frarm_origin_x1       = 10;
        label_frarm_origin_y1       = 50;
        label_frarm_size_width1     = 90;
        label_frarm_size_height1    = 30;
        
        label_frarm_origin_x2       = 10;
        label_frarm_origin_y2       = 90;
        label_frarm_size_width2     = 90;
        label_frarm_size_height2    = 30;
        
        [tabV reloadData];
        
        
    }
    return YES;
}
@end
