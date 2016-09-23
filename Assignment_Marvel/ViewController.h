//
//  ViewController.h
//  Assignment_Marvel
//
//  Created by AvisBudget on 9/20/16.
//  Copyright © 2016 AvisBudget. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseData.h"

@interface ViewController : UIViewController
@property(nonatomic,strong) NSMutableArray *marvelEntityArray;
@property(nonatomic,strong) NSMutableArray *filteredMarvelEntityArray;
@property (weak, nonatomic) IBOutlet UITableView *marvelTableView;
@property (weak, nonatomic) IBOutlet UIView *searchBarView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet ParseData *detailMarvelData;

- (IBAction)searchButtonAction:(id)sender;
- (IBAction)cancelButtonAction:(id)sender;

@end

