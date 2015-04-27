//
//  CriticalEventView.m
//  Paestum
//
//  Created by Priyank on 01/04/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import "CriticalEventView.h"

@interface CriticalEventView()
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITextView *txtDetail;
@property (weak, nonatomic) IBOutlet UIView *lblBackground;
@end

@implementation CriticalEventView{
    UIView *view;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self xibSetup];
    }
    
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self xibSetup];
    }
    
    return self;
}

-(void)xibSetup{
    view = [self loadViewFromNib];
    view.frame = self.bounds;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:view];
    
}


-(UIView *)loadViewFromNib{
    NSBundle *bundle = [NSBundle mainBundle];
    NSArray *viewarray = [bundle loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    UIView *customview = [viewarray objectAtIndex:0];
    
    return customview;
}

-(void)updateView{
    self.lblTitle.text = self.title;
    self.txtDetail.text = self.detail;
    self.lblBackground.backgroundColor = self.bkcolor;
}

@end