//
//  Deck.h
//  korttipakka
//
//  Created by Reijo Vuohelainen on 17.1.2015.
//  Copyright (c) 2015 Reijo Vuohelainen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard: (Card *)card atTop: (BOOL)atTop;
- (void)addCard: (Card *)card;

- (Card *)drawRandomCard;


@end
