//
//  WTCCardCell.h
//  Paestum
//
//  Created by Priyank on 27/03/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTCCardCell : UICollectionViewCell

@property (strong, nonatomic) NSString *compName;
@property (strong, nonatomic) NSString *compImageURL;
@property (assign, nonatomic) NSInteger cntFlame1;
@property (assign, nonatomic) NSInteger cntFlame2;
@property (assign, nonatomic) NSInteger cntFlame3;


-(void)updateCell;
@end
