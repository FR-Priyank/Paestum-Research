//
//  InterfaceOrientation.h
//  Paestum
//
//  Created by Priyank on 30/03/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, InterfaceOrientationType) {
    InterfaceOrientationTypePortrait,
    InterfaceOrientationTypeLandscape
};

@interface InterfaceOrientation : NSObject

+ (InterfaceOrientationType)orientation;

@end
