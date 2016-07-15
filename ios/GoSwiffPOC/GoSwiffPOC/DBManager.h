//
//  DBManager.h
//  GoSwiffPOC
//
//  Created by Girmiti Dev on 14/07/16.
//  Copyright (c) 2016 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject
{
    NSString *databasePath;
}

+(DBManager*)getSharedInstance;
-(BOOL)importDB;
-(NSArray*) getAllCountries;

@end