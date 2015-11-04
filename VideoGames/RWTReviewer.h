//
//  RWTReviewer.h
//  VideoGames
//
//  Created by Brian Moakley on 6/8/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWTReviewer : NSObject

@property (assign, nonatomic) NSInteger reviewerId;
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * bio;
@property (strong, nonatomic) NSMutableArray * reviews;

@end
