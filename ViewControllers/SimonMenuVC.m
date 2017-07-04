//
//  SimonMenuVC.m
//  Simon-Says
//
//  Created by Matthew Allen Lin on 7/2/17.
//  Copyright © 2017 Matthew Allen Lin Software. All rights reserved.
//

#import "SimonMenuVC.h"
#import "SimonGameVC.h"

@interface SimonMenuVC()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *startGameButton;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *gameOverLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *scoreLabel;
@property (strong, nonatomic) NSNumber *score;
@end

@implementation SimonMenuVC

- (void) awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void) willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    if (self.score) {
        [self.scoreLabel setText:[NSString stringWithFormat:@"Score: %@", self.score]];
        [self.scoreLabel setHidden: NO];
    } else {
        [self.gameOverLabel setHidden: YES];
        [self.scoreLabel setHidden:YES];
    }
}

- (void) didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)startGameAction {
    [self pushControllerWithName:@"SimonGameVC" context: self];
}

#pragma mark - SimonGameDelegate
- (void) didEndGameWithScore:(NSUInteger) score {
    self.score = @(score);
    [self popController];
}

@end
