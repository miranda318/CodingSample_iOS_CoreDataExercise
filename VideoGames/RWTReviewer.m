//
//  RWTReviewer.m
//  VideoGames
//
//  Created by Brian Moakley on 6/8/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

#import "RWTReviewer.h"

@implementation RWTReviewer

-(instancetype) init
{
    self = [super init];
    if (self)
    {
        _reviews = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
