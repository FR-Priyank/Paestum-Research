//
//  WTCBucket.m
//  Paestum
//
//  Created by Priyank on 31/03/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import "WTCBucket.h"
#import "WTCCriticalEvent.h"

@implementation WTCBucket
-(id)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self){
        //self.oneDayDocCount = [[dict objectForKey:@"oneDayDocCount" ]integerValue];
        NSDictionary *bucket = [dict objectForKey:@"bucket"];
        self.bucketName = [bucket objectForKey:@"name"];
        NSArray *allSevenDaybuckets = [dict objectForKey:@"matchedCriticalEventInSevenDay"];
        self.sevenDayDocCount = [allSevenDaybuckets count];
        self.bucketId = [bucket objectForKey:@"id"];
        
        if(allSevenDaybuckets){
            self.criticalEvents = [[NSMutableArray alloc]init];
            for(NSDictionary *eventdict in allSevenDaybuckets){
                [self.criticalEvents addObject:[[WTCCriticalEvent alloc]initWithDictionary:eventdict]];
            }
        }
    }
    
    return self;
}
@end
