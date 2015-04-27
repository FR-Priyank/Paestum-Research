//
//  WTCExpandedCardCell.h
//  Paestum
//
//  Created by Priyank on 31/03/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WTCExpandedCardCellDelegate <NSObject>

@optional
-(void)didTapActionImage:(UIView *)cell;
@end

@interface WTCExpandedCardCell : UICollectionViewCell
@property (strong, nonatomic) NSString *compName;
@property (strong, nonatomic) NSString *compImageURL;
@property (assign, nonatomic) NSInteger cntFlame1;
@property (assign, nonatomic) NSInteger cntFlame2;
@property (assign, nonatomic) NSInteger cntFlame3;
@property (nonatomic, assign)id <WTCExpandedCardCellDelegate> cellDelegate;

@property (strong, nonatomic) NSString *title1;
@property (strong, nonatomic) UIColor *bkColor1;
@property (strong, nonatomic) NSString *detail1;

@property (strong, nonatomic) NSString *title2;
@property (strong, nonatomic) UIColor *bkColor2;
@property (strong, nonatomic) NSString *detail2;

@property (strong, nonatomic) NSString *title3;
@property (strong, nonatomic) UIColor *bkColor3;
@property (strong, nonatomic) NSString *detail3;


-(void)updateCell;

@end
