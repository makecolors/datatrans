//
//  NewForm.m
//  app
//
//  Created by Ryosuke Sasaki on 2014/01/04.
//  Copyright (c) 2014年 Ryosuke Sasaki. All rights reserved.
//

#import "AppDelegate.h"
#import "NewForm.h"
#import "SendMenu.h"
#import "TextForm.h"
#import "FormClass.h"

#define HEIGHT_TEXTFORM 30
#define OUT_MARGIN 20
#define IN_MARGIN 10

@interface NewForm ()
{
    int formHeight;
    CGRect windowSize;
    NSMutableArray *boxes;
    int loopCount;
}
- (void)addView;
- (void)textFormAdd;
@property (weak, nonatomic) IBOutlet UIButton *buttonCloseEditer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation NewForm


- (void)viewDidLoad
{
    [super viewDidLoad];
    // scrollViewを扱うための設定
    _scrollView.delegate = self;
    _scrollView.scrollEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = YES;
    
    formHeight = 0;
    loopCount = 1;
    windowSize = [[UIScreen mainScreen] bounds];
    // まとめて送信するためのformbox
    boxes = [NSMutableArray array];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

// 呼ばれるhogeメソッド
-(void)hoge:(UITextField*)textfield{
    // ここに何かの処理を記述する
    // （引数の textfield には呼び出し元のUITextFieldオブジェクトが引き渡されてきます）
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// テキストフォームを受け取ってフォームを表示する
- (IBAction)unwindSegueNewForm:(UIStoryboardSegue *)segue
{
    [self addView];
    
    // グローバル変数をあるクラスに移し替えて保持する
    [self textFormAdd];
    
}
- (void)addView
{
    UIView *customView = [[UIView alloc] init];
    int prevY = formHeight + OUT_MARGIN;
    AppDelegate *delegate = [[UIApplication sharedApplication]delegate];
    int variation = 0;
    
    formHeight += OUT_MARGIN;
    // ラベルの設置
    UILabel *content_newform = [[UILabel alloc]initWithFrame:CGRectMake(10, variation + 5, windowSize.size.width - 40, 25)];
    // ラベルのテキストを設定
    content_newform.text = [NSString stringWithFormat:@"Q%d. %@",loopCount, delegate.contentText];
    // ラベルのテキストの行数設定
    content_newform.numberOfLines = 0; // 0の場合は無制限
    // ラベルの行数を調整
    [content_newform sizeToFit];
    // ラベルをビューに追加
    [customView addSubview:content_newform];
    // 高さを加える
    variation += content_newform.frame.size.height + IN_MARGIN;
    formHeight += (content_newform.frame.size.height + IN_MARGIN);
    
    // ラベルの設置
    UILabel *description_newform = [[UILabel alloc]initWithFrame:CGRectMake(10, variation + 5, windowSize.size.width - 40, 25)];
    // ラベルのテキストを設定
    description_newform.text = [NSString stringWithFormat:@"※%@", delegate.descriptionText];
    // ラベルのテキストの行数設定
    description_newform.numberOfLines = 0; // 0の場合は無制限
    // ラベルの行数を調整
    [description_newform sizeToFit];
    // ラベルをビューに追加
    [customView addSubview:description_newform];
    // 高さを加える
    variation += description_newform.frame.size.height + IN_MARGIN;
    formHeight += (description_newform.frame.size.height + IN_MARGIN);
  
  
    // テキストフィールドの設置
    UITextField *placeHolder_newform = [[UITextField alloc] initWithFrame:CGRectMake(10, variation + 5, windowSize.size.width - 40, 30)];
    placeHolder_newform.borderStyle = UITextBorderStyleRoundedRect;
    placeHolder_newform.placeholder = delegate.placeHolderText;// @"記入してください";
    placeHolder_newform.clearButtonMode = UITextFieldViewModeAlways;
    // 編集終了後フォーカスが外れた時にhogeメソッドを呼び出す
    [placeHolder_newform addTarget:self action:@selector(hoge:)forControlEvents:UIControlEventEditingDidEndOnExit];
    // テキストフィールドをビューに追加
    [customView addSubview:placeHolder_newform];
    // 高さを加える
    variation += placeHolder_newform.frame.size.height + IN_MARGIN;
    formHeight += (placeHolder_newform.frame.size.height + IN_MARGIN);
  
    // Viewのサイズ変更
    customView.frame = CGRectMake(10, prevY, windowSize.size.width - 20, variation);
    self.scrollView.contentSize = CGSizeMake(320, formHeight+50);
    // ボタンの移動
    CGRect frame = _buttonCloseEditer.frame;
    frame.origin.y = (prevY + variation);
    _buttonCloseEditer.frame = frame;
    // countを増やす
    loopCount++;
    // カスタムビューの追加
    customView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:customView];
}

- (void)textFormAdd
{
    AppDelegate *delegate = [[UIApplication sharedApplication]delegate];
    TextForm *textform = [[TextForm alloc] init];
    
    // 追加したい項目がある場合ここに記入する
    textform.placeHolder = [NSString stringWithString:delegate.placeHolderText];
    textform.content = [NSString stringWithString:delegate.contentText];
    textform.description = [NSString stringWithString:delegate.descriptionText];
    [delegate.textFormBoxes addObject:textform];
}

@end

