//
//  ReactView.m
//  Paestum
//
//  Created by Priyank on 24/04/15.
//  Copyright (c) 2015 firstrain. All rights reserved.
//

#import "ReactView.h"
#import "RCTRootView.h"

@implementation ReactView{
    RCTRootView *rctview;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)awakeFromNib {
    
    NSURL *jsCodeLocation;
    
    // Loading JavaScript code - uncomment the one you want.
    
    // OPTION 1
    // Load from development server. Start the server from the repository root:
    //
    // $ npm start
    //
    // To run on device, change `localhost` to the IP address of your computer, and make sure your computer and
    // iOS device are on the same Wi-Fi network.
    jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle"];
    
    // OPTION 2
    // Load from pre-bundled file on disk. To re-generate the static bundle, run
    //
    // $ curl 'http://localhost:8081/index.ios.bundle?dev=false&minify=true' -o iOS/main.jsbundle
    //
    // and uncomment the next following line
     //jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
    
    
    rctview = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName: @"SimpleApp"
                                                     launchOptions:nil];
    [self addSubview:rctview];
    rctview.frame = self.bounds;
}

-(void)refresh{
    //This function is a hack
    //It is required because when the parent view is loading again, the images in this view are not loading
    
    //todo The way we are reloading this view is also a hack - has bad performance
    [rctview removeFromSuperview];
    rctview = nil;
    [self awakeFromNib];
    //////////////////////////////////////////////////////////////////////////////
}

@end
