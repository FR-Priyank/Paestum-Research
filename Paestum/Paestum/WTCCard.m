//
//  WTCCard.m
//  Paestum
//
//  Created by Priyank on 30/03/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import "WTCCard.h"
#import "WTCCardCell.h"
#import "WTCModel.h"
#import "WTCBucket.h"
#import "InterfaceOrientation.h"

@interface WTCCard()


@end

@implementation WTCCard{
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
    
    self.wtccollectionview.layer.cornerRadius = 7.0f;
    self.wtccollectionview.delegate = self;
    self.wtccollectionview.dataSource = self;
    
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.wtccollectionview.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
    
    [self.wtccollectionview registerClass:[WTCCardCell class] forCellWithReuseIdentifier:@"wtccell"];
}


-(UIView *)loadViewFromNib{
    NSBundle *bundle = [NSBundle mainBundle];
    NSArray *viewarray = [bundle loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    UIView *customview = [viewarray objectAtIndex:0];
    
    return customview;
}

-(void)reloadView{
    if (self.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiomPad){
            [(UICollectionViewFlowLayout *)self.wtccollectionview.collectionViewLayout setItemSize:CGSizeMake(((CGRectGetWidth(self.bounds)-20)/4)-10, ((CGRectGetHeight(self.bounds)-20)/2)-10)];
    }else{
        if ([InterfaceOrientation orientation] == InterfaceOrientationTypePortrait){
            //portrait on iphone
            [(UICollectionViewFlowLayout *)self.wtccollectionview.collectionViewLayout setItemSize:CGSizeMake(CGRectGetWidth(self.bounds) - 20, ((CGRectGetHeight(self.bounds)-20)/3)-5)];
        }else{
            //landscape on iphone
            [(UICollectionViewFlowLayout *)self.wtccollectionview.collectionViewLayout setItemSize:CGSizeMake(((CGRectGetWidth(self.bounds) - 20)/2)-10, ((CGRectGetHeight(self.bounds)-20)/2)-05)];
        }
    }
    
    [self.wtccollectionview reloadData];
}


#pragma mark - UICollectionView methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.cardmodels count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WTCCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"wtccell" forIndexPath:indexPath];
    
    if(nil == cell){
        cell = [[WTCCardCell alloc] init];
    }
    
    cell.compImageURL = ((WTCModel *)[self.cardmodels objectAtIndex:indexPath.row]).imageURL;
    cell.compName = [NSString stringWithFormat:@"%d. %@", (int)(indexPath.row + 1), ((WTCModel *)[self.cardmodels objectAtIndex:indexPath.row]).companyName];
    
    for(WTCBucket *bucket in ((WTCModel *)[self.cardmodels objectAtIndex:indexPath.row]).eventBuckets){
        if([bucket.bucketId  isEqual: @"1"])
            cell.cntFlame1 = bucket.sevenDayDocCount;
        
        if([bucket.bucketId  isEqual: @"2"])
            cell.cntFlame2 = bucket.sevenDayDocCount;
        
        if([bucket.bucketId  isEqual: @"3"])
            cell.cntFlame3 = bucket.sevenDayDocCount;
    }
    
    [cell updateCell];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerview" forIndexPath:indexPath];
        
        reusableview = headerView;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerview" forIndexPath:indexPath];
        
        reusableview = footerview;
    }
    
    return reusableview;
}

@end
