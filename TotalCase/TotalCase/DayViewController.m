//
//  FirstViewController.m
//  TotalCase
//
//  Created by 王琳琳 on 17/2/21.
//  Copyright (c) 2017年 LiQiwa. All rights reserved.
//

#import "DayViewController.h"
#import "Daylist.h"
#import "DayCaselistTableViewCell.h"
#import "CaseDetatilViewController.h"
@interface DayViewController ()
@end

@implementation DayViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.dayModel ==nil) {
        self.dayModel = [[DayModel alloc] init];
    }
    //    //初始化TableviewCell  DayCaselistTableViewCell
    UINib *nib = [UINib nibWithNibName:@"DayCaselistTableViewCell" bundle:nil];
    NSLog(@"wwwowo");
    [self.tableView registerNib:nib forCellReuseIdentifier:@"CellTableIdentifier"];
    
    // Do any additional setup after loading the view, typically from a nib.
}



//- (void)didReceiveMemoryWarning {
  //  [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
//}
//- (void)configCaseForCell:(UITableViewCell *)cell withDayModel:(DayModel *)dm{
//
//    //UILabel *label =(UILabel *) [cell viewWithTag:100];
//    cell.textLabel.text = dm.daycase;
//
//}
//- (void)configTagForCell:(UITableViewCell *)cell withDayMode:(DayModel *)dm{
//    UILabel *label = (UILabel *)[cell viewWithTag:200];
//    label.text = dm.tag;
//    
//}
//- (void)configDateForCell:(UITableViewCell *)cell withDayModel:(DayModel *)dm{
//    
//    cell.detailTextLabel.text = dm.date;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if(self.dayModel.lists ==nil){
        NSLog(@"tableviewcell行数1是：%lu",(unsigned long)[self.dayModel.lists count]);

    }

    return [self.dayModel.lists count];
   }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    Daylist *daylist = self.dayModel.lists[indexPath.row];
//    [self performSegueWithIdentifier:@"ShowDay" sender:daylist];



}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   static NSString *identifier = @"CellTableIdentifier";
    DayCaselistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
   
    Daylist *dm = self.dayModel.lists[indexPath.row];
    cell.dayList = dm;
    NSLog(@"我是daylist %@",dm.dayCaseContent);
    return cell;
}
//addNewday
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"AddDay"]) {
        CaseDetatilViewController *controller = segue.destinationViewController;
        controller.delegate = self;
        controller.daylist = nil;
        NSLog(@"已经确定代理%@",controller.delegate);
    }else if([segue.identifier isEqualToString:@"ShowDay"]){
    
        CaseDetatilViewController *controller = segue.destinationViewController;
        controller.delegate = self;
        controller.daylist = sender;
    
    
    
    }

}
#pragma mark - CaseDetailVCdelegate
- (void)caseDetailViewController:(CaseDetatilViewController *)controller didFinishAddingDay:(Daylist *)dayList{

    NSLog(@"收到消息");
    [self.dayModel.lists addObject:dayList];
    NSLog(@"tableviewcell行是：%@",dayList.dayCaseContent);
 
    if (self.dayModel.lists == nil) {
        NSLog(@"lists数组还没有初始化，现在为nil");
    }
    [self.tableView reloadData];
//    [self present:controller animated:YES completion:nil];

    [self.navigationController popViewControllerAnimated:YES];

}
- (void)caseDetailViewController:(CaseDetatilViewController *)controller didEditingAddingDay:(Daylist *)dayModel{

    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];


}
@end
