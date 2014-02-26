//
//  AppDelegate.h
//  app
//
//  Created by Ryosuke Sasaki on 2014/01/02.
//  Copyright (c) 2014年 Ryosuke Sasaki. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

// textForm用のグローバル変数
@property (nonatomic,retain)NSString *contentText;
@property (nonatomic,retain)NSString *descriptionText;
@property (nonatomic,retain)NSString *placeHolderText;
@property (nonatomic,retain) NSMutableArray *textFormBoxes;

@property (strong, nonatomic) UIWindow *window;
@end
