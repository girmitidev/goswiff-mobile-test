//
//  CountryViewController.m
//  GoSwiff POC
//
//  Created by Girmiti Dev on 14/7/16.
//  Copyright (c) 2016 Girmiti Software. All rights reserved.
//

#import "CountryViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Country.h"
#import "DBManager.h"
#import "CountryDetailsViewController.h"
#import "CustomTableViewCell.h"

@interface CountryViewController ()

@end

@implementation CountryViewController {
    NSArray *countries;
    NSArray *searchResults;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"Country List";
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:backButton];

    countries =  [[DBManager getSharedInstance] getAllCountries];
    
    // Remove table cell separator
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    // Assign our own backgroud for the view
    self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg"]];
    self.tableView.backgroundColor = [UIColor clearColor];

    // Add padding to the top of the table view
    UIEdgeInsets inset = UIEdgeInsetsMake(5, 0, 0, 0);
    self.tableView.contentInset = inset;
    
    static NSString *CellIdentifier = @"Cell";
    [self.searchDisplayController.searchResultsTableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:CellIdentifier];
    [self.tableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:CellIdentifier];

    searchResults = [NSMutableArray arrayWithCapacity:[countries count]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
    } else {
        return [countries count];
    }

}

- (UIImage *)cellBackgroundForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowCount = [self tableView:[self tableView] numberOfRowsInSection:0];
    NSInteger rowIndex = indexPath.row;
    UIImage *background = nil;
    
    if (rowIndex == 0) {
        background = [UIImage imageNamed:@"cell_top.png"];
    } else if (rowIndex == rowCount - 1) {
        background = [UIImage imageNamed:@"cell_bottom.png"];
    } else {
        background = [UIImage imageNamed:@"cell_middle.png"];
    }
    
    return background;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Country *country = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        country = [searchResults objectAtIndex:indexPath.row];
    } else {
        country = [countries objectAtIndex:indexPath.row];
    }
    
    static NSString *cellIdentifier = @"CustomTableViewCell";
    
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell._label.text = [country _name];
    [cell._imageView sd_setImageWithURL:[NSURL URLWithString:country._flag32] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    
    // Assign our own background image for the cell
    UIImage *background = [self cellBackgroundForRowAtIndexPath:indexPath];
    
    UIImageView *cellBackgroundView = [[UIImageView alloc] initWithImage:background];
    cellBackgroundView.image = background;
    cell.backgroundView = cellBackgroundView;
    
    return cell;
}

#pragma search functions

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    searchResults = [countries filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
  
    if (self.searchDisplayController.active) {
        indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
    } else {
        indexPath = [self._tableView indexPathForSelectedRow];
    }
    
    // Get destination view
    CountryDetailsViewController *vc =  [self.storyboard instantiateViewControllerWithIdentifier:@"CountryDetailsViewController"];
    
    // Pass the selected country details
    vc._selectedCountry = [countries objectAtIndex:[indexPath item]];
    
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:vc animated:YES];
}

//// This will get called too before the view appears
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([[segue identifier] isEqualToString:@"MySegue"]) {
//        
//        // note that "sender" will be the tableView cell that was selected
//        //UITableViewCell *cell = (UITableViewCell*)sender;
//        NSIndexPath *indexPath  = nil;//= [self._tableView indexPathForCell:cell];
//        
//        if (self.searchDisplayController.active) {
//            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
//        } else {
//            indexPath = [self._tableView indexPathForSelectedRow];
//        }
//        
//        // Get destination view
//        CountryDetailsViewController *vc = [segue destinationViewController];
//        
//        // Pass the selected country details
//        vc._selectedCountry = [countries objectAtIndex:[indexPath item]];
//    }
//}

@end
