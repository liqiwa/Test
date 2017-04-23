//
//  DayCaselistTableViewCell.h
//  
//
//  Created by 王琳琳 on 17/2/22.
//
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"
#import "Daylist.h"
#import "TagesControl.h"
@interface DayCaselistTableViewCell : SWTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *CaseContentLabel;
@property (strong, nonatomic) IBOutlet TagesControl *tagsDayPush;
@property (strong, nonatomic) IBOutlet TagesControl *tagsDayTag;

@property (weak, nonatomic) IBOutlet UILabel *CaseDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *CaseHourLabel;
@property (nonatomic,strong)Daylist *dayList;
@end
