//
//  NewsSearchViewController.m
//  iChartApp
//
//  Created by 张少南 on 12-8-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NewsSearchViewController.h"

@interface NewsSearchViewController ()

@end

@implementation NewsSearchViewController
@synthesize dataArray = _dataArray,titleStr = _titleStr;
@synthesize loadingIndicator = _loadingIndicator;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = _titleStr;
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,320,460-44-49) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor blackColor];
    NSLog(@"dataArray == %d",[self.dataArray count]);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }else 
    {
        for (UIView * view in cell.contentView.subviews) 
        {
            [view removeFromSuperview];
        }
    }
    
    
    UILabel *labletext;
    if ([_dataArray count]!=0) {
        if (indexPath.row==[_dataArray count]) 
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
        if (indexPath.row<[_dataArray count]) {
            dictionary_weibo = [_dataArray objectAtIndex:indexPath.row];//每条微博是一个字典
            stringtext= [NSString stringWithFormat:[dictionary_weibo objectForKey:@"text"]]; 
            NSLog(@"stringtext%@",stringtext);
            UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
            CGSize constraintSize = CGSizeMake(240.0f, MAXFLOAT);
            CGSize labelSize = [stringtext sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
            labletext=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, labelSize.height)];
            labletext.numberOfLines=0;
            //        count_biaoji++;
            //        if (count_biaoji<[dataArr count]) {
            //            mytableview_contentview+=labelSize.height+20;
            //
            //        }
//            NSLog(@"mytableview_contentview=%f",mytableview_contentview);
            labletext.backgroundColor=[UIColor clearColor];
            // cell.textLabel.font = [UIFont systemFontOfSize:13];
            labletext.text=stringtext;
            // labletext.textAlignment=uite
            [cell.contentView addSubview:labletext];
            
            //[cell.textLabel setLineBreakMode:UILineBreakModeWordWrap];
            //cell.textLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
            //[cell.textLabel setNumberOfLines:0];
            
        }
        
    }
    cell.backgroundColor = [UIColor blackColor];
    labletext.textColor = [UIColor whiteColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
//    if ([style isEqualToString:@"dark"]) {
//        cell.backgroundColor = [UIColor blackColor];
//        labletext.textColor = [UIColor whiteColor];
//        //textView.textColor = [UIColor whiteColor];
//        
//        
//    }else {
//        cell.backgroundColor=[UIColor whiteColor];
//        labletext.textColor = [UIColor blackColor];
//        // textView.textColor = [UIColor blackColor];
//        
//        
//    }

    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize labelSize;
    // NSString *stringtest=@"123";
    //创建一个新的CGSize来限制和计算text边框的大小
    if ([_dataArray count]!=0) {
        if (indexPath.row<[_dataArray count]) {
            dictionary_weibo = [_dataArray objectAtIndex:indexPath.row];//每条微博是一个字典
            stringtext= [NSString stringWithFormat:[dictionary_weibo objectForKey:@"text"]];       // NSString *cellText = sts;
            UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
            CGSize constraintSize = CGSizeMake(240.0f, MAXFLOAT);
            labelSize = [stringtext sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
            NSLog(@"stringtext==%@",stringtext);
            
        }
        if (indexPath.row==[_dataArray count]) {
            labelSize.height=25;
        }
    }
    
    return labelSize.height + 20;
    
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
