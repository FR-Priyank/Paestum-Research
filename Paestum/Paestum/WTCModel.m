//
//  WTCModel.m
//  Paestum
//
//  Created by Priyank on 27/03/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import "WTCModel.h"
#import "WTCBucket.h"

@interface WTCModel() <NSURLConnectionDelegate>

@end

@implementation WTCModel

-(id)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self){
        NSDictionary *account = [dict objectForKey:@"account"];
        NSArray *eventBuckets = [dict objectForKey:@"metaDataPerCriticalEventBucket"];
        self.companyName = [account objectForKey:@"name"];
        self.imageURL = [account objectForKey:@"companyLogoUrl"];
        if(eventBuckets){
            self.eventBuckets = [[NSMutableArray alloc]init];
            for(NSDictionary *bucketdict in eventBuckets){
                [self.eventBuckets addObject:[[WTCBucket alloc]initWithDictionary:bucketdict]];
            }
        }
    }
    
    return self;
}

@end
