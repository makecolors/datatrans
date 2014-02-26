//
//  UIPlaceHolderTextView.h
//  app
//
//  Created by Ryosuke Sasaki on 2014/01/10.
//  Copyright (c) 2014年 Ryosuke Sasaki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIPlaceHolderTextView : UITextView

@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end