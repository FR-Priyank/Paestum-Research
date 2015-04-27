//
//  WTCBookCardCell.h
//  Paestum
//
//  Created by Priyank on 31/03/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WTCBookCardCellDelegate <NSObject>

@optional
-(void)didTapActionImage:(UIView *)cell;
-(void)didTapMoreDone:(id)sender;
@end

@interface WTCBookCardCell : UICollectionViewCell
@property (strong, nonatomic) NSString *compName;
@property (strong, nonatomic) NSString *compImageURL;
@property (assign, nonatomic) NSInteger cntFlame1;
@property (assign, nonatomic) NSInteger cntFlame2;
@property (assign, nonatomic) NSInteger cntFlame3;
@property (nonatomic, assign)id <WTCBookCardCellDelegate> cellDelegate;

@property (strong, nonatomic) NSString *title1;
@property (strong, nonatomic) UIColor *bkColor1;
@property (strong, nonatomic) NSString *detail1;

@property (strong, nonatomic) NSString *title2;
@property (strong, nonatomic) UIColor *bkColor2;
@property (strong, nonatomic) NSString *detail2;

@property (strong, nonatomic) NSString *title3;
@property (strong, nonatomic) UIColor *bkColor3;
@property (strong, nonatomic) NSString *detail3;

@property (assign, nonatomic) BOOL flipped;

- (void)flipTransitionWithOptions:(UIViewAnimationOptions)options halfway:(void (^)(BOOL finished))halfway completion:(void (^)(BOOL finished))completion;
- (void)setFlippedState:(BOOL)flipped;

-(void)updateCell;

@end
