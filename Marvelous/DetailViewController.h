//
//  DetailViewController.h
//  Marvelous
//
//  Created by Jari Koopman on 20/07/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Character.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Character *character;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *comicsLabel;
@property (weak, nonatomic) IBOutlet UITextView *seriesLabel;
@property (weak, nonatomic) IBOutlet UITextView *storiesLabel;

@end
