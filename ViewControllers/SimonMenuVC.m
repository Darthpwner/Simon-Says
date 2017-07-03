//
//  SimonMenuVC.m
//  Simon-Says
//
//  Created by Matthew Allen Lin on 7/2/17.
//  Copyright © 2017 Matthew Allen Lin Software. All rights reserved.
//

#import "SimonMenuVC.h"

@interface SimonMenuVC()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *startGameButton;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *gameOverLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *scoreLabel;
@property (strong, nonatomic) NSArray *currentGameSequence;

@end

@implementation SimonMenuVC

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

- (IBAction)startGameAction {
    [self pushControllerWithName:@"SimonGameVC" context: self];
}

@end
