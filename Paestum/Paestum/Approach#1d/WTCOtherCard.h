//
//  WTCOtherCard.h
//  Paestum
//
//  Created by Priyank on 31/03/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTCOtherCardCell.h"

@protocol WTCOtherCardDelegate <NSObject>

@optional
-(void)didTapActionImage:(UIView *)view;
@end
@interface WTCOtherCard : UIView <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, WTCOtherCardCellDelegate>
@property (strong, nonatomic) NSMutableArray *cardmodels;
@property (weak, nonatomic) IBOutlet UICollectionView *wtccollectionview;
@property (nonatomic, assign)id <WTCOtherCardDelegate> cardDelegate;

-(void)reloadView;

@end
