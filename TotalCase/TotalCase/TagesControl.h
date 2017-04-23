//
//  TagesControl.h
//  
//
//  Created by 王琳琳 on 17/3/8.
//
//

#import <UIKit/UIKit.h>

@interface TagesControl : UIScrollView
@property (nonatomic,strong)NSMutableArray *tags;
@property (nonatomic,strong)UIColor *tagsBackgroundColor;
@property (nonatomic,strong)UIColor *tagsTextColor;
//- (void)addTags:(NSString *)tags;
- (void)reloadTagSubviews;
@end
