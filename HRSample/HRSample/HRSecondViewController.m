//
//  HRSecondViewController.m
//  HRSample
//
//  Created by onegray on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HRSecondViewController.h"
#import "HRMySpaceConnection.h"
#import "MySpacePeopleSearchRequest.h"

@interface HRSecondViewController ()

@property (nonatomic, retain) NSArray* results;

@end

@implementation HRSecondViewController
@synthesize tableView;
@synthesize results;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"MySpace";
    }
    return self;
}

-(void) dealloc 
{
    [[HRMySpaceConnection sharedConnection] cancelRequestsForDelegate:self];
    [tableView release];
    [results release];
    [super dealloc];
}



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar 
{
    [[HRMySpaceConnection sharedConnection] cancelRequestsForDelegate:self];
    [[HRMySpaceConnection sharedConnection] performRequest:[MySpacePeopleSearchRequest hrWithSearchTerms:searchBar.text delegate:(id)self]];
    
    [searchBar resignFirstResponder];    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [searchBar resignFirstResponder];
}

-(void) hrMySpacePeopleSearch:(MySpacePeopleSearchRequest*)request didFinishWithResponse:(MySpacePeopleSearchResponse*)response
{
    if(response.succeed)
    {
        self.results = response.searchResults;
        [tableView reloadData];
    }
    else
    {
        [[[[UIAlertView alloc] initWithTitle:@"Error" message:[response.error localizedDescription] 
                                    delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease] show];
    }
}


#pragma mark -
#pragma mark UITableViewDataSource methods

-(int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [results count];
}

-(UITableViewCell*) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString* cellId = @"cellId";
    UITableViewCell* cell = [tv dequeueReusableCellWithIdentifier:cellId];
    if(!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId] autorelease];
    }
    cell.textLabel.text = [results objectAtIndex:indexPath.row];
    return cell;
}



@end









