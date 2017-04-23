//
//  CaseDetatilTableViewCell.h
//  
//
//  Created by 王琳琳 on 17/2/24.
//
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"
#import "TagesControl.h"
#import "TagsForDayTableViewController.h"
#import "PushTagsForDayTableViewController.h"
@class CaseDetatilViewController;
@class Daylist;
@protocol CaseDetailViewControllerDelegate<NSObject>

- (void)caseDetailViewController:(CaseDetatilViewController *)controller
              didFinishAddingDay:(Daylist *)dayList;
- (void)caseDetailViewController:(CaseDetatilViewController *)controller
             didEditingAddingDay:(Daylist *)dayList;
@end
@interface CaseDetatilViewController : UITableViewController<UITextViewDelegate,TagsForDayTableViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *dayCaseTextView;
@property (weak, nonatomic) IBOutlet UISwitch *switchControl;

@property (weak, nonatomic) IBOutlet UILabel *dueDateLabel;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (nonatomic,strong)Daylist *daylist;
@property(nonatomic,weak)id<CaseDetailViewControllerDelegate>delegate;
@property (strong, nonatomic) IBOutlet TagesControl *tagsControlForDay;
@property (strong, nonatomic) IBOutlet TagesControl *tagsControlForPush;

- (IBAction)saveDaydata;
@end
