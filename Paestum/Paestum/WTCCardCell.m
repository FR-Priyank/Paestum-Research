//
//  WTCCardCell.m
//  Paestum
//
//  Created by Priyank on 27/03/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import "WTCCardCell.h"
#import "SDWebImageManager.h"

@interface WTCCardCell()
@property (weak, nonatomic) IBOutlet UILabel *lblFlame3;
@property (weak, nonatomic) IBOutlet UILabel *lblFlame2;
@property (weak, nonatomic) IBOutlet UILabel *lblFlame1;
@property (weak, nonatomic) IBOutlet UIImageView *imgFlame1;
@property (weak, nonatomic) IBOutlet UIImageView *imgFlame2;
@property (weak, nonatomic) IBOutlet UIImageView *imgFlame3;
@property (weak, nonatomic) IBOutlet UIImageView *companyImage;
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak) id <SDWebImageOperation> imageOperation;
@end

@implementation WTCCardCell{
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
    view.layer.cornerRadius = 7.0f;
    [self addSubview:view];
    
}


-(UIView *)loadViewFromNib{
        NSBundle *bundle = [NSBundle mainBundle];
        NSArray *viewarray = [bundle loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
        UIView *customview = [viewarray objectAtIndex:0];
        
        return customview;
}

-(void)updateCell{
    [self setImage];
    self.companyName.text = self.compName;
    
    self.imgFlame1.image = [UIImage imageNamed:@"Flame1"];
    self.imgFlame2.image = [UIImage imageNamed:@"Flame2"];
    self.imgFlame3.image = [UIImage imageNamed:@"Flame3"];
    
    self.lblFlame1.text = [NSString stringWithFormat:@"%d",self.cntFlame1];
    self.lblFlame2.text = [NSString stringWithFormat:@"%d",self.cntFlame2];
    self.lblFlame3.text = [NSString stringWithFormat:@"%d",self.cntFlame3];
}

-(void)setImage{
    if(self.compImageURL){
        self.imageOperation = [[SDWebImageManager sharedManager] downloadWithURL:[NSURL URLWithString:self.compImageURL] options:SDWebImageRefreshCached progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
            if(image!=nil && !error){
                self.companyImage.image = image;
            }
        }];
    }
}

- (void)prepareForReuse{
    [super prepareForReuse];
    
    if (self.imageOperation)
        [self.imageOperation cancel];
    self.imageOperation = nil;
}

@end