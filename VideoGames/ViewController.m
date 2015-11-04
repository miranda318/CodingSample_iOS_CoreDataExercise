//
//  ViewController.m
//  VideoGames
//
//  Created by Brian Moakley on 4/14/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

#import "ViewController.h"
#import "VideoGame.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *gameName;
@property (weak, nonatomic) IBOutlet UILabel *genre;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UITextView *synopsis;
@property (strong, nonatomic) NSArray *videoGames;
@property (assign, nonatomic) NSInteger index;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.index = 0;
}

-(void) viewWillAppear:(BOOL)animated
{
    [self updateUI];
}

- (IBAction)previousTap:(id)sender {
    if (self.index > 0)
    {
        self.index -= 1;
    }
    [self updateUI];
}

- (IBAction)nextTap:(id)sender
{
    if (self.index < self.videoGames.count-1)
    {
        self.index += 1;
    }
    [self updateUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) updateUI
{
    VideoGame *videoGame = self.selectedVideoGame;
    self.gameName.text = videoGame.name;
    self.genre.text = videoGame.gerne;
    self.rating.text = [NSString stringWithFormat:@"%tu", videoGame.rating];
    self.synopsis.text = videoGame.sysnopsis;
}


@end
