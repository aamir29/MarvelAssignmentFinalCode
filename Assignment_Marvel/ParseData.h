//
//  ParseData.h
//  Assignment_Marvel
//
//  Created by AvisBudget on 9/20/16.
//  Copyright © 2016 AvisBudget. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParseData : NSObject

@property (nonatomic, strong) NSString *marvelName;
@property (nonatomic, strong) NSString *thumbnailImageURL;
@property (nonatomic, strong) NSString *marvelDescription;
@property (nonatomic, strong) NSArray *comicsArray;
@property (nonatomic, strong) NSArray *eventsArray;
@property (nonatomic, strong) NSArray *seriesArray;
@property (nonatomic, strong) NSArray *storiesArray;
@property (nonatomic, strong) NSArray *resourceURLString;

- (id) initWithMarvel:(NSDictionary *)marvelDictionary;
@end
