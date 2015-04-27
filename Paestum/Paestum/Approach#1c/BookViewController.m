//
//  BookViewController.m
//  Paestum
//
//  Created by Priyank on 27/03/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import "BookViewController.h"
#import "WTCBookCard.h"
#import "WTCModel.h"
#import "Communicator.h"
#import "SDWebImageManager.h"
#import "WTCHeaderViewCollectionReusableView.h"
#import "InterfaceOrientation.h"
#import "FRAIViewController.h"


@interface BookViewController ()<CommunicatorProtocol, WTCBookCardDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet WTCBookCard *placeholderview;
@property (strong, nonatomic) NSMutableArray *cardmodels;
@property (strong, nonatomic) Communicator *communicator;
@property (nonatomic, strong) FRAIViewController* activityIndicator;

@end

@implementation BookViewController

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
    self.placeholderview.cardDelegate = self;
    
    [self showSpinnerWithMessage:@"" inView:self.placeholderview];
    
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
        frame.size.height = 550;
    }else{
        frame.size.height -= 170;
    }
    self.placeholderview.frame = frame;
    
    [self.placeholderview reloadView];
}



-(void)didTapActionImage:(UIView *)targetView{
    UIAlertController *alertController;
    UIAlertAction *destroyAction;
    UIAlertAction *emailAction, *twitterAction, *chatterAction, *linkedinAction;
    
    alertController = [UIAlertController alertControllerWithTitle:nil
                                                          message:nil
                                                   preferredStyle:UIAlertControllerStyleActionSheet];
    destroyAction = [UIAlertAction actionWithTitle:@"Cancel"
                                             style:UIAlertActionStyleDestructive
                                           handler:^(UIAlertAction *action) {
                                               // do destructive stuff here
                                           }];
    emailAction = [UIAlertAction actionWithTitle:@"Email Article"
                                           style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction *action) {
                                             // do something here
                                         }];
    twitterAction = [UIAlertAction actionWithTitle:@"Share via Twitter"
                                           style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction *action) {
                                             // do something here
                                         }];
    chatterAction = [UIAlertAction actionWithTitle:@"Share via Chatter"
                                           style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction *action) {
                                             // do something here
                                         }];
    linkedinAction = [UIAlertAction actionWithTitle:@"Share via LinkedIn"
                                           style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction *action) {
                                             // do something here
                                         }];
    // note: you can control the order buttons are shown, unlike UIActionSheet
    [alertController addAction:emailAction];
    [alertController addAction:twitterAction];
    [alertController addAction:chatterAction];
    [alertController addAction:linkedinAction];
    [alertController addAction:destroyAction];
    [alertController setModalPresentationStyle:UIModalPresentationPopover];
    
    UIPopoverPresentationController *popPresenter = [alertController
                                                     popoverPresentationController];
    popPresenter.sourceView = targetView;
    popPresenter.sourceRect = targetView.bounds;
    [self presentViewController:alertController animated:YES completion:nil];
    
}


#pragma mark - Communicator Protocol Methods

-(void)getResponse:(NSData *)responseData{
    
    [self stopSpinner];
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
//-(UIImage *)getImageForURL:(NSString *)urlString{
//    [[SDWebImageManager sharedManager] downloadWithURL:[NSURL URLWithString:urlString] options:SDWebImageRefreshCached progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
//        //return image;
//    }];
//}

@end
