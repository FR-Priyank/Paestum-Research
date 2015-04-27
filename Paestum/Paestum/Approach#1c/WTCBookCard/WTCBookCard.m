//
//  WTCBookCard.m
//  Paestum
//
//  Created by Priyank on 31/03/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import "WTCBookCard.h"
#import "WTCModel.h"
#import "WTCBucket.h"
#import "WTCCriticalEvent.h"
#import "InterfaceOrientation.h"
#import "MTCardLayout.h"
#import "UICollectionView+CardLayout.h"
#import "LSCollectionViewLayoutHelper.h"
#import "UICollectionView+Draggable.h"

@interface WTCBookCard()


@end

@implementation WTCBookCard{
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
    
    //UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.wtccollectionview.collectionViewLayout;
    //collectionViewLayout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
    
    [self.wtccollectionview registerClass:[WTCBookCardCell class] forCellWithReuseIdentifier:@"wtcbookcell"];
}


-(UIView *)loadViewFromNib{
    NSBundle *bundle = [NSBundle mainBundle];
    NSArray *viewarray = [bundle loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    UIView *customview = [viewarray objectAtIndex:0];
    
    return customview;
}

-(void)reloadView{
//    NSInteger numberOfCellsHorizontal = 1;
//    NSInteger numberOfCellsVertical = 1;
//    
//    CGFloat cellmarginsy = 20.0f;
//    CGFloat cellmarginsx = 10.0f;
//    CGFloat collectionViewMargin = 5.0f;
//    
//    if (self.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiomPad){
//        //iPad
//        [(UICollectionViewFlowLayout *)self.wtccollectionview.collectionViewLayout setItemSize:CGSizeMake(((CGRectGetWidth(self.bounds)-cellmarginsx)/numberOfCellsHorizontal)-cellmarginsx, ((CGRectGetHeight(self.bounds)-cellmarginsy)/numberOfCellsVertical)-collectionViewMargin)];
//    
//    }else{ //iPhone
//        
//        //Check for orientation
//        if ([InterfaceOrientation orientation] == InterfaceOrientationTypePortrait){ //iPhone Portrait
//            
//            //change number of cells to 3 for iphone portrait
//            numberOfCellsVertical = 3;
//            numberOfCellsHorizontal = 1;
//            
//            [(UICollectionViewFlowLayout *)self.wtccollectionview.collectionViewLayout setItemSize:CGSizeMake(CGRectGetWidth(self.bounds) - (cellmarginsx + 10), ((CGRectGetHeight(self.bounds)-cellmarginsy)/numberOfCellsVertical)-collectionViewMargin)];
//            
//            //change the scroll direction to vertical for iphone portrait
//            [(UICollectionViewFlowLayout *)self.wtccollectionview.collectionViewLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//        
//            
//        }else{ //landscape on iphone
//            //change number of cells to 2 for iphone landscape
//            numberOfCellsHorizontal = 2;
//            numberOfCellsVertical = 1;
//            
//            [(UICollectionViewFlowLayout *)self.wtccollectionview.collectionViewLayout setItemSize:CGSizeMake(((CGRectGetWidth(self.bounds) - (cellmarginsy))/numberOfCellsHorizontal) - 10, ((CGRectGetHeight(self.bounds)-cellmarginsy)/numberOfCellsVertical)-collectionViewMargin)];
//            
//            //change the scroll direction to horizontal for iphone landscape
//            [(UICollectionViewFlowLayout *)self.wtccollectionview.collectionViewLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//        }
//    }
    
    //Reload collection view
    [self.wtccollectionview reloadData];
}

-(void)didTapActionImage:(UIView *)targetview{
    if (self.cardDelegate && [self.cardDelegate conformsToProtocol:@protocol(WTCBookCardDelegate)]) {
        if ([self.cardDelegate respondsToSelector:@selector(didTapActionImage:)]) {
            [self.cardDelegate didTapActionImage:targetview];
        }
    }
}


#pragma mark - UICollectionView methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.wtccollectionview setPresenting:YES animated:YES completion:nil];
}

- (UIImage *)collectionView:(UICollectionView *)collectionView imageForDraggingItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    CGSize size = cell.bounds.size;
    size.height = 72.0;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [cell.layer renderInContext:context];
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (CGAffineTransform)collectionView:(UICollectionView *)collectionView transformForDraggingItemAtIndexPath:(NSIndexPath *)indexPath duration:(NSTimeInterval *)duration
{
    return CGAffineTransformMakeScale(1.05f, 1.05f);
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath{
//    NSString * item = self.items[fromIndexPath.item];
//    [self.items removeObjectAtIndex:fromIndexPath.item];
//    [self.items insertObject:item atIndex:toIndexPath.item];
}

- (void)collectionView:(UICollectionView *)collectionView didMoveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)toIndexPath{
}

- (BOOL)collectionView:(UICollectionView *)collectionView canDeleteItemAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView deleteItemAtIndexPath:(NSIndexPath *)indexPath{
    //[self.items removeObjectAtIndex:indexPath.item];
}

- (void)collectionView:(UICollectionView *)collectionView didDeleteItemAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark Backside

-(void)didTapMoreDone:(id)sender{
//    WTCBookCardCell *cell = (WTCBookCardCell *)[self.wtccollectionview cellForItemAtIndexPath:[[self.wtccollectionview indexPathsForSelectedItems] firstObject]];
//    if (sender == cell.infoButton)
//    {
//        [cell flipTransitionWithOptions:UIViewAnimationOptionTransitionFlipFromLeft halfway:^(BOOL finished) {
//            cell.infoButton.hidden = YES;
//            cell.doneButton.hidden = NO;
//        } completion:nil];
//    }
//    else
//    {
//        [cell flipTransitionWithOptions:UIViewAnimationOptionTransitionFlipFromRight halfway:^(BOOL finished) {
//            cell.infoButton.hidden = NO;
//            cell.doneButton.hidden = YES;
//        } completion:nil];
//    }
    
    WTCBookCardCell *cell = (WTCBookCardCell *)sender;
    if (cell.flipped){
        [cell flipTransitionWithOptions:UIViewAnimationOptionTransitionFlipFromLeft halfway:^(BOOL finished) {
            [cell setFlippedState:NO];
        } completion:nil];
    }
    else{
        [cell flipTransitionWithOptions:UIViewAnimationOptionTransitionFlipFromRight halfway:^(BOOL finished) {
            [cell setFlippedState:YES];
        } completion:nil];
    }
}

///////////////////////////////////////////////////////////////



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.cardmodels count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WTCBookCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"wtcbookcell" forIndexPath:indexPath];
    
    if(nil == cell){
        cell = [[WTCBookCardCell alloc] init];
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
        WTCModel *model = [self.cardmodels objectAtIndex:indexPath.row];
        cell.compImageURL = model.imageURL;
        cell.compName = [NSString stringWithFormat:@"%d. %@", (int)(indexPath.row + 1), model.companyName];
        
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



@end