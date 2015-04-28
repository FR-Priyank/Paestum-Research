//
//  ReactViewController.m
//  Paestum
//
//  Created by Priyank on 24/04/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import "ReactViewController.h"
#import "ReactView.h"

@interface ReactViewController ()
@property (weak, nonatomic) IBOutlet ReactView *reactView;
@end

@implementation ReactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    //Refresh the React view contents as images are not loading when you come back to this view controller again after navigating else where
    [self.reactView refresh];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
