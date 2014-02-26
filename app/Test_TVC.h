//
//  Test_TVC.h
//  app
//
//  Created by Ryosuke Sasaki on 2014/01/14.
//  Copyright (c) 2014年 Ryosuke Sasaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Test_TVC : UITableViewController <NSXMLParserDelegate>
{
//xml解析で使用
NSString *nowTagStr;
NSString *txtBuffer;

//ユーザ名を格納する配列
NSMutableArray *userArr;

//xmlの数を入れる数値
NSInteger xml_index;


//通信コネクト
NSURLConnection *connect;

//受信データ
NSMutableData *data;

//LoadingView(通信中にぐるぐる回るやつ)
UIView *uv_load;
}
@end
