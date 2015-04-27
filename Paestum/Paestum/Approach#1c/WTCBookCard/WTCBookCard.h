//
//  WTCBookCard.h
//  Paestum
//
//  Created by Priyank on 31/03/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTCBookCardCell.h"
#import "MTCardLayout.h"
#import "UICollectionView+Draggable.h"


@protocol WTCBookCardDelegate <NSObject>

@optional
-(void)didTapActionImage:(UIView *)view;
@end
@interface WTCBookCard : UIView <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, WTCBookCardCellDelegate, UICollectionViewDataSource_Draggable>
@property (strong, nonatomic) NSMutableArray *cardmodels;
@property (weak, nonatomic) IBOutlet UICollectionView *wtccollectionview;
@property (nonatomic, assign)id <WTCBookCardDelegate> cardDelegate;

-(void)reloadView;

@end
