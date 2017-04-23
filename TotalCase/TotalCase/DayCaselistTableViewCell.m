//
//  DayCaselistTableViewCell.m
//  
//
//  Created by 王琳琳 on 17/2/22.
//
//

#import "DayCaselistTableViewCell.h"
#import "Daylist.h"
@interface DayCaselistTableViewCell ()
{
    NSDateFormatter *formatter;

}
@end
@implementation DayCaselistTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    UIColor *blueBackgroundColor = [UIColor colorWithRed:75.0/255.0 green:186.0/255.0 blue:251.0/255.0 alpha:1];
    UIColor *whiteTextColor = [UIColor whiteColor];
    
    self.tagsDayPush.tagsBackgroundColor = blueBackgroundColor;
    self.tagsDayPush.tagsTextColor = whiteTextColor;
    
    self.tagsDayTag.tagsBackgroundColor = blueBackgroundColor;
    self.tagsDayTag.tagsTextColor = whiteTextColor;
    self.tagsDayPush.scrollEnabled = NO;
    self.tagsDayTag.scrollEnabled = NO;
    

   
    [self initCell];
    NSLog(@"我是cell，已经初始化");
    
}

- (void)setDayList:(Daylist *)dayList{
    self.CaseContentLabel.text = dayList.dayCaseContent;
    self.CaseDateLabel.text = [self formatDate:dayList];
    self.CaseHourLabel.text = [self formatHour:dayList];
    self.tagsDayPush.tags = [dayList.dayCasePushTag mutableCopy];
    self.tagsDayTag.tags = [dayList.dayCaseTag mutableCopy];
    [self.tagsDayTag reloadTagSubviews];
    [self.tagsDayPush reloadTagSubviews];
    
   
}
- (NSString *)formatDate:(Daylist *)dayList{
    formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date =[NSString stringWithFormat:@"%@",[formatter stringFromDate:dayList.dayCaseDate]];
    
    return date;
}
- (NSString *)formatHour:(Daylist *)dayList{
    formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH-MM"];
    NSString *dateHour = [NSString stringWithFormat:@"%@",[formatter stringFromDate:dayList.dayCaseDate]];
    
    return dateHour;
}
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        [self initCell];
    }
    return self;
}

-(void) initCell
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}
@end
