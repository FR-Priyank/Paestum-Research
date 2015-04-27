//
//  SecondViewController.m
//  Paestum
//
//  Created by Priyank on 24/03/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation SecondViewController

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
    
    
    NSURL *url = [NSURL URLWithString:@"https://devapps.firstrain.com/paestumstatic/landing?code=K1ZKbTcrVndEdE9aeVRKSTJhVytXbnRmekFLcm9HT0FuYzVxK0Vmdktza0lxZjFRR1JCY3R0RWxZNTV1TVpxY2ZOb056dTlXa0hPZQpsTzRFUG5kZkdKaCswK2FkYTVxeUpaeWh3NmhFVlJRdGc0QXByR0pvTElHZitLRHZVbXBi"];
    NSURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    
    [self.webview loadRequest:request];
    
}

@end
