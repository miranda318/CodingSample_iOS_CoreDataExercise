//
//  DataStore.h
//  VideoGames
//
//  Created by Miranda Yang on 10/15/15.
//  Copyright © 2015 Razeware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataStore : NSObject

@property (strong, nonatomic) NSMutableArray * games;
@property (strong, nonatomic) NSMutableArray * reviewers;


+(instancetype) sharedInstance;
-(void) loadLibrary;
-(void) importLibrary;

@end
