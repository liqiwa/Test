//
//  TagsForDay.m
//  
//
//  Created by 王琳琳 on 17/3/8.
//
//

#import "TagsForDay.h"

@implementation TagsForDay

- (id)init{
    if ([super init]) {
        self.tagArray = [[NSMutableArray alloc] initWithCapacity:20];
    }

    return self;
}
@end
