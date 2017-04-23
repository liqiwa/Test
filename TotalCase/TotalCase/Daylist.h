//
//  DayModel.h
//  
//
//  Created by 王琳琳 on 17/2/21.
//
//

#import <Foundation/Foundation.h>

@interface Daylist : NSObject

@property (nonatomic,copy)NSString *dayCaseContent;
@property (nonatomic,strong)NSMutableArray *dayCasePushTag;
@property (nonatomic,strong)NSMutableArray *dayCaseTagName;
@property (nonatomic,strong)NSMutableArray *dayCasePushTagName;
@property (nonatomic,strong)NSMutableArray *dayCaseTag;
@property (nonatomic,strong)NSDate *dayCaseDate;

@property(nonatomic,assign)BOOL shouldRemind;

@end
