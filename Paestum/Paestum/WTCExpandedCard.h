//
//  WTCExpandedCard.h
//  Paestum
//
//  Created by Priyank on 31/03/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTCExpandedCardCell.h"

@protocol WTCExpandedCardDelegate <NSObject>

@optional
-(void)didTapActionImage:(UIView *)view;
@end
@interface WTCExpandedCard : UIView <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, WTCExpandedCardCellDelegate>
@property (strong, nonatomic) NSMutableArray *cardmodels;
@property (weak, nonatomic) IBOutlet UICollectionView *wtccollectionview;
@property (nonatomic, assign)id <WTCExpandedCardDelegate> cardDelegate;

-(void)reloadView;

@end
