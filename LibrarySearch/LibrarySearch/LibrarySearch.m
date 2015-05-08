//
//  LibrarySearch.m
//  LibrarySearch
//
//  Created by Saikrishna Rao on 12/11/14.
//  Copyright (c) 2014 Saikrishna Rao. All rights reserved.
//

#import "LibrarySearch.h"

@interface LibrarySearch ()

@property (nonatomic,strong) NSURLSession *urlSession;
@property (nonatomic,strong) NSURLSessionConfiguration *sessionConfiguration;

@end

@implementation LibrarySearch

NSString *const apiSearchURL = @"http://skrao-rpi:9292/search/";
NSString *const apiTopicListingURL = @"http://skrao-rpi:9292/entry";

+(instancetype) instance{
    
    static LibrarySearch *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    
    return sharedMyManager;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.urlSession = [NSURLSession sessionWithConfiguration:self.sessionConfiguration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    }
    return self;
}

-(void) searchFor:(NSString *) searchStr completionHandler:(void (^)(NSArray *searchResults, NSError *error)) completionHandler{
    NSString *searchUrlStr = [apiSearchURL stringByAppendingString:searchStr];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:searchUrlStr]];
    
    NSURLSessionDataTask *dataTask =
        [self.urlSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
         {
            if(!error){
                NSError *jsonParsingError = nil;
                NSArray *searchResults = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
                completionHandler(searchResults,jsonParsingError);
            }
            else{
                completionHandler(nil, error);
            }
        }];
    
    [dataTask resume];
}


-(void) listingFor:(NSString *) topic completionHandler:(void (^)(NSArray *listingResults, NSError *error)) completionHandler{
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:apiTopicListingURL]];
    
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest setHTTPMethod:@"POST"];
    NSString *params = [NSString stringWithFormat:@"topic=%@",topic];
    urlRequest.HTTPBody = [params dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSessionDataTask *postListing = [self.urlSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSArray *searchResults = nil;
        if(!error){
            NSError *jsonParsingError = nil;
            searchResults = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
        }
        completionHandler(searchResults,error);
    }];
    
    [postListing resume];
}

@end
