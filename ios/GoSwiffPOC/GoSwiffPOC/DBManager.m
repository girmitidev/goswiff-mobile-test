//
//  DBManager.m
//  GoSwiffPOC
//
//  Created by Girmiti Dev on 14/07/16.
//  Copyright (c) 2016 Appcoda. All rights reserved.
//

#import "DBManager.h"
#import  "Country.h"

static DBManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation DBManager

+(DBManager*)getSharedInstance{
    
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance importDB];
    }
    
    return sharedInstance;
}

-(BOOL)importDB{

    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    databasePath =  [[NSBundle mainBundle] pathForResource:@"GoSwiff" ofType:@"db"];
    
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            return  isSuccess;
        }
        else
        {
            isSuccess = NO;
            NSLog(@"Failed to open/create database");
        }
    }
    return isSuccess;
}

-(NSArray*) getAllCountries {
    
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"select * from countries"];
        const char *query_stmt = [querySQL UTF8String];
        int rc = sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) ;
        NSLog(@"Database Error Message : %s", sqlite3_errmsg(database));
        if (rc == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                Country *country = [Country new];
            
                country._code3L = [[NSString alloc]initWithUTF8String: (const char *) sqlite3_column_text(statement, 1)];
                country._code2L = [[NSString alloc]initWithUTF8String: (const char *) sqlite3_column_text(statement, 2)];
                country._name = [[NSString alloc]initWithUTF8String: (const char *) sqlite3_column_text(statement, 3)];
                country._nameOfficial = [[NSString alloc]initWithUTF8String: (const char *) sqlite3_column_text(statement, 4)];
                country._flag32 = [[NSString alloc]initWithUTF8String: (const char *) sqlite3_column_text(statement, 5)];
                country._flag128 = [[NSString alloc]initWithUTF8String: (const char *) sqlite3_column_text(statement, 6)];
                country._latitude = [[NSString alloc]initWithUTF8String: (const char *) sqlite3_column_text(statement, 7)];
                country._logitude = [[NSString alloc]initWithUTF8String: (const char *) sqlite3_column_text(statement, 8)];
                
                [resultArray addObject:country];
            }
            sqlite3_reset(statement);
        }
    }
    
    return resultArray;
}

@end