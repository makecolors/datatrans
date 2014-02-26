//
//  AddItem.m
//  app
//
//  Created by Ryosuke Sasaki on 2014/01/02.
//  Copyright (c) 2014年 Ryosuke Sasaki. All rights reserved.
//

#import "AddItem.h"

@interface AddItem ()
{
    NSArray *dataSet;
    NSString *titleName;
    NSString *subTitleName;
}

@end

@implementation AddItem

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"editing";
    titleName = @"title";
    subTitleName = @"subTitle";
    
    NSDictionary *cell0 = @{titleName:@"Add TextForm", subTitleName:@"簡単なテキストフォームを追加します"};
    NSDictionary *cell1 = @{titleName:@"Add EmailForm", subTitleName:@"Eメールのフォームを追加します"};
    NSDictionary *cell2 = @{titleName:@"Add ImageForm", subTitleName:@"画像を挿入できるフォームを追加します"};
    NSDictionary *cell3 = @{titleName:@"Add Date", subTitleName:@"日付を追加します"};
    NSDictionary *cell4 = @{titleName:@"Add LabelForm", subTitleName:@"ラベルから選択できるフォームを追加します"};
    dataSet = @[cell0, cell1, cell2, cell3, cell4];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of sections.
    return [dataSet count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    NSString *cellIdentifer = @"Cell";
    
    // セルを取り出す
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:cellIdentifer forIndexPath:indexPath];
    // 指定行のセルを取り出す
    NSDictionary *theCell = dataSet[indexPath.row];
    // セルにタイトルとサブタイトルを設定する
    cell.textLabel.text = theCell[titleName];
    cell.detailTextLabel.text = theCell[subTitleName];
    // タイトルを設定済みのセルを返す
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self generateView:(int)indexPath];
}

- (void)generateView:(int)addNum
{
    //UIViewController *viewController = [[FormClass alloc] init];
    //viewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    //UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FormClass"];
    //[self presentViewController:viewController animated:YES completion:nil];
    //Storyboardを特定して
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"FormClass" bundle:nil];
    
    //そのStoryboardにある遷移先のViewConrollerを用意して
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"FormClass"];
    
    //呼び出し！
    [self presentViewController:vc animated:YES completion:nil];
}
- (IBAction)unwindSegueAddItem:(UIStoryboardSegue *)segue
{
    
}

@end
