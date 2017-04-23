//
//  DayModel.m
//  
//
//  Created by 王琳琳 on 17/3/1.
//
//

#import "DayModel.h"

@implementation DayModel
//获取沙盒目录
- (NSString *)documentsDirectory{

    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

    NSString *documentsDirectory = [path firstObject];
    return documentsDirectory;
}
//组合完整文件路径
- (NSString *)dataFilePath{

    return [[self documentsDirectory] stringByAppendingPathComponent:@"Daylists.plist"];

}
//保存每天事件到沙盒
- (void)saveDaylists{

    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.lists forKey:@"Daylists"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
    

}
//从文件读取沙盒文件
- (void)loadDaylists
{

    NSString *path = [self dataFilePath];
    if ([[NSFileManager defaultManager]fileExistsAtPath:path]) {
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        
        self.lists = [unarchiver decodeObjectForKey:@"Daylists"];
    }else{
    
        self.lists = [[NSMutableArray alloc]initWithCapacity:20];
    
    }
    
}
- (id)init{

    if ((self = [super init])) {
        self.lists = [[NSMutableArray alloc]initWithCapacity:20];
    }

    return self;
}
@end
