//
//  DayModel.m
//  
//
//  Created by 王琳琳 on 17/2/21.
//
//

#import "Daylist.h"

@implementation Daylist

- (id)init{

    if ((self = [super init])){
        
    }
    return self;


}
- (id)initWithCoder:(NSCoder *)aDecoder{

    if ((self = [super init])) {
        self.dayCaseContent  = [aDecoder decodeObjectForKey:@"DayCaseContent"];
        self.dayCaseDate = [aDecoder decodeObjectForKey:@"DayCaseDate"];
        self.dayCasePushTag = [aDecoder decodeObjectForKey:@"DayCasePushCause"];
        self.dayCaseTag = [aDecoder decodeObjectForKey:@"DayCaseTage"];
        self.shouldRemind = [aDecoder decodeBoolForKey:@"ShouldRemind"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:self.dayCaseContent forKey:@"DayCaseContent"];
    [aCoder encodeObject:self.dayCaseDate forKey:@"DayCaseDate"];
    [aCoder encodeObject:self.dayCasePushTag forKey:@"DayCasePushCause"];
    [aCoder encodeObject:self.dayCaseTag forKey:@"DayCaseTag"];
    [aCoder encodeBool:self.shouldRemind forKey:@"ShoudldRemind"];

}
@end
