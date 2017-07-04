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
@property (assign, nonatomic) NSUInteger currentPlayerTurn;
@property (assign, nonatomic) BOOL isBlockingButtons;
@property (strong, nonatomic) NSMutableArray *userInputArray;

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

- (void) flashQuadrantWithIndex: (NSUInteger) quadrantIndex {
    UIColor *startingColor = [[self quadrantColors] objectAtIndex:quadrantIndex];
    UIColor *flashColor = [[self quadrantFlashColor] objectAtIndex:quadrantIndex];
    WKInterfaceButton *buttonToFlash = [[self gameButtons] objectAtIndex:quadrantIndex];
    [buttonToFlash setBackgroundColor: flashColor];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [buttonToFlash setBackgroundColor:startingColor];
    });
}

- (void) awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void) willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    self.currentGameSequence = [self generateNewGameSequence];

/*    Testing purposes */
//    [self flashQuadrantWithIndex:1];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self flashQuadrantWithIndex:3];
//    });
    
    [self startGame];
}

- (void) playSeriesFromIndex: (NSUInteger) index toIndex: (NSUInteger) finishIndex {
    if (index == finishIndex) {
        // start next player turn
        return;
    }
    NSNumber* currentQuadrant = [self.currentGameSequence objectAtIndex:index];
    NSLog(@"Quadrant :%@ index: %d finishIndex: %d", currentQuadrant, (int) index, (int) finishIndex);
    [self flashQuadrantWithIndex:[currentQuadrant unsignedIntegerValue]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self playSeriesFromIndex: index + 1 toIndex:finishIndex];
    });
}

- (void) playSeriesForTurn: (NSUInteger) turnIndex {
    [self playSeriesFromIndex:0 toIndex: turnIndex];
}

- (void) startGame {
    self.currentPlayerTurn = 1;
    self.isBlockingButtons = YES;
    [self.notificationLabel setText:@"Ready"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (1 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       [self.notificationLabel setText:@"Set"];
                       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                           [self.notificationLabel setText:@"Go!"];
                           [self playSeriesForTurn: self.currentPlayerTurn];
                       });
                   });
}

- (void) didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void) startNextTurn {
    self.currentPlayerTurn++;
    self.isBlockingButtons = YES;
    [self.notificationLabel setText: @"Nice Job! Next Turn..."];
    [self playSeriesForTurn:self.currentPlayerTurn];
}

- (void) playerPressedQuadrant: (NSNumber*) quadrant {
    if (self.isBlockingButtons) {
        return;
    }
    
    [self.userInputArray addObject:quadrant];
    for (NSUInteger ii = 0; ii < [self.userInputArray count]; ii++) {
        if (![self.userInputArray[ii] isEqual:self.currentGameSequence[ii]]) {
                //end game
            return;
        }
    }
    
    if ([self.userInputArray count] == self.currentPlayerTurn) {
        [self startNextTurn];
    }
    
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
