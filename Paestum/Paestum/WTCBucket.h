//
//  WTCBucket.h
//  Paestum
//
//  Created by Priyank on 31/03/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTCBucket : NSObject
@property (nonatomic, assign) NSInteger sevenDayDocCount;
@property (nonatomic, strong) NSString *bucketName;
@property (nonatomic, strong) NSString *bucketId;
@property (nonatomic, strong) NSMutableArray *criticalEvents;

-(id)initWithDictionary:(NSDictionary *)dict;

@end
