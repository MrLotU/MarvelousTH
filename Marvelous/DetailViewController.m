
//
//  DetailViewController.m
//  Marvelous
//
//  Created by Jari Koopman on 20/07/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHappenedWithRecognizer:)];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeRecognizer];
    //MARK: Setup view
    self.nameLabel.text = self.character.name;
    if([self.character.comics[@"items"] count] > 0) {
        NSMutableString *comics = [NSMutableString stringWithString:@"Comics:"];
        for(NSDictionary *comic in self.character.comics[@"items"]) {
            comics = [NSMutableString stringWithFormat:@"%@ \n -- \n%@", comics, comic[@"name"]];
        }
        self.comicsLabel.text = [NSString stringWithFormat:@"%@", comics];
    } else {
        self.comicsLabel.text = @"No comics found for this character!";
    }
    if([self.character.series[@"items"] count] > 0) {
        NSMutableString *series = [NSMutableString stringWithString:@"Series:"];
        for(NSDictionary *serie in self.character.series[@"items"]) {
            series = [NSMutableString stringWithFormat:@"%@ \n -- \n%@", series, serie[@"name"]];
        }
        self.seriesLabel.text = [NSString stringWithFormat:@"%@", series];
    } else {
        self.seriesLabel.text = @"No series found for this character";
    }
    if([self.character.stories[@"items"] count] > 0) {
        NSMutableString *stories = [NSMutableString stringWithString:@"Stories:"];
        for(NSDictionary *story in self.character.series[@"items"]) {
            stories = [NSMutableString stringWithFormat:@"%@ \n -- \n%@", stories, story[@"name"]];
        }
        self.storiesLabel.text = [NSString stringWithFormat:@"%@", stories];
    } else {
        self.storiesLabel.text = @"No stories found for this character";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)swipeHappenedWithRecognizer: (UISwipeGestureRecognizer *)recognizer {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
