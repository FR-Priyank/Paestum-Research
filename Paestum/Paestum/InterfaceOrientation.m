//
//  InterfaceOrientation.m
//  Paestum
//
//  Created by Priyank on 30/03/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import "InterfaceOrientation.h"

@implementation InterfaceOrientation

+ (InterfaceOrientationType)orientation{
    
    
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize nativeSize = [UIScreen mainScreen].currentMode.size;
    CGSize sizeInPoints = [UIScreen mainScreen].bounds.size;
    
    InterfaceOrientationType result;
    
    if(scale * sizeInPoints.width == nativeSize.width){
        result = InterfaceOrientationTypePortrait;
    }else{
        result = InterfaceOrientationTypeLandscape;
    }
    
    return result;
}

@end
