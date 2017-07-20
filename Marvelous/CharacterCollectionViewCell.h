//
//  CharacterCollectionViewCell.h
//  Marvelous
//
//  Created by Jari Koopman on 20/07/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CharacterCollectionViewCell : UICollectionViewCell
    @property (weak, nonatomic) IBOutlet UILabel *nameLabel;
    @property (weak, nonatomic) IBOutlet UILabel *comicsLabel;
    @property (weak, nonatomic) IBOutlet UILabel *seriesLabel;
    @property (weak, nonatomic) IBOutlet UILabel *storiesLabel;

@end
