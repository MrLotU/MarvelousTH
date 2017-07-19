//
//  Character.h
//  Marvelous
//
//  Created by Jari Koopman on 19/07/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Character : NSObject

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *charDescription;
@property (nonatomic, strong) NSArray *URLS;
@property (nonatomic, strong) NSDictionary *comics;
@property (nonatomic, strong) NSDictionary *series;
@property (nonatomic, strong) NSDictionary *thumbnail;

+ (instancetype) CharacterWithDictionary:(NSDictionary *) dictionary;

@end
