//
//  Card.h
//  korttipakka
//
//  Created by Reijo Vuohelainen on 17.1.2015.
//  Copyright (c) 2015 Reijo Vuohelainen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;






@end
