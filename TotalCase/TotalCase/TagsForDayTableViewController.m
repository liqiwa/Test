//
//  TagsForDayTableViewController.m
//  
//
//  Created by 王琳琳 on 17/3/9.
//
//

#import "TagsForDayTableViewController.h"
#import "PushTagsForDayTableViewController.h"
@interface TagsForDayTableViewController ()
{

    NSMutableArray *tagsArray;
    NSMutableArray *selectedTag;
    NSMutableArray *unselectedTag;
    TagsForDay *allTagsDay ;
    BOOL tagArraystate;
}
@end

@implementation TagsForDayTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化底部的uitoolbar控件
//    [self.navigationController setToolbarHidden:NO];
//    [self.navigationController.toolbar setTranslucent:NO];
//    [self.navigationController.toolbar setTintColor:[UIColor blackColor]];
//    [self.navigationController.toolbar setBackgroundColor:[UIColor orangeColor]];
//   
   // [self initToolbar];
    allTagsDay = [[TagsForDay alloc] init];
    if(allTagsDay.tagArray !=nil){
        unselectedTag = [allTagsDay.tagArray mutableCopy];
        [self initTagsName:self.editDaylist.dayCaseTag];
        [self compareTagsArray];
    }else{
    
        tagArraystate = NO;
        
    }
    
    
    
   
    // self.toolBarForEdit.frame = CGRectMake(0, self.view.frame.origin.y, 414, 44);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewWillAppear:(BOOL)animated{

    [self.navigationController setToolbarHidden:NO animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initTagsName:(NSMutableArray *)tagsNameArray{
    selectedTag = [[NSMutableArray alloc]init];

    if (tagsNameArray != nil) {
    
               selectedTag = self.editDaylist.dayCaseTag;
    
    }else{
    
        selectedTag = nil;
        
    }
//    TagsForDay *tag1 = [[TagsForDay alloc] init];
//    tag1.tagName = @"工作";
//    tag1.tagNumber = 2;
//    tag1.tagchecked = YES;
//    TagsForDay *tag2 = [[TagsForDay alloc] init];
//    tag2.tagName = @"家庭";
//    tag2.tagNumber = 1;
//    tag2.tagchecked = NO;
//    TagsForDay *tag3 = [[TagsForDay alloc] init];
//    tag3.tagName = @"事业";
//    tag3.tagNumber = 2;
//    tag3.tagchecked = YES;
//    TagsForDay *tag4 = [[TagsForDay alloc] init];
//    tag4.tagName = @"天气";
//    tag4.tagNumber = 2;
//    tag4.tagchecked = YES;
//    TagsForDay *tag5 = [[TagsForDay alloc] init];
//    tag5.tagName = @"100天";
//    tag5.tagNumber = 2;
//    tag5.tagchecked = NO;
//    TagsForDay *tag6 = [[TagsForDay alloc] init];
//    tag6.tagName = @"坚持";
//    tag6.tagNumber = 2;
//    tag6.tagchecked = NO;
    //_tagArray = [NSMutableArray arrayWithArray:@[tag1,tag2,tag3,tag4,tag5,tag6]];
    
   

    NSLog(@"我是用户选择的，传递成功%@",selectedTag);
}
//- (void)initToolbar{
//    //添加UIBarButtonItem
//    UIBarButtonItem *editButton =[[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(tagsEdit)];
//    editButton.width = 150;
//    UIBarButtonItem *addButton =[[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(tagsAdd)];
//    addButton.width = 150;
//    
//    // 添加空格间距
//    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    
//    NSArray *itemsArray = @[fixedSpace,editButton,flexibleSpace,addButton,fixedSpace];
//    self.toolbarItems = itemsArray;
//    
//
//}
//- (void)tagsEdit{
//
//    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    UIBarButtonItem *finishButton =[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(tagsFinish)];
//    NSArray *itemsArray = @[flexibleSpace,finishButton,flexibleSpace];
//    self.toolbarItems = itemsArray;
//}
//
//- (void)tagsAdd{
//    
//    NSLog(@"跳转添加页面");
//
//    PushTagsForDayTableViewController *addTagsVc = [[PushTagsForDayTableViewController alloc]init];
//    [self.navigationController pushViewController:addTagsVc animated:YES];
//    
//}
//- (void)tagsFinish{
//
//    NSLog(@"完成修改");
//    [self initToolbar];
//
//}

- (IBAction)finishButton{

    [self.delegate TagsForDayTableViewControllerDidCancle:self];
    NSLog(@"我是delegate");

}
- (IBAction)addButton{

    

}
- (void)compareTagsArray{
    for (int i = 0; i < selectedTag.count ;i++) {
        for (int j = 0; j< unselectedTag.count; j++) {
            if ([[selectedTag[i] tagName] isEqualToString:[unselectedTag[j] tagName]])
            {
                [unselectedTag removeObjectAtIndex:j];
            }
            
        }
        
    }
       NSLog(@"用户没用选择的数组是%@",unselectedTag);

}
#pragma mark - configCell
- (void)configCheckedForCell:(UITableViewCell *)cell withTagsForDay:(TagsForDay *)tagDay{
    
    UILabel *tagChecked = (UILabel *)[cell viewWithTag:1001];
    if (tagDay.tagchecked == YES) {
        tagChecked.text = @"√";
    }else{
        tagChecked.text = @"";
        
    }
    
    
}
- (void)configNameForCell:(UITableViewCell *)cell withTagsForDay:(TagsForDay *)tagDay{
    UILabel *tagName  = (UILabel *)[cell viewWithTag:1002];

    if (tagDay == nil) {
        tagName.text = @"请添加一个备注wowowoooowwwoowowow";
    }else{
    tagName.text = tagDay.tagName;
    NSLog(@"事情的名字是%@",tagName.text);
    }
}
- (void)configNumberForCell:(UITableViewCell *)cell withTagsForDay:(TagsForDay *)tagDay{

    UILabel *tagNumber = (UILabel *)[cell viewWithTag:1003];
    tagNumber.text = [NSString stringWithFormat:@"%d",tagDay.tagNumber];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    
    if (section == 0) {
        return [selectedTag count]?[selectedTag count]:1;
    }else if(section == 1){
    
        return [unselectedTag count];
    
    }
    return 0;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    if(selectedTag == nil){
        return 1;
    }
    return 2;

}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    NSString *string ;
    if (section == 0) {
        if (selectedTag == nil) {
            string = @"";
            NSLog(@"我选择的tag是%@",selectedTag);
        }else{
            string = @"用户选择的数据";}
    }else{
    
      string = @"未选择数据";
    }
    
    return string;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TagCell"];
    TagsForDay *tags = selectedTag[indexPath.row];
    if (selectedTag != nil)
    {
            if(indexPath.section == 0)
    {
       
    [self configCheckedForCell:cell withTagsForDay:tags];
    [self configNameForCell:cell withTagsForDay:tags];
    [self configNumberForCell:cell withTagsForDay:tags];
    }else if (indexPath.section == 1){
        TagsForDay *tags = unselectedTag[indexPath.row];
        
        [self configCheckedForCell:cell withTagsForDay:tags];
        [self configNameForCell:cell withTagsForDay:tags];
        [self configNumberForCell:cell withTagsForDay:tags];
        
    
    }
    }else{
    
               tags = nil;
        [self configNameForCell:cell withTagsForDay:tags];
    
    }
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
