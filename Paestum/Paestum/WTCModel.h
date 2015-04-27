//
//  WTCModel.h
//  Paestum
//
//  Created by Priyank on 27/03/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTCModel : NSObject
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSMutableArray *eventBuckets;

-(id)initWithDictionary:(NSDictionary *)dict;
@end
