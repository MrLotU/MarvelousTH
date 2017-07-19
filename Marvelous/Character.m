//
//  Character.m
//  Marvelous
//
//  Created by Jari Koopman on 19/07/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

#import "Character.h"

@implementation Character

+ (instancetype) CharacterWithDictionary:(NSDictionary *) dictionary {
    Character *character = [[Character alloc] init];
    
    if (character) {
        character.id = [dictionary valueForKey:@"id"];
        character.name = [dictionary valueForKey:@"name"];
        character.charDescription = [dictionary valueForKey:@"description"];
        character.URLS = [dictionary valueForKey:@"urls"];
        character.comics = [dictionary valueForKey:@"comics"];
        character.series = [dictionary valueForKey:@"series"];
        character.thumbnail = [dictionary valueForKey:@"thumbnail"];
    }
    NSLog(@"%@", character);
    return character;
}

@end
