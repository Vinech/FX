//
//  OptionViewController.h
//  chartee
//
//  Created by Tcy vinech on 12-7-25.
//  Copyright 2011 vinech_Tcy. All rights reserved.
//

@protocol OptionViewControllerDelegate <NSObject>

-(void)popToRoot:(NSMutableArray *)theArray pointPhone:(int)pointPhone;

@end

#import <UIKit/UIKit.h>

@interface OptionViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    UITableView * tabV;
    NSArray * arratPreiod;
    NSArray * arrayDetia;
    UIView  * backviews;
    UIButton   *button;
    NSArray *array;
    NSArray *arrays;
    UISwitch *switchs;
    UIBarButtonItem *barback;
    id<OptionViewControllerDelegate>delegate;
    UITextField * tf;
    UILabel *labeName;
    UIView * aView;
    UIScrollView * scrollView;
    UIView *headerview;
    UILabel *headerlabel;
    UILabel *headerlabeldetia;
    
    int backviews_frame_origin_x;
    int backviews_frame_origin_y;
    int backviews_frame_size_width;
    int backviews_frame_size_height;
    
    int text_frarm_origin_x;
    int text_frarm_origin_y;
    int text_frarm_size_width;
    int text_frarm_size_height;
    
    int text_frarm_origin_x1;
    int text_frarm_origin_y1;
    int text_frarm_size_width1;
    int text_frarm_size_height1;
    
    int text_frarm_origin_x2;
    int text_frarm_origin_y2;
    int text_frarm_size_width2;
    int text_frarm_size_height2;
    
    
    int label_frarm_origin_x;
    int label_frarm_origin_y;
    int label_frarm_size_width;
    int label_frarm_size_height;
    
    int label_frarm_origin_x1;
    int label_frarm_origin_y1;
    int label_frarm_size_width1;
    int label_frarm_size_height1;
    
    int label_frarm_origin_x2;
    int label_frarm_origin_y2;
    int label_frarm_size_width2;
    int label_frarm_size_height2;
    
    int swichs_frame_origin_x;
    int swichs_frame_origin_y;
    int swichs_frame_size_width;
    int swichs_frame_size_height;
    
    int pointPhone;
    
}
@property(nonatomic,strong)id<OptionViewControllerDelegate>delegate;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * dataArraynew;
@property(nonatomic,assign) int periodEma;
@property(nonatomic,assign) int periodSma;
@property(nonatomic,assign) int periodWma;
@property(nonatomic,assign) int periodBoll;
@property(nonatomic,assign) int periodMom;
@property(nonatomic,assign) int periodMacd;
@property(nonatomic,assign) int periodCci;
@property(nonatomic,assign) int periodAdx;
//@property(nonatomic,assign) int periodKdj;
@property(nonatomic,assign) int periodRsi;
@property(nonatomic,assign) int longMacdPeriod;
@property(nonatomic,assign) int shortMacdPeriod;
@property(nonatomic,assign) int kPeriod;
@property(nonatomic,assign) int dPeriod;
@property(nonatomic,assign) int jPeriod;
@property(nonatomic,assign) float bandDeviation;
-(void)setDelegate:(id<OptionViewControllerDelegate>)theDelegate;


@end






