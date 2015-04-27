//
//  WTCOtherCard.m
//  Paestum
//
//  Created by Priyank on 31/03/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import "WTCOtherCard.h"
#import "WTCModel.h"
#import "WTCBucket.h"
#import "WTCCriticalEvent.h"
#import "InterfaceOrientation.h"

@interface WTCOtherCard()


@end

@implementation WTCOtherCard{
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
    
    [self.wtccollectionview registerClass:[WTCOtherCardCell class] forCellWithReuseIdentifier:@"wtcOthercell"];
}


-(UIView *)loadViewFromNib{
    NSBundle *bundle = [NSBundle mainBundle];
    NSArray *viewarray = [bundle loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    UIView *customview = [viewarray objectAtIndex:0];
    
    return customview;
}

-(void)reloadView{
    NSInteger numberOfCellsHorizontal = 1;
    NSInteger numberOfCellsVertical = 1;
    
    CGFloat cellmarginsy = 20.0f;
    CGFloat cellmarginsx = 10.0f;
    CGFloat collectionViewMargin = 5.0f;
    
    if (self.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiomPad){
        //iPad
        [(UICollectionViewFlowLayout *)self.wtccollectionview.collectionViewLayout setItemSize:CGSizeMake(((CGRectGetWidth(self.bounds)-cellmarginsx)/numberOfCellsHorizontal)-cellmarginsx, ((CGRectGetHeight(self.bounds)-cellmarginsy)/numberOfCellsVertical)-collectionViewMargin)];
    
    }else{ //iPhone
        
        //Check for orientation
        if ([InterfaceOrientation orientation] == InterfaceOrientationTypePortrait){ //iPhone Portrait
            
            //change number of cells to 3 for iphone portrait
            numberOfCellsVertical = 3;
            numberOfCellsHorizontal = 1;
            
            [(UICollectionViewFlowLayout *)self.wtccollectionview.collectionViewLayout setItemSize:CGSizeMake(CGRectGetWidth(self.bounds) - (cellmarginsx + 10), ((CGRectGetHeight(self.bounds)-cellmarginsy)/numberOfCellsVertical)-collectionViewMargin)];
            
            //change the scroll direction to vertical for iphone portrait
            [(UICollectionViewFlowLayout *)self.wtccollectionview.collectionViewLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
            
        }else{ //landscape on iphone
            //change number of cells to 2 for iphone landscape
            numberOfCellsHorizontal = 2;
            numberOfCellsVertical = 1;
            
            [(UICollectionViewFlowLayout *)self.wtccollectionview.collectionViewLayout setItemSize:CGSizeMake(((CGRectGetWidth(self.bounds) - (cellmarginsy))/numberOfCellsHorizontal) - 10, ((CGRectGetHeight(self.bounds)-cellmarginsy)/numberOfCellsVertical)-collectionViewMargin)];
            
            //change the scroll direction to horizontal for iphone landscape
            [(UICollectionViewFlowLayout *)self.wtccollectionview.collectionViewLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        }
    }
    
    //Reload collection view
    [self.wtccollectionview reloadData];
}

-(void)didTapActionImage:(UIView *)targetview{
    if (self.cardDelegate && [self.cardDelegate conformsToProtocol:@protocol(WTCOtherCardDelegate)]) {
        if ([self.cardDelegate respondsToSelector:@selector(didTapActionImage:)]) {
            [self.cardDelegate didTapActionImage:targetview];
        }
    }
}


#pragma mark - UICollectionView methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    //return 1;
    if ([self.cardmodels count] == 0){
        return 3;
    }else{
        return [self.cardmodels count];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([self.cardmodels count] == 0){
        return 3;
    }else{
        //return [self.cardmodels count];
        return 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WTCOtherCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"wtcOthercell" forIndexPath:indexPath];
    
    if(nil == cell){
        cell = [[WTCOtherCardCell alloc] init];
    }
    
    if ([self.cardmodels count] == 0){
        cell.compImageURL = nil;
        cell.compName = @"Loading Company...";
        
        cell.title1 = @"Deal Breakers & Accelerators";
        cell.title2 = @"Reasons to Check-In";
        cell.title3 = @"Good to Know";
        cell.bkColor1 = [UIColor colorWithRed:220.0/255.0 green:113.0/255.0 blue:124.0/255.0 alpha:1.0];
        cell.bkColor2 = [UIColor colorWithRed:93.0/255.0 green:220.0/255.0 blue:127.0/255.0 alpha:1.0];
        cell.bkColor3 = [UIColor colorWithRed:107.0/255.0 green:163.0/255.0 blue:237.0/255.0 alpha:1.0];
        
        cell.detail1 = @"Loading Data...";
        cell.detail2 = @"Loading Data...";
        cell.detail3 = @"Loading Data...";
    }else{
        WTCModel *model = [self.cardmodels objectAtIndex:indexPath.section];
        cell.compImageURL = model.imageURL;
        cell.compName = [NSString stringWithFormat:@"%d. %@", (int)(indexPath.section + 1), model.companyName];
        
        cell.title1 = @"Deal Breakers & Accelerators";
        cell.title2 = @"Reasons to Check-In";
        cell.title3 = @"Good to Know";
        cell.bkColor1 = [UIColor colorWithRed:220.0/255.0 green:113.0/255.0 blue:124.0/255.0 alpha:1.0];
        cell.bkColor2 = [UIColor colorWithRed:93.0/255.0 green:220.0/255.0 blue:127.0/255.0 alpha:1.0];
        cell.bkColor3 = [UIColor colorWithRed:107.0/255.0 green:163.0/255.0 blue:237.0/255.0 alpha:1.0];
        
        cell.detail1 = @"";
        cell.detail2 = @"";
        cell.detail3 = @"";

        
        
        for(WTCBucket *bucket in model.eventBuckets){
            NSMutableString *detail = [[NSMutableString alloc]init];
            
            for(WTCCriticalEvent *critevent in bucket.criticalEvents){
                [detail appendString:[NSString stringWithFormat:@"- %@",critevent.name]];
                [detail appendString:@"\n"];
            }
            
            if([bucket.bucketId  isEqual: @"1"]){
                cell.cntFlame1 = bucket.sevenDayDocCount;
                
                //cell.title1 = bucket.bucketName;
                cell.detail1 = detail;
            }else if([bucket.bucketId  isEqual: @"2"]){
                cell.cntFlame2 = bucket.sevenDayDocCount;
                
                //cell.title2 = bucket.bucketName;
                cell.detail2 = detail;
            }else if([bucket.bucketId  isEqual: @"3"]){
                cell.cntFlame3 = bucket.sevenDayDocCount;
                
                //cell.title3 = bucket.bucketName;
                cell.detail3 = detail;
            }
        }
    }
    cell.cellDelegate = self;
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