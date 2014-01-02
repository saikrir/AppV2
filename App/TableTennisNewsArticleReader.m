//
//  TableTennisNewsArticleReader.m
//  App
//
//  Created by Sai krishna K Rao on 12/29/13.
//  Copyright (c) 2013 Sai krishna K Rao. All rights reserved.
//

#import "TableTennisNewsArticleReader.h"
#import "NewsArticle.h"

NSString *const kNEW_ITEM = @"item";
NSString *const kIMAGE_REGEX = @"\"https?://.+/[A-Za-z_]+/.+\.(jpe?g|png)\"";

@interface TableTennisNewsArticleReader(){
    NSMutableString *elementText;
    NSString *currentElement;
    NSArray *fields;
    NewsArticle *currentArticle;
    NSDateFormatter *dateFormat;
}
    @property (nonatomic, strong) NSXMLParser *xmlParser;
    @property (nonatomic, strong) NSMutableArray *newsArticles;
@end


@implementation TableTennisNewsArticleReader


-(instancetype) initWithReaderURL:(NSString *) readerURL
{
    self = [super init];
    if(self){
        self.readerURL = readerURL;
        self.newsArticles = [[NSMutableArray alloc] init];
        fields = @[@"title",@"link",@"description",@"pubDate", @"content:encoded"];
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"EEE, dd MMM yyyy hh:mm:ss zz"];
        [dateFormat setLenient:YES];
    }
    return self;
}


// ToDo Need Caching Here ?

-(void) readNewsArticles{
    
    NSURL *rssURL = [NSURL URLWithString:self.readerURL];
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *newsArticlesSession = [NSURLSession sessionWithConfiguration:sessionConfig];
    
    NSURLSessionDataTask *dataTask = [newsArticlesSession dataTaskWithURL:rssURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        self.xmlParser = [[NSXMLParser alloc] initWithData:data];
        self.xmlParser.delegate =self;
        [self.xmlParser parse];
        [self.newsArticleDelegate didRecieveNewsArticle:self.newsArticles andError:error];
    }];
    
    [dataTask resume];
}

-(void) readNewsArticlesByPage:(NSNumber *) page{
    //Todo Impl
}


#pragma mark - NSXMLMarker Delegate Methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
                                    namespaceURI:(NSString *)namespaceURI
                                    qualifiedName:(NSString *)qName
                                    attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:kNEW_ITEM]){
        currentArticle = [[NewsArticle alloc] init];
    }
    
    if([fields containsObject:elementName]){
        currentElement = elementName;
        elementText = [[NSMutableString alloc] init];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
                                    namespaceURI:(NSString *)namespaceURI
                                    qualifiedName:(NSString *)qName
{
    
    if([elementName isEqualToString:kNEW_ITEM]){
        [self.newsArticles addObject:currentArticle];
    }
    
   
    if([fields containsObject:elementName]){
        
        if([@"title" isEqualToString:elementName]){
            currentArticle.title = elementText;
        }
        else if ([@"link" isEqualToString:elementName]){
            currentArticle.link = elementText;
        }
        else if ([@"description" isEqualToString:elementName]){
            currentArticle.description = elementText;
        }
        else if ([@"pubDate" isEqualToString:elementName]){
            currentArticle.pubDate = [dateFormat dateFromString:elementText];
        }
        else if ([@"content:encoded" isEqualToString:elementName]){
            currentArticle.contentHtml = elementText;
            currentArticle.imageURL = [self extractImageURL];
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [elementText appendString:string];
}


-(NSString *) extractImageURL
{
    NSError *error = nil;
    
    NSString *imageUrl = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern: kIMAGE_REGEX
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSRange imageURLRange = [regex rangeOfFirstMatchInString:elementText options:0 range:NSMakeRange(0, [elementText length])];
 
    if(imageURLRange.location != NSNotFound ){
        imageUrl = [elementText substringWithRange:imageURLRange];
        imageUrl = [imageUrl stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    }
    return imageUrl;
}

@end
