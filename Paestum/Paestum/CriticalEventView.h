//
//  CriticalEventView.h
//  Paestum
//
//  Created by Priyank on 01/04/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CriticalEventView : UIView
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *detail;
@property (strong, nonatomic) UIColor *bkcolor;

-(void)updateView;

@end
