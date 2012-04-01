//
//  HRFirstViewController.m
//  HRSample
//
//  Created by onegray on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HRFirstViewController.h"

#import "HRTwitterConnection.h"
#import "TwitterSearchRequest.h"


@interface HRFirstViewController ()
@property (nonatomic, retain) NSArray* results;
@end

@implementation HRFirstViewController
@synthesize tableView;
@synthesize results;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Twitter";
    }
    return self;
}

-(void) dealloc 
{
    [[HRTwitterConnection sharedConnection] cancelRequestsForDelegate:self];
    [tableView release];
    [results release];
    [super dealloc];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar 
{
    [[HRTwitterConnection sharedConnection] cancelRequestsForDelegate:self];
    [[HRTwitterConnection sharedConnection] performRequest:[TwitterSearchRequest hrWithQuery:searchBar.text delegate:(id)self]];
    
    [searchBar resignFirstResponder];    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [searchBar resignFirstResponder];
}

-(void) hrTwitterSearch:(TwitterSearchRequest*)request didFinishWithResponse:(TwitterSearchResponse*)response;
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




















