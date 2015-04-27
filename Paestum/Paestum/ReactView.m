//
//  ReactView.m
//  Paestum
//
//  Created by Priyank on 24/04/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import "ReactView.h"
#import "RCTRootView.h"

@implementation ReactView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)awakeFromNib {
    NSString *urlString = @"http://localhost:8081/index.ios.bundle";
    NSURL *jsCodeLocation = [NSURL URLWithString:urlString];
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName: @"SimpleApp"
                                                     launchOptions:nil];
    [self addSubview:rootView];
    rootView.frame = self.bounds;
}
@end
