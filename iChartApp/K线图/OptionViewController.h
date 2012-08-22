//
//  OptionViewController.h
//  chartee
//
//  Created by Tcy vinech on 12-7-25.
//  Copyright 2011 vinech_Tcy. All rights reserved.
//

@protocol OptionViewControllerDelegate <NSObject>

-(void)popToRoot:(NSMutableArray *)theArray;

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






