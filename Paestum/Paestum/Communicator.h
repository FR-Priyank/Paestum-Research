//
//  Communicator.h
//  Paestum
//
//  Created by Priyank on 27/03/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol CommunicatorProtocol <NSObject>
-(void)getResponse:(NSData *)responseData;
-(void)getResponseError:(NSError *)error;
@end

@interface Communicator : NSObject
-(void)getWTCData;
@property (nonatomic, strong) id <CommunicatorProtocol> commdelegate;

@end

