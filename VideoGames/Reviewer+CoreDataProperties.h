//
//  Reviewer+CoreDataProperties.h
//  VideoGames
//
//  Created by Miranda Yang on 10/15/15.
//  Copyright © 2015 Razeware. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Reviewer.h"

NS_ASSUME_NONNULL_BEGIN

@interface Reviewer (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *bio;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<VideoGame *> *reviewedGames;

@end

@interface Reviewer (CoreDataGeneratedAccessors)

- (void)addReviewedGamesObject:(VideoGame *)value;
- (void)removeReviewedGamesObject:(VideoGame *)value;
- (void)addReviewedGames:(NSSet<VideoGame *> *)values;
- (void)removeReviewedGames:(NSSet<VideoGame *> *)values;

@end

NS_ASSUME_NONNULL_END
