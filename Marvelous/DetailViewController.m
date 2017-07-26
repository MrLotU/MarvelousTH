
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)swipeHappenedWithRecognizer: (UISwipeGestureRecognizer *)recognizer {
    NSLog(@"Function called!");
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
