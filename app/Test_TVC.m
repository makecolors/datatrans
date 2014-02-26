//
//  Test_TVC.m
//  app
//
//  Created by Ryosuke Sasaki on 2014/01/14.
//  Copyright (c) 2014年 Ryosuke Sasaki. All rights reserved.
//

#import "Test_TVC.h"

@interface Test_TVC ()
{
    BOOL xmlParserStartFlag;
}
@end

@implementation Test_TVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //ユーザ名格納配列　初期化
    userArr = [[NSMutableArray alloc] init];
    
    //配列番号
    xml_index = 0;
    xmlParserStartFlag = false;
    
    
    //PHPファイルのURLを設定
    NSString *url =@"http://www.makecolors.info/iphone_app/xml/sample1.xml";//ここにはそれぞれのPHPファイルのURLを指定して下さい
    
    //非同期通信　準備
    NSURL *myURL = [NSURL URLWithString:url];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:myURL];
    
    //非同期通信　開始
    connect = [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    
    
    //Loadingを表示するView(通信中にぐるぐる回るやつ) 設定
    UIScreen *sc = [UIScreen mainScreen];
    uv_load = [[UIView alloc] initWithFrame:CGRectMake(0,0,sc.applicationFrame.size.width, sc.applicationFrame.size.height)];
    uv_load.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.7];
    
    //ぐるぐる回る
    UIActivityIndicatorView *aci_loading;
    aci_loading = [[UIActivityIndicatorView alloc] init];
    aci_loading.frame = CGRectMake(0,0,sc.applicationFrame.size.width, sc.applicationFrame.size.height);
    aci_loading.center = uv_load.center;
    aci_loading.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [aci_loading startAnimating];
    
    //Loading表示
    [uv_load addSubview:aci_loading];
    [self.view addSubview:uv_load];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// XMLの解析
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    //解析中タグの初期化
    nowTagStr = @"";
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    //開始タグが user かつ name属性が含まれている場合
    if ([elementName isEqualToString:@"column"] && [attributeDict objectForKey:@"name"] != NULL)
    {
        // フラグをたてる
        xmlParserStartFlag = true;
        //解析中タグに設定
        nowTagStr = [NSString stringWithString:elementName];
        
        //テキストバッファの初期化
        txtBuffer = @"";
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    //解析中のタグが user の場合
    if ([nowTagStr isEqualToString:@"column"] && xmlParserStartFlag == true)
    {
        //テキストバッファに文字を追加する
        txtBuffer = [txtBuffer stringByAppendingString:string];
    }
}

- (void)parser:(NSXMLParser *) parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    //終了タグが user の場合
    if ([elementName isEqualToString:@"column"] && xmlParserStartFlag == true)
    {
        NSString *xml_name =txtBuffer;
        
        // フラグをおろす
        xmlParserStartFlag = false;
        //userArrにユーザ名を格納
        [userArr insertObject:xml_name atIndex:xml_index];
        
        xml_index++;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [userArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //indexPathよりrowを取得し、rowをもとにuserArr配列から街頭するユーザ名を取得
    cell.textLabel.text = [userArr objectAtIndex:indexPath.row];
    
    
    return cell;
}

//非同期通信メソッド
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // ① 接続成功し、レスポンスが返ってきた時
    
    //受信データ格納変数　初期化
    data = [[NSMutableData alloc] init];
}


- (void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)receivedData {
    // ② サーバからデータが送られた時
    
    //データを結合
    [data appendData:receivedData];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    // ③ データ受信が完了した時
    
    //受信データを文字列として確認
    NSString *respons_str = [[NSString alloc]initWithData:data
                                                 encoding:NSUTF8StringEncoding];
    NSLog(@"res=%@", respons_str);
    
    //xmlパーサー生成
    NSXMLParser *myParser = [[NSXMLParser alloc] initWithData:data];
    myParser.delegate = self;
    
    //xml解析開始
    [myParser parse];
    
    //tableviewを再描画
    [self.tableView reloadData]; // ←ここが重要！（tableを再描画しないとxmlのデータが反映されません。）
    
    //Loading非表示
    uv_load.hidden = true;
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    // ④ 通信失敗時
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"エラー" message:@"通信に失敗しました。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

@end
