//
//  TagsForDay.h
//  
//
//  Created by 王琳琳 on 17/3/8.
//
//

#import <Foundation/Foundation.h>

@interface TagsForDay : NSObject
@property (nonatomic,strong)NSString *tagName;
@property (nonatomic,assign)NSInteger tagNumber;
@property (nonatomic)BOOL tagchecked;
@property (nonatomic,strong)NSMutableArray *tagArray;
@end
