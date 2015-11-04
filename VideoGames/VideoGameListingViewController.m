//
//  VideoGameListingViewController.m
//  VideoGames
//
//  Created by Brian Moakley on 6/6/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

#import "VideoGameListingViewController.h"
#import "SAXParser.h"
#import "VideoGame.h"
#import "ViewController.h"
#import "DataStore.h"

@interface VideoGameListingViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray * games;

@end

@implementation VideoGameListingViewController


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.games.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    VideoGame * videoGame = self.games[indexPath.row];
    cell.textLabel.text = videoGame.name;
    
    return cell;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self performSegueWithIdentifier:@"VideoGame" sender:self.games[indexPath.row]];
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"VideoGame"])
    {
        ViewController * vc = (ViewController *) segue.destinationViewController;
        vc.selectedVideoGame = (VideoGame *) sender;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    DataStore * dataStore = [DataStore sharedInstance];
    self.games = dataStore.games;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
