//
//  ViewController.m
//  korttipakka
//
//  Created by Reijo Vuohelainen on 17.1.2015.
//  Copyright (c) 2015 Reijo Vuohelainen. All rights reserved.
//

#import "ViewController.h"
//#import "Deck.h"                                  // we need also PlayingCardDeck which already contains import Deck
#import "PlayingCardDeck.h"
#import "Muistikorttipeli.h"


@interface ViewController ()
// These simple version components can be deleted
//@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
//@property (strong, nonatomic) Deck *deck;
//@property (nonatomic) int flipCount;
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

/*  DELETE THIS TOO
- (Deck * )deck                 // This is the setter, and runs when userinterface is opened.
 {
     if(!_deck) _deck = [self createDeck];
             return _deck;
 }
 */

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

/* DELETE THIS TOO
- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flipCount rised to new value %d", self.flipCount);
}
 */


- (IBAction)touchCardButton:(UIButton *)sender
{
   /* All this can now be deleted because the Model is handling it
    
    if([sender.currentTitle length]) {
        // UIImage *cardImage = [UIImage imageNamed:@"cardback"];   //nämä kaksi riviä opastetaan yhdistämään cardImagen paikalle [] edeltävältä riviltä
        [sender setBackgroundImage: [UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
                [sender setTitle:@"" forState:UIControlStateNormal];
        
    } else {
       // UIImage *cardImage = [UIImage imageNamed:@"cardfront"];
        Card *randomCard = [self.deck drawRandomCard];  // Always a random card from the whole deck
        if (randomCard) {                               // check that deck is not empty
         [sender setBackgroundImage: [UIImage imageNamed:@"cardfront"] forState:UIControlStateNormal];
        //[sender setTitle:@"A♣️" forState:UIControlStateNormal];  //muutos
        [sender setTitle:randomCard.contents forState:UIControlStateNormal];
        }
    }
*/
    unsigned long int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    
  //  self.flipCount++;
    
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

    
- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}
    
    
- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
