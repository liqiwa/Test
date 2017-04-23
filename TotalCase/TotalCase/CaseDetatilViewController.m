//
//  CaseDetatilTableViewCell.m
//  
//
//  Created by 王琳琳 on 17/2/24.
//
//

#import "CaseDetatilViewController.h"
#import "Daylist.h"
#import "TagesControl.h"
@implementation CaseDetatilViewController
{
    NSDate * _dueDate;
    BOOL _datePickerVisible;
   

}
//- (void)awakeFromNib {
//    // Initialization code
//   }
//
- (void)viewDidLoad{

    [super viewDidLoad];
    if(self.daylist != nil){
       
        self.dayCaseTextView.text = self.daylist.dayCaseContent;
        _dueDate = self.daylist.dayCaseDate;
        [self initTagsDayName:self.daylist.dayCaseTagName];
        [self initTagsPushName:self.daylist.dayCasePushTagName];
         
         }else{
        self.daylist = [[Daylist alloc]init];
        self.switchControl.enabled = NO;
        _dueDate = [NSDate date];
        [self initTagsDayName:nil];
        [self initTagsPushName:nil];
    }
    [self updateDueDateLabel];

    
}
#pragma mark -initTags
- (void)initTagsDayName:(NSMutableArray *)tagsDayNameArray{
    if (tagsDayNameArray != nil ) {
        _tagsControlForDay.tags = [tagsDayNameArray mutableCopy];
    }
    UIColor *blueBackgroundColor = [UIColor colorWithRed:75.0/255.0 green:186.0/255.0 blue:251.0/255.0 alpha:1];
    UIColor *whiteTextColor = [UIColor whiteColor];
    

    _tagsControlForDay.tagsBackgroundColor = blueBackgroundColor;
    _tagsControlForDay.tagsTextColor = whiteTextColor;
    
        [_tagsControlForDay reloadTagSubviews];
 
    
}
- (void)initTagsPushName:(NSMutableArray *)tagsPushNameArray{

    if (tagsPushNameArray != nil ) {
        _tagsControlForDay.tags = [tagsPushNameArray mutableCopy];
    }

    
    UIColor *blueBackgroundColor = [UIColor colorWithRed:75.0/255.0 green:186.0/255.0 blue:251.0/255.0 alpha:1];
    UIColor *whiteTextColor = [UIColor whiteColor];

    _tagsControlForPush.tagsBackgroundColor = blueBackgroundColor;
    _tagsControlForPush.tagsTextColor = whiteTextColor;
    [_tagsControlForPush reloadTagSubviews];


}

//根据textview是否有输入内容来判读 doneBarButton的可用与否。
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    NSString *newtext =[textView.text stringByReplacingCharactersInRange:range withString:text];
    self.doneBarButton.enabled = (newtext.length>0);
    NSLog(@"我的字符长度是%lu",(unsigned long)newtext.length);
    return YES;


}
- (IBAction)saveDaydata {
    
        self.daylist.dayCaseContent = self.dayCaseTextView.text;
        self.daylist.dayCaseDate = _dueDate;
        self.daylist.dayCasePushTag = _tagsControlForDay.tags;
        self.daylist.dayCaseTag = _tagsControlForDay.tags;
        [self.delegate caseDetailViewController:self didFinishAddingDay:self.daylist];
 
    
}
#pragma mark - tableViewdatasource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.dayCaseTextView resignFirstResponder];
    if (indexPath.section == 1 && indexPath.row == 1) {
        if (!_datePickerVisible) {
            [self showDatePicker];
        }else{
            [self hideDatePicker];
        }
    }



}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1 && indexPath.row == 2) {
        return 217.0f;
    }else{
        
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1 && _datePickerVisible) {
        return 3;
    }else{
        
        return [super tableView:tableView numberOfRowsInSection:section];
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 1 && indexPath.row == 2) {
        //2
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DatePickerCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DatePickerCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //3
            UIDatePicker *datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 216.0f)];
            datePicker.tag = 100;
            [cell.contentView addSubview:datePicker];
            NSLog(@"我是datePicker");
            //4
            [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        }
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }


}
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1 && indexPath.row == 2) {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        return [super tableView:tableView indentationLevelForRowAtIndexPath:newIndexPath];
    }else{
        
        return [super tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
    }
    
}
#pragma mark - datePicker
//datePicker 获取方法
- (void)dateChanged:(UIDatePicker *)datePicker{

     _dueDate = datePicker.date;
   
    [self updateDueDateLabel];
}
- (void)updateDueDateLabel{

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    self.dueDateLabel.text = [formatter stringFromDate:_dueDate];

}
- (void)showDatePicker{

    _datePickerVisible = YES;
    
    NSIndexPath *indexPathDateRow = [NSIndexPath indexPathForRow:1 inSection:1];
    NSIndexPath *indexPathDatePicker = [NSIndexPath indexPathForRow:2 inSection:1];
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPathDateRow];
    cell.detailTextLabel.textColor = cell.detailTextLabel.tintColor;
    [self.tableView beginUpdates];
    
    [self.tableView insertRowsAtIndexPaths:@[indexPathDatePicker] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView reloadRowsAtIndexPaths:@[indexPathDateRow] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
    
    UITableViewCell *datePickerCell = [self.tableView cellForRowAtIndexPath:indexPathDatePicker];
    
    UIDatePicker *datePicker = (UIDatePicker *)[datePickerCell viewWithTag:100];
    [datePicker setDate:_dueDate animated:NO];
    
    
}
- (void)hideDatePicker{

    if (_datePickerVisible) {
        _datePickerVisible = NO;
        NSIndexPath *indexPathDateRow = [NSIndexPath indexPathForRow:1 inSection:1];
        NSIndexPath *indexPathDatePicker = [NSIndexPath indexPathForRow:2 inSection:1];
        
        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:@[indexPathDateRow]
                              withRowAnimation:UITableViewRowAnimationNone];
         
        [self.tableView deleteRowsAtIndexPaths:@[indexPathDatePicker]
                              withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        
        
    
    }
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    [self hideDatePicker];
}


#pragma mark - SegueChoice
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"AddTags"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        TagsForDayTableViewController *controller = (TagsForDayTableViewController *)navigationController.topViewController;
        controller.delegate = self;
        controller.editDaylist= self.daylist;
        NSLog(@"我是 选择的 tag %@",self.daylist.dayCaseTag);
    }else if([segue.identifier isEqualToString:@"AddPushTags"]){
    
//        UINavigationController *navigationController = segue.destinationViewController;
//        PushTagsFordayTableViewController *controller = (PushTagsFordayTableViewController *)navigationController.topViewController;
//    
//        
    
    }

}


#pragma mark - TagsForDayTableViewContrllerDelegate
- (void)TagsForDayTableViewControllerDidCancle:(TagsForDayTableViewController *)controller{

    NSLog(@"我执行了delegate");

    [self dismissViewControllerAnimated:YES completion:nil];

   
}
- (void)TagsForDayTableViewController:(TagsForDayTableViewController *)tagView addTagForDay:(NSMutableArray *)tagArrayName{

    [self initTagsDayName:tagArrayName];
    
    

}
#pragma mark - PushTagsForDayTableViewControllerDelegate
- (void)TagsForDayTableViewController:(TagsForDayTableViewController *)tagView editTagForDay:(NSMutableArray *)tagArray{

    
}
@end
