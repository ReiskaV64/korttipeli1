//
//  Muistikorttipeli.h
//  korttipakka
//
//  Created by Reijo Vuohelainen on 23.1.2015.
//  Copyright (c) 2015 Reijo Vuohelainen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface Muistikorttipeli : NSObject

// designated initializer , tämä aloittaa initialisoinnit in Class can be only one designated initializer, but several other initializers
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly)NSInteger score;

@end
