//
//  CollectionViewController.m
//  Marvelous
//
//  Created by Jari Koopman on 19/07/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

#import "CollectionViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "Character.h"
#import "CharacterCollectionViewCell.h"
#import "Char.h"
#import "DetailViewController.h"

@interface CollectionViewController ()
@property (strong, nonatomic) NSMutableArray <CharProtocol> *characters;

@end

@implementation CollectionViewController

NSString *privateKey = @"ed137124f8e578748232e3247e0289d5575636d2";
NSString *publicKey = @"2ef763cc635d971512d7b22ebebb629d";

static NSString * const reuseIdentifier = @"characterCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Do any additional setup after loading the view.
    [self loadMarvelData];
}

#pragma mark API

- (NSString *)hashFromStrings:(NSArray *)strings
{
    NSMutableString *stringToHash = [NSMutableString string];
    NSMutableString *hashedString = [NSMutableString string];
    
    [strings enumerateObjectsUsingBlock:^(NSString *string, NSUInteger index, BOOL *stop) {
        [stringToHash appendString:string];
    }];
    
    const char *pointer = stringToHash.UTF8String;
    unsigned char buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(pointer, (int)strlen(pointer), buffer);
    
    for (int index = 0; index < CC_MD5_DIGEST_LENGTH; index++) {
        [hashedString appendFormat:@"%02x", buffer[index]];
    }
    return hashedString;
}


- (void)loadMarvelData {
    
    self.characters = (NSMutableArray<CharProtocol>*)[NSMutableArray array];
    
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    NSString *ts = [NSString stringWithFormat:@"%f", timeStamp];
    NSString *hash = [self hashFromStrings:@[ts, privateKey, publicKey]];
    NSString *URLString = [NSString stringWithFormat:@"https://gateway.marvel.com:443/v1/public/characters?limit=100&apikey=%@&ts=%@&hash=%@",publicKey,ts,hash];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:URLString];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        NSDictionary *package = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        NSDictionary *dataDict = [package valueForKey:@"data"];
        NSArray *results = [dataDict valueForKey:@"results"];
        
        for(NSDictionary *result in results) {
            Character *character = [Character CharacterWithDictionary:result];
            [self.characters addObject:character];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            NSLog(@"All done!");
        });
        
    }];
    [task resume];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showDetail"]) {
        DetailViewController *detailVC = segue.destinationViewController;
        NSIndexPath *selectedIndexPath = [self.collectionView indexPathsForSelectedItems][0];
        detailVC.character = [self.characters objectAtIndex:selectedIndexPath.row];
    }
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.characters count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CharacterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if([self.characters count] > indexPath.row) {
        
        Character *character = [self.characters objectAtIndex:indexPath.row];
        cell.nameLabel.text = character.name;
        [cell.nameLabel setAdjustsFontSizeToFitWidth:true];
        cell.storiesLabel.text = [NSString stringWithFormat:@"Stories: %@", [character.stories objectForKey:@"returned"]];
        cell.seriesLabel.text = [NSString stringWithFormat:@"Series: %@", [character.series objectForKey:@"returned"]];
        cell.comicsLabel.text = [NSString stringWithFormat:@"Comics: %@", [character.comics objectForKey:@"returned"]];
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}


@end
