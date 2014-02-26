//
//  SendMenu.m
//  app
//
//  Created by Ryosuke Sasaki on 2014/01/06.
//  Copyright (c) 2014年 Ryosuke Sasaki. All rights reserved.
//

#import "SendMenu.h"
#import "AppDelegate.h"
#import "TextForm.h"

@interface SendMenu ()

- (NSString *)returnPostString:(NSMutableArray *)array;
@end
@implementation SendMenu


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    AppDelegate *delegate =[[UIApplication sharedApplication] delegate];
    
    // POST通信の中身を作成(グローバル変数の内容を渡している)
    NSString *string = [self returnPostString:delegate.textFormBoxes];
    
    NSString *content = string;
    NSURL* url = [NSURL URLWithString:@"http://www.makecolors.info/iphone_app/index.php"];
    
    NSMutableURLRequest* urlRequest = [[NSMutableURLRequest alloc]initWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[content dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLResponse* response;
    NSError* error = nil;
    NSData* result = [NSURLConnection sendSynchronousRequest:urlRequest
                                           returningResponse:&response
                                                       error:&error];
    if(error)
        NSLog(@"error = %@", error);
    
    NSString* resultString = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    NSLog(@"%@", resultString);
    
}

- (NSString *)returnPostString:(NSMutableArray *)array{
    //NSMutableOrderedSet *orderbox = [NSMutableOrderedSet orderedSetWithArray:array];
    int i = 0;
    NSMutableString *postString = [[NSMutableString alloc] init]; // NSStringは不可変なので、文字列の変更が多いことから可変であるNSMutableStringを採用する
    for(TextForm *textForm in array)
    {
        NSString *tempPostString = [NSString stringWithFormat:@"textFormContent%d=%@&textFormPlaceHolder%d=%@&textFormDescription%d=%@&",i, textForm.content, i, textForm.placeHolder, i, textForm.description]; // 最後の&は後で取り除く
        [postString appendString:tempPostString];
        i++;
    }
    
    if(postString != NULL) // postStringの中身が空でなければ
        postString = (NSMutableString *)[postString substringToIndex:(postString.length - 1)]; // 最後の&を削除する
    

    return (NSString *)postString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
