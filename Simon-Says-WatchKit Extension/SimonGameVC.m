//
//  SimonGameVC.m
//  Simon-Says
//
//  Created by Matthew Allen Lin on 7/3/17.
//  Copyright © 2017 Matthew Allen Lin Software. All rights reserved.
//

#import "SimonGameVC.h"

@interface SimonGameVC()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *upperLeftButton;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *upperRightButton;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *lowerLeftButton;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *lowerRightButton;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *notificationLabel;

@end

@implementation SimonGameVC

- (void) awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void) willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void) didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end
