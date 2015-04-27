//
//  Communicator.m
//  Paestum
//
//  Created by Priyank on 27/03/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import "Communicator.h"
#import "WTCModel.h"

@implementation Communicator{
    NSMutableData *responseData;
}

-(void)getWTCData{
    NSString *post = @"{\"count\":8,\"frEntityId\":\"-1\",\"lastMinutes\":43200,\"componentId\":1000,\"frUserId\":3177532,\"channelId\":1,\"cardId\":1}";
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:@"https://devapps.firstrain.com/paestumstatic/static/paestum/getDataForCard.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:200.0];
    [request setHTTPBody:postData];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
}


#pragma mark NSURLConnection Delegate Methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //Now you can do what you want with the response string from the data
   
    if (self.commdelegate && [self.commdelegate conformsToProtocol:@protocol(CommunicatorProtocol)]) {
        if ([self.commdelegate respondsToSelector:@selector(getResponse:)]) {
            [self.commdelegate getResponse:responseData];
        }
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    //Do something if there is an error in the connection
    if (self.commdelegate && [self.commdelegate conformsToProtocol:@protocol(CommunicatorProtocol)]) {
        if ([self.commdelegate respondsToSelector:@selector(getResponseError:)]) {
            [self.commdelegate getResponseError:error];
        }
    }
}

@end
