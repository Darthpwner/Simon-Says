//
//  SimonGameVC.h
//  Simon-Says
//
//  Created by Matthew Allen Lin on 7/3/17.
//  Copyright © 2017 Matthew Allen Lin Software. All rights reserved.
//

#import <WatchKit/WatchKit.h>

@protocol SimonGameDelegate <NSObject>
- (void) didEndGameWithScore: (NSUInteger) score;
@end

@interface SimonGameVC : WKInterfaceController

@end
