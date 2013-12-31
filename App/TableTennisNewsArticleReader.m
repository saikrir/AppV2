//
//  TableTennisNewsArticleReader.m
//  App
//
//  Created by Sai krishna K Rao on 12/29/13.
//  Copyright (c) 2013 Sai krishna K Rao. All rights reserved.
//

#import "TableTennisNewsArticleReader.h"
#import "NewsArticle.h"

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


-(void) loadNewsArticles{
    NSURL *rssURL = [NSURL URLWithString:self.readerURL];
    self.xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:rssURL];
    self.xmlParser.delegate =self;
    [self.xmlParser parse];
}

-(NSArray *) readNewsArticles{
    
    if([self.newsArticles count] == 0)
    {
        [self loadNewsArticles];
    }
    
    return self.newsArticles;
}

-(NSArray *) readNewsArticlesByPage:(NSNumber *) page{
    return nil;
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
