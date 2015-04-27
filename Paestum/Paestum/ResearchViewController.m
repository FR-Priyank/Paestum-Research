//
//  ResearchViewController.m
//  Paestum
//
//  Created by Priyank on 30/03/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import "ResearchViewController.h"
#import "WTCCard.h"
#import "WTCCardCell.h"
#import "WTCModel.h"
#import "Communicator.h"
#import "SDWebImageManager.h"
#import "WTCHeaderViewCollectionReusableView.h"
#import "InterfaceOrientation.h"

@interface ResearchViewController()<CommunicatorProtocol>
@property (weak, nonatomic) IBOutlet WTCCard *placeholderview;
@property (strong, nonatomic) NSMutableArray *cardmodels;
@property (strong, nonatomic) Communicator *communicator;

@end

@implementation ResearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Load data
    self.communicator = [[Communicator alloc]init];
    self.communicator.commdelegate = self;
    [self.communicator getWTCData];
    
    self.cardmodels = [[NSMutableArray alloc]init];
    self.placeholderview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.placeholderview.layer.cornerRadius = 15.0f;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewWillLayoutSubviews{
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGRect initframe = self.placeholderview.frame;
    CGRect frame = CGRectMake(initframe.origin.x, initframe.origin.y, screenSize.width - 20, screenSize.height);
    
    if (self.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiomPad){
        frame.size.height = 350;
    }else{
        frame.size.height -= 170;
    }
    self.placeholderview.frame = frame;
    
    [self.placeholderview reloadView];
}


#pragma mark - Communicator Protocol Methods

-(void)getResponse:(NSData *)responseData{
    
    NSError *error;
    
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    NSDictionary *data = [dictionary objectForKey:@"data"];
    NSDictionary *whoToCallPage = [data objectForKey:@"whoToCallPage"];
    NSArray *topAccount = [whoToCallPage objectForKey:@"topAccount"];
    
    for(NSDictionary *dict in topAccount){
        [self.cardmodels addObject:[[WTCModel alloc]initWithDictionary:dict]];
    }
    
    self.placeholderview.cardmodels = self.cardmodels;
    [self.placeholderview reloadView];
}

-(void)getResponseError:(NSError *)error{
    UIAlertView *errorAlert  = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Network Error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
    
}

#pragma mark - Helper methods

//-(UIImage *)getImageForURL:(NSString *)urlString{
//    [[SDWebImageManager sharedManager] downloadWithURL:[NSURL URLWithString:urlString] options:SDWebImageRefreshCached progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
//        //return image;
//    }];
//}

@end