//
//  ViewController.m
//  korttipakka
//
//  Created by Reijo Vuohelainen on 17.1.2015.
//  Copyright (c) 2015 Reijo Vuohelainen. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "Muistikorttipeli.h"


@interface ViewController ()
@property (strong, nonatomic) Muistikorttipeli *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end

@implementation ViewController

- (Muistikorttipeli *)game
{
    if (!_game) _game = [[Muistikorttipeli alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}


- (IBAction)touchCardButton:(UIButton *)sender
{
    unsigned long int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
 }

- (void) updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        unsigned long int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score:  %ld", self.game.score];
    }
}
// Tähän kommentti
- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ?  card.contents : @"";
}
    
    
- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)reStartButton:(UIButton *)sender {
    _game = nil;
    [self game];
    [self updateUI];
}

@end
