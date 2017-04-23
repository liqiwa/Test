//
//  TagsForDayTableViewController.h
//  
//
//  Created by 王琳琳 on 17/3/9.
//
//

#import <UIKit/UIKit.h>
#import "Daylist.h"
#import "TagsForDay.h"
@class TagsForDayTableViewController;
@protocol TagsForDayTableViewControllerDelegate
- (void)TagsForDayTableViewControllerDidCancle:(TagsForDayTableViewController *)controller;
- (void)TagsForDayTableViewController:(TagsForDayTableViewController *)tagView editTagForDay:(NSMutableArray *)tagArray;
- (void)TagsForDayTableViewController:(TagsForDayTableViewController *)tagView addTagForDay:(NSMutableArray *)tagArray;
@end
@interface TagsForDayTableViewController : UITableViewController
@property (strong,nonatomic)NSMutableArray *tagArray;
@property (weak,nonatomic)id<TagsForDayTableViewControllerDelegate> delegate;
- (IBAction)addButton;
- (IBAction)finishButton;
@property (strong,nonatomic)TagsForDay *tagsForDay;
@property (strong,nonatomic)Daylist *editDaylist;

@end
