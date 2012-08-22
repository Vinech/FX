//
//  StoryViewController.m
//  iChart
//
//  Created by bin huang on 12-7-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//ss
//mm
#import "StoryViewController.h"
#import "SetupViewController.h"
#import "AsyncImageView.h"

#define kWBSDKDemoAppKey @"2131365630"
#define kWBSDKDemoAppSecret @"9ccde1899c528308145342904dfb7b18"
@interface StoryViewController (){
    NSString *string;
    NSString *style;
    
    UIView *aview;//self.view第一层
    UIScrollView * scrollView;//第二层
    UILabel * contentLabel;//放微博得文字得部分
    UIImageView *imageview_ziji;//微博的图片
    UILabel * sourceLabel;//来源
    UILabel * dateLabel;//时间
    UILabel * urlLabel;


    CGRect rect_scrowview;
    CGRect rect_contentlabel;
    CGRect rect_imageview_ziji;
    CGRect rect_sourcelabel;
    CGRect rect_datelabel;
    CGRect rect_urllabel;
    CGRect rect_aview;
    
}

@end

@implementation StoryViewController
@synthesize string_text,dicwb,string_picture,string_idstr,gaodu_text;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//
//
-(void)viewWillAppear:(BOOL)animated
{
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    string = [user objectForKey:@"style"];
    NSLog(@"viewvillappear..string ==================== %@",string);
    if ([style isEqualToString:string]==NO) {
        NSLog(@"执行了viewdiload");
        [self viewDidLoad];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    engine=[[WBEngine alloc]initWithAppKey:kWBSDKDemoAppKey appSecret:kWBSDKDemoAppSecret];
    engine.delegate=self;
    if (string==nil) {
        string =@"dark";
        style =@"dark";
    }
    else {
        style=[NSString stringWithFormat:string];
    }
    self.navigationItem.leftBarButtonItem.title = @"back";
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    //    self.navigationController.title = @"Story";
    
    UIView * viewtitle = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 200, 40)];
    viewtitle.backgroundColor = [UIColor clearColor];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 100, 40)];
    label.text = @"Story";
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    [viewtitle addSubview:label];
    self.navigationItem.titleView = viewtitle;
    
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStyleDone target:self action:@selector(comeBack)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    UIBarButtonItem * shareButton = [[UIBarButtonItem alloc] initWithTitle:@"share" style:UIBarButtonItemStyleDone target:self action:@selector(shareMessage)];
    self.navigationItem.rightBarButtonItem = shareButton;
    
    aview=[[UIView alloc]initWithFrame:rect_aview];
    self.view=aview;

    AsyncImageView *imageview_asy=[[AsyncImageView alloc]init];
    imageview_asy.urlString=self.string_picture;
    NSLog(@"url====%@",[imageview_asy urlString]);
   imageview_ziji=[[UIImageView alloc]initWithFrame:rect_imageview_ziji];
    imageview_ziji.backgroundColor=[UIColor clearColor];
    imageview_ziji.image=[imageview_asy image];
    
    contentLabel = [[UILabel alloc] initWithFrame:rect_contentlabel];
   contentLabel.numberOfLines = 10 ;
    contentLabel.text = self.string_text;
    contentLabel.backgroundColor=[UIColor clearColor];
    
    //来源
    
  urlLabel = [[UILabel alloc] initWithFrame:rect_urllabel];
    urlLabel.numberOfLines = 5;
    urlLabel.text = @"http://e.weibo.com/everisegold?ref=http%3A%2F%2Fweibo.com%2F2755998762%2Ffollow%3Fleftnav%3D1%26wvr%3D3.6";
    urlLabel.backgroundColor = [UIColor clearColor];
    //来源
    sourceLabel = [[UILabel alloc] initWithFrame:rect_sourcelabel];
    sourceLabel.numberOfLines = 1;
    sourceLabel.text = @"source: 久誉贵金属官方微博";
    sourceLabel.backgroundColor = [UIColor clearColor];
    sourceLabel.textAlignment = UITextAlignmentLeft;
    //    [textView addSubview:sourceLabel];
    
    
    scrollView = [[UIScrollView alloc] initWithFrame:rect_scrowview];
    scrollView.contentSize = CGSizeMake(0,600);
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.showsVerticalScrollIndicator = NO;
    [aview addSubview:scrollView];
    
    [scrollView addSubview:imageview_ziji];
    [scrollView addSubview:contentLabel];
    [scrollView addSubview:urlLabel];
    [scrollView addSubview:sourceLabel];
   // [scrollView addSubview:dateLabel];
    
    if ([style isEqualToString:@"dark"]) {
        aview.backgroundColor=[UIColor blackColor];
        //  titleLabel.textColor = [UIColor whiteColor];
        dateLabel.textColor = [UIColor whiteColor];
        sourceLabel.textColor = [UIColor whiteColor];
        urlLabel.textColor = [UIColor whiteColor];
        contentLabel.textColor = [UIColor whiteColor];
        label.textColor = [UIColor whiteColor];
    }else {
        aview.backgroundColor=[UIColor whiteColor];
        //titleLabel.textColor = [UIColor blackColor];
        dateLabel.textColor = [UIColor blackColor];
        sourceLabel.textColor = [UIColor blackColor];
        urlLabel.textColor = [UIColor whiteColor];
        contentLabel.textColor = [UIColor blackColor];
        label.textColor = [UIColor blackColor];
        // contentLabel.backgroundColor = [UIColor whiteColor];
        
        
        
        
        
    }
    
	// Do any additional setup after loading the view.
}

-(void)comeBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)shareMessage
{
    action = [[UIActionSheet alloc] initWithTitle:@"分享" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"分享到新浪微博",nil];
    [action showInView:self.view.window];
}
#pragma mark-actionSheet delggate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        NSLog(@"fenxiang");
        if ([engine isLoggedIn]) {
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
           // NSString *uid=@"2667934680";
            //NSString *screen_name=@"久誉贵金属";
            
            [dic setValue:engine.accessToken forKey:@"access_token"];
            [dic setValue:self.string_idstr forKey:@"id"];
            NSLog(@"id=%@",string_idstr);
            [engine loadRequestWithMethodName:@"statuses/repost.json" httpMethod:@"POST" params:dic postDataType:kWBRequestPostDataTypeNormal httpHeaderFields:nil];

            
           // [ engine sendWeiBoWithText:[NSString stringWithFormat:@"%@------来自久誉贵金属官方微博",self.string_text] image:nil];
            
            
        }else {
            alertview=[[UIAlertView alloc]initWithTitle:@"未绑定微博" message:@"是否绑定" delegate:self cancelButtonTitle:@"以后再说" otherButtonTitles:@"现在绑定", nil];
            [alertview show];
        }
        
    }else {
        NSLog(@"quxiao");
    }
}
#pragma mark-enginedelegate
- (void)engine:(WBEngine *)engine requestDidSucceedWithResult:(id)result
{
    
   // [self dismissModalViewControllerAnimated:YES];
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"分享成功！" 
													   message:nil 
													  delegate:nil
											 cancelButtonTitle:@"确定" 
											 otherButtonTitles:nil];
	[alertView show];
    
}

#pragma mark-uialertviewdelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView==alertview) {
        if (buttonIndex==0) {
            SetupViewController *aview1=[[SetupViewController alloc]init];
            [self.navigationController pushViewController:aview1 animated:YES];
        }
    }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{  NSUserDefaults *user_hengshuping=[NSUserDefaults standardUserDefaults];
    NSString *string_hengshuping=[[NSString alloc]init];
    

    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft||interfaceOrientation==UIInterfaceOrientationLandscapeRight) { 
        string_hengshuping=@"hengping";
        [user_hengshuping setObject:string_hengshuping forKey:@"hengshuping"];
        [user_hengshuping synchronize];
        
        aview.frame=CGRectMake(0, 0, 480, 320);
        rect_aview=CGRectMake(0, 0, 480, 320);
        scrollView.frame=CGRectMake(0, 0, 480, 320);
        rect_scrowview=CGRectMake(0, 0, 480, 320);
        contentLabel.frame=CGRectMake(0,0,480,self.gaodu_text);
        rect_contentlabel=CGRectMake(0,0,480,self.gaodu_text);
        if (self.string_picture!=nil) {
            imageview_ziji.frame=CGRectMake(30, self.gaodu_text+16, 420, 100);
            rect_imageview_ziji=CGRectMake(30, self.gaodu_text+16, 420, 100);
            urlLabel.frame=CGRectMake(5,self.gaodu_text+16+100+6 , 470, 100);
            rect_urllabel=CGRectMake(5,self.gaodu_text+16+100+6 , 470, 100);
            sourceLabel.frame=CGRectMake(5, self.gaodu_text+16+100+6+100+6,470, 70);
            rect_sourcelabel=CGRectMake(5, self.gaodu_text+16+100+6+100+6,470, 70);
//            if (self.gaodu_text+16+100+6+100+6+70<320-44-49-14) {
//                scrollView.contentSize=CGSizeMake(0, 0);
//            }else {
//                scrollView.contentSize=CGSizeMake(0, self.gaodu_text+6+100+6+100+6+70-(320-19-44-49));
//                
//            }

            
        }else {
                        
            imageview_ziji.frame=CGRectMake(30, self.gaodu_text+16, 420, 0);
            rect_imageview_ziji=CGRectMake(30, self.gaodu_text+16, 420, 0);
            urlLabel.frame=CGRectMake(5, self.gaodu_text+26, 470, 100);
            rect_urllabel=CGRectMake(5, self.gaodu_text+26, 470, 100);
            sourceLabel.frame=CGRectMake(5, self.gaodu_text+16+100+26, 470, 70);
            rect_sourcelabel=CGRectMake(5, self.gaodu_text+16+100+26, 470, 70);
//            if (self.gaodu_text+6+100+6+100+6+70<320-44-49-14) {
//                scrollView.contentSize=CGSizeMake(0, 0);
//            }else {
//                scrollView.contentSize=CGSizeMake(0, self.gaodu_text+6+100+6+70-(480-19-44-49));
//                
//            }
            

            
        }
        
        
        
    } 
      if (interfaceOrientation==UIInterfaceOrientationPortrait||interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) { 
                  
          string_hengshuping=@"shuping";
          [user_hengshuping setObject:string_hengshuping forKey:@"hengshuping"];
          [user_hengshuping synchronize];

          aview.frame=CGRectMake(0, 0, 320, 480);
          rect_aview=CGRectMake(0, 0, 320, 480);

        scrollView.frame=CGRectMake(0, 0, 320,460-44-49);
          rect_scrowview=CGRectMake(0, 0, 320,460-44-49);
          contentLabel.frame=CGRectMake(0,0,320,self.gaodu_text);
          rect_contentlabel=CGRectMake(0,0,320,self.gaodu_text);
          if (self.string_picture!=nil) {
              imageview_ziji.frame=CGRectMake(30, self.gaodu_text+6, 260, 100);
              rect_imageview_ziji=CGRectMake(30, self.gaodu_text+6, 260, 100);
              urlLabel.frame=CGRectMake(5,self.gaodu_text+6+100+6 , 310, 100);
              rect_urllabel=CGRectMake(5,self.gaodu_text+6+100+6 , 310, 100);
              sourceLabel.frame=CGRectMake(5, self.gaodu_text+6+100+6+100+6,310, 70);
              rect_sourcelabel=CGRectMake(5, self.gaodu_text+6+100+6+100+6,310, 70);
//              if (self.gaodu_text+6+100+6+100+6+70<480-14-44-49) {
//                  scrollView.contentSize=CGSizeMake(0, 0);
//              }else {
//                  scrollView.contentSize=CGSizeMake(0, self.gaodu_text+6+100+6+100+6+70-(480-19-44-49));
//
//              }

          }else {
              imageview_ziji.frame=CGRectMake(30, self.gaodu_text+6, 260, 0);
              rect_imageview_ziji=CGRectMake(30, self.gaodu_text+6, 260, 0);
              urlLabel.frame=CGRectMake(5, self.gaodu_text+6, 310, 100);
              rect_urllabel=CGRectMake(5, self.gaodu_text+6, 310, 100);
              sourceLabel.frame=CGRectMake(5, self.gaodu_text+6+100+6, 310, 70);
              rect_sourcelabel=CGRectMake(5, self.gaodu_text+6+100+6, 310, 70);
//              if (self.gaodu_text+6+100+6+100+6+70<300) {
//                  scrollView.contentSize=CGSizeMake(0, 0);
//              }else {
//                  scrollView.contentSize=CGSizeMake(0, self.gaodu_text+6+100+6+70-300);
//                  
//              }
//
//              
          }


        //shang 
    } 
    
    return YES;
}

@end
