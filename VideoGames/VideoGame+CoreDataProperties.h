//
//  VideoGame+CoreDataProperties.h
//  VideoGames
//
//  Created by Miranda Yang on 10/15/15.
//  Copyright © 2015 Razeware. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "VideoGame.h"
#import "Reviewer.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoGame (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *gerne;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *rating;
@property (nullable, nonatomic, retain) NSString *sysnopsis;
@property (nullable, nonatomic, retain) Reviewer *reviewer;

@end

NS_ASSUME_NONNULL_END
