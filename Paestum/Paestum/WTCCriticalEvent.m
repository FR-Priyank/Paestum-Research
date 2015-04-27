//
//  WTCCriticalEvent.m
//  Paestum
//
//  Created by Priyank on 01/04/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import "WTCCriticalEvent.h"

@implementation WTCCriticalEvent
-(id)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self){
        self.name = [dict objectForKey:@"name"];
    }
    
    return self;
}

@end
