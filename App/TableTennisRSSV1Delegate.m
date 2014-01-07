//
//  TableTennisRSSV1Delegate.m
//  App
//
//  Created by Sai krishna K Rao on 1/2/14.
//  Copyright (c) 2014 Sai krishna K Rao. All rights reserved.
//

#import "TableTennisRSSV1Delegate.h"




@implementation TableTennisRSSV1Delegate

- (id)init
{
    self = [super init];
    if (self) {
        self.newsArticles = [[NSMutableArray alloc] init];
        fields = @[@"title",@"link",@"description",@"pubDate", @"content:encoded"];
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"EEE, dd MMM yyyy hh:mm:ss zz"];
        [dateFormat setLenient:YES];self.newsArticles = [[NSMutableArray alloc] init];
        fields = @[@"title",@"link",@"description",@"a10:updated", @"enclosure"];
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"EEE, dd MMM yyyy hh:mm:ss zz"];
        [dateFormat setLenient:YES];
        imageRegex = @"\"https?://.+/[A-Za-z_]+/.+\.(jpe?g|png)\"";
    }
    return self;
}



#pragma mark - NSXMLMarker Delegate Methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:NewItem]){
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
    
    if([elementName isEqualToString:NewItem]){
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
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern: imageRegex
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
