//
//  FormClass.m
//  app
//
//  Created by Ryosuke Sasaki on 2014/01/04.
//  Copyright (c) 2014年 Ryosuke Sasaki. All rights reserved.
//

#import "FormClass.h"
#import "NewForm.h"
#import "AppDelegate.h"
#import "UIPlaceHolderTextView.h"

@interface FormClass ()
@property (weak, nonatomic) IBOutlet UITextField *content;
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *description;
@property (weak, nonatomic) IBOutlet UITextField *placeHolder;

@end

@implementation FormClass

- (IBAction)singleTap:(id)sender {
    // 背景をタップすることでキーボードを閉じる
    [self.view endEditing:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _content.delegate = self;
    _placeHolder.delegate = self;
    _content.placeholder = @"ex. 出身地はどこですか?";
    _description.placeholder = @"ex. 出身地は県名から番地までご記入をお願いします";
    _placeHolder.placeholder = @"ex. 神奈川県大和市鶴間2丁目";
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // キーボードを引っ込める
    [self.view endEditing:YES];
    // 改行コードを入力しない
    return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    AppDelegate *delegate =[[UIApplication sharedApplication] delegate];
    
    // textFormを編集終了後にグローバル変数に代入する
    delegate.contentText = _content.text;
    delegate.descriptionText = _description.text;
    delegate.placeHolderText = _placeHolder.text;
    
}

- (IBAction)unwindSegueFormClass:(UIStoryboardSegue *)segue
{
    // 処理を委譲する
}


@end
