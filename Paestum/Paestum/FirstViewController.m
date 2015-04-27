//
//  FirstViewController.m
//  Paestum
//
//  Created by Priyank on 24/03/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webview;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self loadWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadWebView{


NSURL *url = [NSURL URLWithString:@"https://paestum.firstrain.com/salesiq/landing.do?code=aFQ5UXRUSFhnQmwrRmhBaEdOd0xBcU5XWDJPQ1NUcEQxZkxDcWJQdTdFYnRTakZDeVcyK0VBSG1hZkE4Qm5EUkR6Z0FvUFBFWUltYwpGLzhYeXNMWDdlSVRZSnRSbVNONVByYkE0MWJUbTFmZ3JVajYvS0VKVFlHZitLRHZVbXBi"];
NSURLRequest *request = [NSMutableURLRequest requestWithURL:url];


[self.webview loadRequest:request];
    
}

@end
