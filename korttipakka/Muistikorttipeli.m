//
//  Muistikorttipeli.m
//  korttipakka
//
//  Created by Reijo Vuohelainen on 23.1.2015.
//  Copyright (c) 2015 Reijo Vuohelainen. All rights reserved.
//

#import "Muistikorttipeli.h"

@interface Muistikorttipeli()
@property (nonatomic, readwrite)NSInteger score;
@property (nonatomic, strong)NSMutableArray *cards;  // of Card
@end

@implementation Muistikorttipeli

// Lazy instatntiation!

- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}


-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];   // super's designated initializer
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
            [self.cards addObject:card];  // setter use point notation
            } else {
        self = nil;
        break;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    //return self.cards[index];
    return (index < [self.cards count]) ? self.cards[index] : nil; //so that argument is not out of bounds
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
     if (!card.isMatched)  {            // See the exlamation mark!
         if (card.isChosen) {
             card.chosen = NO;          // Just that we can compare cards
         } else {
             // match the card against other chosen cards
             for (Card *otherCard in self.cards) {
                 if (otherCard.isChosen && !otherCard.isMatched) {
                     int matchScore = [card match:@[otherCard]];
                     if (matchScore) {
                         self.score += matchScore * MATCH_BONUS;
                         otherCard.matched = YES;
                         card.matched =YES;
                     } else {
                         self.score -= MISMATCH_PENALTY;
                         otherCard.chosen = NO;             // releases the other card back
                     }
                     break;  // can only choose two cards now!
                 }
             }
             self.score -= COST_TO_CHOOSE;
            card.chosen = YES;          // And back the status to chosen
         }
    }
}

@end
