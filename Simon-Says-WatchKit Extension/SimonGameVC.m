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
@property (strong, nonatomic) NSArray *currentGameSequence;

@end

@implementation SimonGameVC

#define kGameTurnCount (1000)

-(NSArray*) generateNewGameSequence {
    NSMutableArray *newSequence = [NSMutableArray new];
    for(NSUInteger ii=0; ii < kGameTurnCount; ii++) {
        NSUInteger randNum = arc4random() % 4;
        [newSequence addObject:@(randNum)];
    }
    
    //Debugging
    NSLog(@"New Game Sequence: %@", newSequence);
    
    return newSequence;
}
- (NSArray*) gameButtons {
    return @[self.upperLeftButton, self.upperRightButton, self.lowerLeftButton, _lowerRightButton];
}

- (NSArray*) quadrantColors {
    return @[[UIColor redColor], [UIColor blueColor], [UIColor yellowColor], [UIColor greenColor]];
}

- (NSArray*) quadrantFlashColor {
    NSMutableArray *flashColors = [NSMutableArray new];
    for(NSUInteger ii = 0; ii < [[self quadrantColors] count]; ii++) {
        UIColor *flashColor = [[self quadrantColors][ii] colorWithAlphaComponent: .1];
        [flashColors addObject:flashColor];
    }
    
    return flashColors;
}

- (void) awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void) willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    self.currentGameSequence = [self generateNewGameSequence];
}

- (void) didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)upperLeftAction {
}

- (IBAction)upperRightAction {
}

- (IBAction)lowerLeftAction {
}

- (IBAction)lowerRightAction {
}


@end
