//
//  DetailViewController.m
//  Assignment_Marvel
//
//  Created by AvisBudget on 9/21/16.
//  Copyright © 2016 AvisBudget. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "AFHTTPSessionManager.h"

@implementation DetailViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 0) {
		return 428;
	}
	else
	{
		return 150;
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
	return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 0)
	{
		static NSString *CellIdentifier = @"FirstCell";
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		
		if (cell == nil) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		}
		UIImageView *marvelImageView = (UIImageView *)[cell viewWithTag:100];
		[marvelImageView setImageWithURL:[NSURL URLWithString:self.parseDataDetail.thumbnailImageURL]];
		
		UILabel *marvelNameLabel = (UILabel *)[cell viewWithTag:101];
		marvelNameLabel.text = self.parseDataDetail.marvelName;
		
		UILabel *marvelDescriptionLabel = (UILabel *)[cell viewWithTag:102];
		marvelDescriptionLabel.text = self.parseDataDetail.marvelDescription;
		
		UIButton *backButton = (UIButton *)[cell viewWithTag:103];
		[backButton addTarget:self
					 action:@selector(backButtonAction)
		   forControlEvents:UIControlEventTouchUpInside];
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
		return cell;
	}
	else
	{
		static NSString *CellIdentifier = @"SecondCell";
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		
		if (cell == nil) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		}
        NSArray *dataArray = [self getArray:(int)indexPath.row];
		UILabel *typeLabel = (UILabel *)[cell viewWithTag:200];
		typeLabel.text = [self getTitle:(int)indexPath.row];
		
		UIScrollView *scrollView = (UIScrollView *)[cell viewWithTag:201];
		scrollView.contentSize = CGSizeMake([dataArray count]*90, scrollView.frame.size.height);
		
		for (int i = 0; i < [dataArray count]; i++)
		{
			UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5+(i*90), 90, 85, 50)];
			nameLabel.numberOfLines = 3;
			nameLabel.textAlignment = NSTextAlignmentCenter;
			nameLabel.textColor = [UIColor whiteColor];
			nameLabel.font = [UIFont fontWithName:@"Arial" size:10];
			nameLabel.text = [[dataArray objectAtIndex:i] objectForKey:@"name"];
			[scrollView addSubview:nameLabel];
			
			NSString *resourceURLString = [NSString stringWithFormat:@"%@?ts=1&apikey=da1dad4d3eb6bcf803e0a9af78e6176c&hash=8768e3b957f91dc377a30f8e1b32d158",[[dataArray objectAtIndex:i] objectForKey:@"resourceURI"]];
			
			AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
			[manager GET:resourceURLString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                if ([[[[responseObject objectForKey:@"data"] objectForKey:@"results"] objectAtIndex:0] objectForKey:@"thumbnail"] != [NSNull null])
                {
                    NSString *imageURLString = [NSString stringWithFormat:@"%@.%@",[[[[[responseObject objectForKey:@"data"] objectForKey:@"results"] objectAtIndex:0] objectForKey:@"thumbnail"] objectForKey:@"path"],[[[[[responseObject objectForKey:@"data"] objectForKey:@"results"] objectAtIndex:0] objectForKey:@"thumbnail"] objectForKey:@"extension"]];
                    
                    UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(10+(i*90),10,70,85)];
                    [imageView setImageWithURL:[NSURL URLWithString:imageURLString]];
                    [scrollView addSubview:imageView];
                }
			} failure:^(NSURLSessionTask *operation, NSError *error) {
				NSLog(@"Error: %@", error);
			}];
		}
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
		return cell;
	}
}

-(NSString *)getTitle:(int)index
{
    switch (index) {
        case 1:
            return @"COMICS";
            break;
            
        case 2:
            return @"EVENTS";
            break;
            
        case 3:
            return @"SERIES";
            break;
            
        case 4:
            return @"STORIES";
            break;
         
        default:
            return @"";
            break;
        
    }
}

-(NSArray *)getArray:(int)index
{
    switch (index) {
        case 1:
            return self.parseDataDetail.comicsArray;
            break;
            
        case 2:
            return self.parseDataDetail.eventsArray;
            break;
            
        case 3:
            return self.parseDataDetail.seriesArray;
            break;
            
        case 4:
            return self.parseDataDetail.storiesArray;
            break;
            
        default:
            return nil;
            break;
            
    }
}

-(void)backButtonAction
{
	[self.navigationController popViewControllerAnimated:YES];
}

@end
