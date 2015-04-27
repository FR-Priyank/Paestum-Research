//
//  PerCardHTMLViewController.m
//  Paestum
//
//  Created by Priyank on 23/04/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import "PerCardHTMLViewController.h"
#import "FRAIViewController.h"

@interface PerCardHTMLViewController () <UIWebViewDelegate>
- (IBAction)webchooser:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UIWebView *cardwebview;
@property (nonatomic, strong) FRAIViewController* activityIndicator;

@end

@implementation PerCardHTMLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.cardwebview.delegate = self;
    [self loadWebView1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadWebView1{
    
    
    NSURL *url = [NSURL URLWithString:@"https://appsdev.firstrain.com/ux/paestumv2/who_to_call.html"];
    NSURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [self.cardwebview loadRequest:request];
}

-(void)loadWebView2{
    
    
    NSURL *url = [NSURL URLWithString:@"https://appsdev.firstrain.com/ux/paestumv2/facts.html"];
    NSURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [self.cardwebview loadRequest:request];
}

- (IBAction)webchooser:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0)
        [self loadWebView1];
    else
        [self loadWebView2];
}

#pragma mark - UIWebViewDelegate methods

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self showSpinnerWithMessage:@"Loading" inView:self.cardwebview];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self stopSpinner];
}

#pragma mark - Helper methods

-(void)showSpinnerWithMessage:(NSString*)spinnerMessage inView:(UIView*)viewType
{
    //    [self setUserInteractionEnabled:NO];
    if (!self.activityIndicator) {
        self.activityIndicator = [[FRAIViewController alloc] initToShowOnView:viewType WithSpinnerLabelText:spinnerMessage];
        [self.activityIndicator setBackgroundOpacity:0.0f];
    }
    
    [self.activityIndicator startAnimatingSpinnerWithMessage:spinnerMessage];
}

-(void)stopSpinner
{
    if (self.activityIndicator != nil) {
        [self.activityIndicator stopAnimatingSpinner];
    }
    
    self.activityIndicator = nil;
    //[self setUserInteractionEnabled:YES];
}
@end
