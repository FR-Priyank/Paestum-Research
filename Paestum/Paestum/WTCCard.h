//
//  WTCCard.h
//  Paestum
//
//  Created by Priyank on 30/03/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTCCard : UIView <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) NSMutableArray *cardmodels;
@property (weak, nonatomic) IBOutlet UICollectionView *wtccollectionview;
-(void)reloadView;
@end
