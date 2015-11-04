//
//  ReviewerListingViewController.m
//  VideoGames
//
//  Created by Brian Moakley on 6/8/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

#import "ReviewerListingViewController.h"
#import "DataStore.h"
#import "RWTReviewer.h"

@interface ReviewerListingViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) UITableView * tableView;
@property (strong, nonatomic) NSArray * reviwers;

@end

@implementation ReviewerListingViewController

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.reviwers.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    RWTReviewer * reviewer = self.reviwers[indexPath.row];
    cell.textLabel.text = reviewer.name;
    
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
    DataStore * dataStore = [DataStore sharedInstance];
    self.reviwers = dataStore.reviewers;
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
