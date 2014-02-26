//
//  AppDelegate.m
//  app
//
//  Created by Ryosuke Sasaki on 2014/01/02.
//  Copyright (c) 2014年 Ryosuke Sasaki. All rights reserved.
//

#import "AppDelegate.h"
#import "TextForm.h"
@interface AppDelegate()
@end

@implementation AppDelegate

// getter, setterメソッドを作るために必要な構文
// textForm用の@synthesize
@synthesize placeHolderText;
@synthesize descriptionText;
@synthesize contentText;
@synthesize textFormBoxes;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    textFormBoxes = [NSMutableArray array]; // textFormBoxesの初期化
    return YES;
}

@end
