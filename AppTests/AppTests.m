//
//  AppTests.m
//  AppTests
//
//  Created by Sai krishna K Rao on 12/29/13.
//  Copyright (c) 2013 Sai krishna K Rao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TableTennisNewsArticleReader.h"

NSString *const url= @"http://tabletennista.com/rss?page=1";

@interface AppTests : XCTestCase
@property TableTennisNewsArticleReader *reader;
@end

@implementation AppTests

- (void)setUp
{
    [super setUp];
    self.reader = [[TableTennisNewsArticleReader alloc] initWithReaderURL:url];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSString *dateString = @"2013-12-21T08:00:00-05:00";
    NSRange range = [dateString rangeOfString:@"T"];
    
    NSRange newRange = {0, range.location};
    
    NSString *newStr = [dateString substringWithRange:newRange];
    
    NSLog(@" %@", newStr);
    
    //NSString *dateString = @"2013-12-21T";
    [formatter  setDateFormat:@"yyyy-MM-dd"];
    [formatter setLenient:YES];
    
    NSLog(@"%@",[formatter dateFromString:newStr]);
}

@end
