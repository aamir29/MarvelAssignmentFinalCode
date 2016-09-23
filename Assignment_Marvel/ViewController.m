//
//  ViewController.m
//  Assignment_Marvel
//
//  Created by AvisBudget on 9/20/16.
//  Copyright © 2016 AvisBudget. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+AFNetworking.h"
#import "DetailViewController.h"
#import "AFHTTPSessionManager.h"

@interface ViewController ()

@end

// Public key da1dad4d3eb6bcf803e0a9af78e6176c
// Private key 2218a5470154fd7ddc78898c54513ae421d139f4
//http://gateway.marvel.com/v1/public/characters?ts=1&apikey=da1dad4d3eb6bcf803e0a9af78e6176c&hash=8768e3b957f91dc377a30f8e1b32d158
@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.marvelEntityArray = [[NSMutableArray alloc] init];
    self.filteredMarvelEntityArray = [[NSMutableArray alloc] init];
	[self getData];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(void)getData
{
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	[manager GET:@"http://gateway.marvel.com/v1/public/characters?ts=1&apikey=da1dad4d3eb6bcf803e0a9af78e6176c&hash=8768e3b957f91dc377a30f8e1b32d158" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
		NSLog(@"JSON: %@", responseObject);
		[self parseResponseData:responseObject];
	} failure:^(NSURLSessionTask *operation, NSError *error) {
		NSLog(@"Error: %@", error);
	}];
}

-(void)parseResponseData:(NSDictionary *)responseDictionary
{
	NSArray *marvelArray = [[responseDictionary objectForKey:@"data"] objectForKey:@"results"];
	for(NSDictionary* marvel in marvelArray)
	{
		ParseData *currentMarvelEntity = [[ParseData alloc] initWithMarvel:marvel];
		NSLog(@"currentMarvelEntity %@", currentMarvelEntity.marvelName);
		[self.marvelEntityArray addObject:currentMarvelEntity];
	}
	[self.marvelTableView reloadData];
}

#pragma mark - Table View Delegate and Datasource Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
    if (self.searchBarView.hidden == YES) {
        return self.marvelEntityArray.count;
    }
    else{
        return self.filteredMarvelEntityArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchBarView.hidden == YES) {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        ParseData *marvelData = [self.marvelEntityArray objectAtIndex:indexPath.row];
        
        UILabel *marvelNameLabel = (UILabel *)[cell viewWithTag:101];
        marvelNameLabel.text = marvelData.marvelName;
        
        UIImageView *marvelImageView = (UIImageView *)[cell viewWithTag:100];
        [marvelImageView setImageWithURL:[NSURL URLWithString:marvelData.thumbnailImageURL]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

        return cell;
    }
    else{
        static NSString *CellIdentifier = @"FilterCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        ParseData *marvelData = [self.filteredMarvelEntityArray objectAtIndex:indexPath.row];
        
        UILabel *marvelNameLabel = (UILabel *)[cell viewWithTag:201];
        marvelNameLabel.text = marvelData.marvelName;
        
        UIImageView *marvelImageView = (UIImageView *)[cell viewWithTag:200];
        [marvelImageView setImageWithURL:[NSURL URLWithString:marvelData.thumbnailImageURL]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (self.searchBarView.hidden == YES) {
		self.detailMarvelData = [self.marvelEntityArray objectAtIndex:indexPath.row];
		[self performSegueWithIdentifier:@"DetailSegue" sender:self];
	}
	else
	{
		self.detailMarvelData = [self.filteredMarvelEntityArray objectAtIndex:indexPath.row];
		[self performSegueWithIdentifier:@"DetailSegue" sender:self];
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchBarView.hidden == YES) {
        return 157;
    }
    else
    {
        return 101;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	DetailViewController *vcToPushTo = segue.destinationViewController;
	vcToPushTo.parseDataDetail = self.detailMarvelData;
}

#pragma mark - Search Bar Delegate Method

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF.marvelName beginswith[c] %@",searchText];
	self.filteredMarvelEntityArray = [[self.marvelEntityArray filteredArrayUsingPredicate:bPredicate] mutableCopy];
	[self.marvelTableView reloadData];
}

#pragma mark - Button Action

- (IBAction)searchButtonAction:(id)sender {
	self.searchBarView.hidden = NO;
	[self.marvelTableView reloadData];
}

- (IBAction)cancelButtonAction:(id)sender {
	self.searchBarView.hidden = YES;
	[self.marvelTableView reloadData];
    [self.searchBar resignFirstResponder];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

@end