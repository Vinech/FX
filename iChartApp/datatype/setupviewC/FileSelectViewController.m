//
//  FileSelectViewController.m
//  iChartApp
//
//  Created by vinech.SZK on 12-8-10.
//  Copyssright (c) 2012年 __MyCompanyName__. All rights reserved.
//ss

#import "FileSelectViewController.h"
#import "STSegmentedControl.h"
@interface FileSelectViewController (){
    NSArray *array_ziduan;
    UITableViewCell *cell;
    NSMutableArray *array_rember;
    NSMutableArray *array_duigou;
}

@end

@implementation FileSelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
@synthesize string_color,string_yanse;
-(void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *user_duigou=[NSUserDefaults standardUserDefaults];
    array_duigou=[[NSMutableArray alloc]init];
    array_duigou=[user_duigou objectForKey:@"markduigou"];
    for (int i=0; i<[array_duigou count]; i++) {
        NSString *stringduigou=[array_duigou objectAtIndex:i];
        mark[[stringduigou intValue]]=1;
    }
    [self viewDidLoad ];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem * backbtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backbtn)];
    self.navigationItem.leftBarButtonItem = backbtn;
    
    UISegmentedControl * segmentC = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"产品设置",@"字段设置", nil]];
    segmentC.frame = CGRectMake(0, 3, 120,30);               
    segmentC.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentC.momentary = NO;    //设置在点击后是否恢复原样 
    segmentC.multipleTouchEnabled=YES;  //可触摸
    segmentC.tintColor = [UIColor blackColor];
    [segmentC addTarget:self action:@selector(mySegment:) forControlEvents:UIControlEventValueChanged];
    //  UIBarButtonItem *segButton = [[UIBarButtonItem alloc] initWithCustomView:segmentC];
    UIBarButtonItem *segButton = [[UIBarButtonItem alloc] initWithCustomView:segmentC];
    self.navigationItem.rightBarButtonItem=segButton;
    
//    STSegmentedControl *thirdsegment=[[STSegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"产品设置",@"字段设置", nil]];
//    thirdsegment.frame= CGRectMake(0, 3, 120,30);
//    
//    [thirdsegment addTarget:self action:@selector(mySegment:) forControlEvents:UIControlEventValueChanged];
//    UIBarButtonItem *segButton = [[UIBarButtonItem alloc] initWithCustomView:thirdsegment];
//    self.navigationItem.rightBarButtonItem=segButton;
    

    
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    self.string_color=[user objectForKey:@"style"];
    
    UIView *aview=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view=aview;
    tableview_file=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    tableview_file.delegate=self;
    tableview_file.dataSource=self;
    [aview addSubview:tableview_file];
    tableview_file.backgroundColor=[UIColor clearColor];
    array_ziduan=[[NSArray alloc]initWithObjects:@"报价",@"开盘",@"最高",@"最低",@"涨跌",@"更新",nil];
    
    //    UIBarButtonItem *completebtn=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(complete)];
    //    self.navigationItem.rightBarButtonItem=completebtn;	// Do any additional setup after loading the view.
    if ([self.string_color isEqualToString:@"dark"]) {
        aview.backgroundColor=[UIColor blackColor];
        tableview_file.separatorColor=[UIColor whiteColor];
    }else {
        aview.backgroundColor=[UIColor whiteColor];
        tableview_file.separatorColor=[UIColor blackColor];

    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [array_ziduan count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * string_cell = @"cell";
    cell = [tableView dequeueReusableCellWithIdentifier:string_cell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string_cell];
    }     
    for (UIView *aView in cell.contentView.subviews) {
        [aView removeFromSuperview];
    }
    
    cell.backgroundColor=[UIColor clearColor];
    cell.textLabel.backgroundColor=[UIColor clearColor];
    cell.textLabel.textAlignment=UITextAlignmentLeft;
    cell.textLabel.text=[array_ziduan objectAtIndex:indexPath.row];
    if ([self.string_color isEqualToString:@"dark"]) {
        cell.textLabel.textColor=[UIColor whiteColor];
    }else {
        cell.textLabel.textColor=[UIColor blackColor];
    }
    if (mark[indexPath.row]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"indexPath.section = %d,row = %d",indexPath.section,indexPath.row);
    UITableViewCell *  cell1= [tableView cellForRowAtIndexPath:indexPath];
    mark[indexPath.row] = !mark[indexPath.row];
    
    if (!mark[indexPath.row]) 
    {
        cell1.accessoryType = UITableViewCellAccessoryNone;
        
    }
    else {
        cell1.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }
    
}
-(void)complete{
    NSLog(@"chengong!");
    NSUserDefaults *user_markduigou=[NSUserDefaults standardUserDefaults];
    NSMutableArray *array_markduigou=[[NSMutableArray alloc]init];
    array_rember=[[NSMutableArray alloc]init];
    for (int i=0; i<10; i++) {
        if (mark[i]==1) {
            [array_rember addObject:[array_ziduan objectAtIndex:i]];
            NSString *string_duigou=[NSString stringWithFormat:@"%d",i];
            [array_markduigou addObject:string_duigou];
        }
    }
    [user_markduigou setObject:array_markduigou forKey:@"markduigou"];
    [user_markduigou synchronize];
    
    NSUserDefaults *user_ziduan=[NSUserDefaults standardUserDefaults];
    [user_ziduan setObject:array_rember forKey:@"ziduan" ];
    [user_ziduan synchronize ];
    NSLog(@"count%d",[array_rember count]);
    
    for(int i=0;i<[array_rember count];i++)
    {
        
        NSLog(@"rember=%@",[array_rember objectAtIndex:i]);
    }
}
#pragma mark - UISegmentedControl
- (void)mySegment:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
        case 0:
        {
            NSLog(@"当前是设置产品");
            NSLog(@"chengong!");
            [array_rember removeAllObjects];
            NSUserDefaults *user_markduigou=[NSUserDefaults standardUserDefaults];
            NSMutableArray *array_markduigou=[[NSMutableArray alloc]init];
            array_rember=[[NSMutableArray alloc]init];
            for (int i=0; i<6; i++) {
                if (mark[i]==1) {
                    [array_rember addObject:[array_ziduan objectAtIndex:i]];
                    NSString *string_duigou=[NSString stringWithFormat:@"%d",i];
                    [array_markduigou addObject:string_duigou];
                }
            }
            [user_markduigou setObject:array_markduigou forKey:@"markduigou"];
            [user_markduigou synchronize];
            
            NSUserDefaults *user_ziduan=[NSUserDefaults standardUserDefaults];
            [user_ziduan setObject:array_rember forKey:@"ziduan" ];
            [user_ziduan synchronize ];
            NSLog(@"count%d",[array_rember count]);
            
            for(int i=0;i<[array_rember count];i++)
            {
                
                NSLog(@"rember=%@",[array_rember objectAtIndex:i]);
            }
            
            [self.navigationController popViewControllerAnimated:NO];
            
            
        }
            break;
        case 1:
        {
            NSLog(@"当前是设置字段");
        }
            break;
            
            
        default:
            break;
    }
}
-(void)backbtn{
    NSLog(@"chengong!");
    [array_rember removeAllObjects];
    NSUserDefaults *user_markduigou=[NSUserDefaults standardUserDefaults];
    NSMutableArray *array_markduigou=[[NSMutableArray alloc]init];
    array_rember=[[NSMutableArray alloc]init];
    for (int i=0; i<6; i++) {
        if (mark[i]==1) {
            [array_rember addObject:[array_ziduan objectAtIndex:i]];
            NSString *string_duigou=[NSString stringWithFormat:@"%d",i];
            [array_markduigou addObject:string_duigou];
        }
    }
    [user_markduigou setObject:array_markduigou forKey:@"markduigou"];
    [user_markduigou synchronize];
    
    NSUserDefaults *user_ziduan=[NSUserDefaults standardUserDefaults];
    [user_ziduan setObject:array_rember forKey:@"ziduan" ];
    [user_ziduan synchronize ];
    NSLog(@"count%d",[array_rember count]);
    
    for(int i=0;i<[array_rember count];i++)
    {
        
        NSLog(@"rember=%@",[array_rember objectAtIndex:i]);
    }
    [self.navigationController popViewControllerAnimated:NO ];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
