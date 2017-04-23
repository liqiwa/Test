//
//  FirstViewController.h
//  TotalCase
//
//  Created by 王琳琳 on 17/2/21.
//  Copyright (c) 2017年 LiQiwa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayModel.h"
#import "CaseDetatilViewController.h"
@interface DayViewController : UITableViewController<CaseDetailViewControllerDelegate>
@property (nonatomic,strong)DayModel *dayModel;
@end

