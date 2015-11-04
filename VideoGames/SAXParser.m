//
//  RWTXMLParser.m
//  VideoGames
//
//  Created by Brian Moakley on 4/14/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

#import "SAXParser.h"
#import "RWTVideoGame.h"
#import "RWTReviewer.h"

@interface SAXParser()<NSXMLParserDelegate>

@property (strong, nonatomic) NSXMLParser *xmlParser;
@property (strong, nonatomic) NSMutableArray *videoGames;
@property (strong, nonatomic) NSMutableArray * reviewers;
@property (strong, nonatomic) NSMutableString *xmlText;
@property (strong, nonatomic) RWTVideoGame *currentVideoGame;
@property (strong, nonatomic) RWTReviewer * currentReviewer;

@end

@implementation SAXParser

-(NSDictionary *) parseFeed
{
    self.videoGames = [@[] mutableCopy];
    self.reviewers = [@[] mutableCopy];
    if (self.xml)
    {
        self.xmlParser = [[NSXMLParser alloc] initWithData:[self.xml dataUsingEncoding:NSUTF8StringEncoding]];
        self.xmlParser.delegate = self;
        [self.xmlParser parse];
    }
    return @{@"games" : self.videoGames, @"reviewers" : self.reviewers };
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    self.xmlText = [[NSMutableString alloc] init];
    if ([elementName isEqualToString:@"video_game"])
    {
        self.currentVideoGame = [[RWTVideoGame alloc] init];
    }
    if ([elementName isEqualToString:@"reviewer"])
    {
        self.currentReviewer = [[RWTReviewer alloc] init];
    }
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"name"])
    {
        if (self.currentVideoGame)
        {
            self.currentVideoGame.name = [self.xmlText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }
        else if (self.currentReviewer)
        {
            self.currentReviewer.name = [self.xmlText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }
    }
    if ([elementName isEqualToString:@"id"])
    {
        self.currentReviewer.reviewerId = [self.xmlText integerValue];
    }
    if ([elementName isEqualToString:@"genre"])
    {
        self.currentVideoGame.genre = [self.xmlText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if ([elementName isEqualToString:@"rating"])
    {
        self.currentVideoGame.rating = [self.xmlText intValue];
    }
    if ([elementName isEqualToString:@"reviewId"])
    {
        NSInteger reviewId = [self.xmlText integerValue];
        for (RWTReviewer * reviewer in self.reviewers)
        {
            if (reviewer.reviewerId == reviewId)
            {
                [reviewer.reviews addObject:self.currentVideoGame];
                break;
            }
        }
            
    }
    if ([elementName isEqualToString:@"synopsis"])
    {
        self.currentVideoGame.synopsis = [self.xmlText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if ([elementName isEqualToString:@"video_game"])
    {
        [self.videoGames addObject:self.currentVideoGame];
        self.currentVideoGame = nil;
    }
    if ([elementName isEqualToString:@"reviewer"])
    {
        [self.reviewers addObject:self.currentReviewer];
        self.currentReviewer = nil;
    }
}

-(void) parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
    NSString * bio = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
    self.currentReviewer.bio = bio;
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [self.xmlText appendString:string];
}

@end
