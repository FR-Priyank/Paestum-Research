//
//  WTCBookCardCell.m
//  Paestum
//
//  Created by Priyank on 31/03/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import "WTCBookCardCell.h"
#import "CriticalEventView.h"
#import "SDWebImageManager.h"

@interface WTCBookCardCell(){
    CGFloat _shadowWidth;
}
@property (weak, nonatomic) IBOutlet CriticalEventView *criticalEvntVw1;
@property (weak, nonatomic) IBOutlet UILabel *lblFlame3;
@property (weak, nonatomic) IBOutlet UILabel *lblFlame2;
@property (weak, nonatomic) IBOutlet CriticalEventView *criticalEvntVw2;
@property (weak, nonatomic) IBOutlet CriticalEventView *criticalEvntVw3;
@property (weak, nonatomic) IBOutlet UILabel *lblFlame1;
@property (weak, nonatomic) IBOutlet UIImageView *imgFlame1;
@property (weak, nonatomic) IBOutlet UIImageView *imgFlame2;
@property (weak, nonatomic) IBOutlet UIImageView *imgFlame3;
@property (weak, nonatomic) IBOutlet UIImageView *companyImage;
@property (weak, nonatomic) IBOutlet UIImageView *actionimg1;
@property (weak, nonatomic) IBOutlet UIImageView *actionimg2;
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak) id <SDWebImageOperation> imageOperation;
@property (weak, nonatomic) IBOutlet UIButton *btnMore;
- (IBAction)showMoreDone:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *labelMoredetails;

@end

@implementation WTCBookCardCell{
    UIView *view;
    BOOL bookmarkselected;
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
    
    //set the up view
    [self setupView];
}


-(UIView *)loadViewFromNib{
    NSBundle *bundle = [NSBundle mainBundle];
    NSArray *viewarray = [bundle loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    UIView *customview = [viewarray objectAtIndex:0];
    
    return customview;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    if (_shadowWidth != bounds.size.width)
    {
        if (_shadowWidth == 0)
        {
            [self.layer setMasksToBounds:NO ];
            [self.layer setShadowColor:[[UIColor blackColor ] CGColor ] ];
            [self.layer setShadowOpacity:0.5 ];
            [self.layer setShadowRadius:5.0 ];
            [self.layer setShadowOffset:CGSizeMake( 0 , 0 ) ];
            self.layer.cornerRadius = 5.0;
        }
        [self.layer setShadowPath:[[UIBezierPath bezierPathWithRect:bounds ] CGPath ] ];
        _shadowWidth = bounds.size.width;
    }
}

- (void)flipTransitionWithOptions:(UIViewAnimationOptions)options halfway:(void (^)(BOOL finished))halfway completion:(void (^)(BOOL finished))completion{
    
    CGFloat degree = (options & UIViewAnimationOptionTransitionFlipFromRight) ? -M_PI_2 : M_PI_2;
    
    CGFloat duration = 0.4;
    CGFloat distanceZ = 2000;
    CGFloat translationZ = self.frame.size.width / 2;
    CGFloat scaleXY = (distanceZ - translationZ) / distanceZ;
    
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -distanceZ; // perspective
    rotationAndPerspectiveTransform = CATransform3DTranslate(rotationAndPerspectiveTransform, 0, 0, translationZ);
    
    rotationAndPerspectiveTransform = CATransform3DScale(rotationAndPerspectiveTransform, scaleXY, scaleXY, 1.0);
    self.layer.transform = rotationAndPerspectiveTransform;
    
    [UIView animateWithDuration:duration / 2 animations:^{
        self.layer.transform = CATransform3DRotate(rotationAndPerspectiveTransform, degree, 0.0f, 1.0f, 0.0f);
    } completion:^(BOOL finished){
        if (halfway) halfway(finished);
        self.layer.transform = CATransform3DRotate(rotationAndPerspectiveTransform, -degree, 0.0f, 1.0f, 0.0f);
        [UIView animateWithDuration:duration / 2 animations:^{
            self.layer.transform = rotationAndPerspectiveTransform;
        } completion:^(BOOL finished){
            self.layer.transform = CATransform3DIdentity;
            if (completion) completion(finished);
        }];
    }];
}

-(void)setupView{
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAction1)];
    [self.actionimg1 addGestureRecognizer:tapGesture1];
    [self.actionimg1 setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAction2)];
    [self.actionimg2 addGestureRecognizer:tapGesture2];
    [self.actionimg2 setUserInteractionEnabled:YES];
}

-(void)didTapAction1{
    if (self.cellDelegate && [self.cellDelegate conformsToProtocol:@protocol(WTCBookCardCellDelegate)]) {
        if ([self.cellDelegate respondsToSelector:@selector(didTapActionImage:)]) {
            [self.cellDelegate didTapActionImage:self.actionimg1];
        }
    }
}

-(void)didTapAction2{
    if(!bookmarkselected){
        self.actionimg2.image = [UIImage imageNamed:@"bookmarkselected"];
        bookmarkselected = YES;
    }
    else{
        self.actionimg2.image = [UIImage imageNamed:@"bookmark"];
        bookmarkselected = NO;
    }
}

-(void)updateCell{
    [self setImage];
    self.companyName.text = self.compName;
    
    self.actionimg1.image = [UIImage imageNamed:@"share"];
    self.actionimg2.image = [UIImage imageNamed:@"bookmark"];
    
    self.imgFlame1.image = [UIImage imageNamed:@"Flame1"];
    self.imgFlame2.image = [UIImage imageNamed:@"Flame2"];
    self.imgFlame3.image = [UIImage imageNamed:@"Flame3"];
    
    self.lblFlame1.text = [NSString stringWithFormat:@"%d",self.cntFlame1];
    self.lblFlame2.text = [NSString stringWithFormat:@"%d",self.cntFlame2];
    self.lblFlame3.text = [NSString stringWithFormat:@"%d",self.cntFlame3];
    
    //Update Critical Event Views
    self.criticalEvntVw1.title = self.title1;
    self.criticalEvntVw1.bkcolor = self.bkColor1;
    self.criticalEvntVw1.detail = self.detail1;
    [self.criticalEvntVw1 updateView];
    
    self.criticalEvntVw2.title = self.title2;
    self.criticalEvntVw2.bkcolor = self.bkColor2;
    self.criticalEvntVw2.detail = self.detail2;
    [self.criticalEvntVw2 updateView];
    
    self.criticalEvntVw3.title = self.title3;
    self.criticalEvntVw3.bkcolor = self.bkColor3;
    self.criticalEvntVw3.detail = self.detail3;
    [self.criticalEvntVw3 updateView];
}

-(void)setImage{
    if(self.compImageURL){
        self.imageOperation = [[SDWebImageManager sharedManager] downloadWithURL:[NSURL URLWithString:self.compImageURL] options:SDWebImageRefreshCached progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
            if(image!=nil && !error){
                self.companyImage.image = image;
            }
        }];
    }else{
        self.companyImage.image=[UIImage imageNamed:@"Group"];
    }
}

- (void)prepareForReuse{
    [super prepareForReuse];
    
    if (self.imageOperation)
        [self.imageOperation cancel];
    self.imageOperation = nil;
}

- (IBAction)showMoreDone:(id)sender {
    if (self.cellDelegate && [self.cellDelegate conformsToProtocol:@protocol(WTCBookCardCellDelegate)]) {
        if ([self.cellDelegate respondsToSelector:@selector(didTapMoreDone:)]) {
            [self.cellDelegate didTapMoreDone:self];
        }
    }
}

- (void)setFlippedState:(BOOL)flipped{
    self.flipped = flipped;
    [self.labelMoredetails setHidden:!flipped];
    
    [self.criticalEvntVw1 setHidden:flipped];
    [self.lblFlame3 setHidden:flipped];
    [self.lblFlame2 setHidden:flipped];
    [self.criticalEvntVw2 setHidden:flipped];
    [self.criticalEvntVw3 setHidden:flipped];
    [self.lblFlame1 setHidden:flipped];
    [self.imgFlame1 setHidden:flipped];
    [self.imgFlame2 setHidden:flipped];
    [self.imgFlame3 setHidden:flipped];
    [self.actionimg1 setHidden:flipped];
    [self.actionimg2 setHidden:flipped];
    
    if(flipped)
        self.btnMore.titleLabel.text = @"Done";
    else
        self.btnMore.titleLabel.text = @"More";
}
@end
