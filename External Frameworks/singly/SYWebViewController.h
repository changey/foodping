//
//  SYWebViewController.h
//  Singly API Example
//
//  Written by Justin Mecham <justin@mecham.net>
//  Copyright (c) 2012 Singly, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYWebViewController : UIViewController

@property (retain, nonatomic) NSString *endpoint;
@property (retain, nonatomic) NSString *token;
@property (retain, nonatomic) IBOutlet UIWebView *webView;

@end
