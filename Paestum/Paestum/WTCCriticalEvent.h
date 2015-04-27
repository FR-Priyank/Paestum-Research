//
//  WTCCriticalEvent.h
//  Paestum
//
//  Created by Priyank on 01/04/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTCCriticalEvent : NSObject
@property (nonatomic, strong) NSString *name;

-(id)initWithDictionary:(NSDictionary *)dict;

@end
