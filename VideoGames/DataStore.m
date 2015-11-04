//
//  DataStore.m
//  VideoGames
//
//  Created by Miranda Yang on 10/15/15.
//  Copyright © 2015 Razeware. All rights reserved.
//

@import CoreData;
#import "DataStore.h"
#import "SAXParser.h"
#import "RWTReviewer.h"
#import "RWTVideoGame.h"
#import "Reviewer.h"
#import "VideoGame.h"

@interface DataStore()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;

@end

@implementation DataStore

-(instancetype) init
{
    self = [super init];
    if (self)
    {
        _games = [[NSMutableArray alloc] init];
        _reviewers = [[NSMutableArray alloc] init];
    }
    return self;
}

+(instancetype) sharedInstance
{
    static DataStore * sharedstore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedstore = [[self alloc] init];
    });
    return sharedstore;
}

// load data directly from Core Data itself instead of the XMLfile
-(void) loadLibrary
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Reviewer" inManagedObjectContext:self.managedObjectContext];
    
    // execute fetch reviewer request
    self.reviewers = [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    fetchRequest.entity = [NSEntityDescription entityForName:@"VideoGame" inManagedObjectContext:self.managedObjectContext];
    
    // execute fetch video game request
    self.games = [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
}

// import the library from xml and save data as Core Data objects
-(void) importLibrary {
    SAXParser *parse = [[SAXParser alloc]init];
    NSString *xmlPath = [[NSBundle mainBundle]pathForResource:@"video_games" ofType:@"xml"];
    NSURL *xmlURL = [NSURL fileURLWithPath:xmlPath];
    parse.xml = [NSString stringWithContentsOfURL:xmlURL encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *parseResults = [parse parseFeed];
    NSArray *reviewerList = parseResults[@"reviewers"];
    
    for (RWTReviewer *reviewer in reviewerList) {
        // create coresponding core data objects for each reviewer
        Reviewer *newReviewer = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Reviewer class]) inManagedObjectContext:self.managedObjectContext];
        newReviewer.name = reviewer.name;
        newReviewer.bio = reviewer.bio;
        
        for (RWTVideoGame *videoGame in reviewer.reviews) {
            VideoGame *newGame = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([VideoGame class]) inManagedObjectContext:self.managedObjectContext];
            newGame.name = videoGame.name;
            newGame.rating = @(videoGame.rating);
            newGame.gerne = videoGame.genre;
            newGame.sysnopsis = videoGame.synopsis;
            
            [newReviewer addReviewedGamesObject:newGame];
            [self.games addObject:newGame];
        }
        [self.reviewers addObject:newReviewer];
    }
    // check if there is saving errors.
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Saving errors: %@", error);
    }
}

// manageObjectModel getter method
-(NSManagedObjectModel*)managedObjectModel {
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"VideoGameModel" withExtension:@"momd"]; //momd: compile version of the model
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// get access to the store by creating persistenStoreCoordinator
-(NSPersistentStoreCoordinator*)persistentStoreCoordinator {
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }

    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSURL * documentDirectory = [fileManager URLForDirectory:NSDocumentDirectory
                                                    inDomain:NSUserDomainMask
                                           appropriateForURL:nil
                                                      create:NO
                                                       error:nil];
    NSURL * storeFile = [documentDirectory URLByAppendingPathComponent:@"videogames.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeFile options:nil error:&error]) {
        NSLog(@"error: %@", error);
    }
    return _persistentStoreCoordinator;
}

// managedObjectContext
- (NSManagedObjectContext*)managedObjectContext {
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    if (self.persistentStoreCoordinator) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        _managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    }
    return _managedObjectContext;

}

@end
