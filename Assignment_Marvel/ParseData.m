//
//  ParseData.m
//  Assignment_Marvel
//
//  Created by AvisBudget on 9/20/16.
//  Copyright © 2016 AvisBudget. All rights reserved.
//

#import "ParseData.h"

@implementation ParseData
- (id) initWithMarvel:(NSDictionary *)marvelDictionary
{
	if (self = [self init])
	{
		self.marvelName = [marvelDictionary objectForKey:@"name"];
		self.thumbnailImageURL = [NSString stringWithFormat:@"%@.%@",[[marvelDictionary objectForKey:@"thumbnail"] objectForKey:@"path"],[[marvelDictionary objectForKey:@"thumbnail"] objectForKey:@"extension"]];
		self.marvelDescription = [marvelDictionary objectForKey:@"description"];
		
		self.comicsArray = [[NSArray alloc] initWithArray:[[marvelDictionary objectForKey:@"comics"] objectForKey:@"items"]];
		self.eventsArray = [[NSArray alloc] initWithArray:[[marvelDictionary objectForKey:@"events"] objectForKey:@"items"]];
		self.seriesArray = [[NSArray alloc] initWithArray:[[marvelDictionary objectForKey:@"series"] objectForKey:@"items"]];
		self.storiesArray = [[NSArray alloc] initWithArray:[[marvelDictionary objectForKey:@"stories"] objectForKey:@"items"]];
		self.resourceURLString = [marvelDictionary objectForKey:@"resourceURI"];
		@try {
			
		}
		@catch (NSException *exception) {
			
		}
		@finally {
			
		}
		
	}
	return self;
}
@end
