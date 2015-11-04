//
//  ReviewerViewController.m
//  VideoGames
//
//  Created by Brian Moakley on 6/8/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

#import "ReviewerViewController.h"
#import "DataStore.h"
#import "VideoGame.h"
#import "Reviewer.h"

@interface ReviewerViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *reviewerName;
@property (weak, nonatomic) IBOutlet UITextView *bio;
@property (weak, nonatomic) IBOutlet UITableView *reviewedGame;

@end

@implementation ReviewerViewController

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.reviwer.reviewedGames.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    VideoGame * videoGame = (VideoGame *) [self.reviwer.reviewedGames allObjects][indexPath.row];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.reviewerName.text = self.reviwer.name;
    self.bio.text = self.reviwer.bio;
    self.bio.font = [UIFont fontWithName:@"Helvetica Neue" size:18.0f];
    self.bio.textColor = [UIColor greenColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
