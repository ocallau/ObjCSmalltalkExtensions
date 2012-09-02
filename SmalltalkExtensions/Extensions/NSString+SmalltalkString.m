//
//  NSString+SmalltalkString.m
//  SmalltalkExtensions
//
//  Created by Oscar E A Callau on 8/26/12.
//  Copyright (c) 2012 Uchile. All rights reserved.
//

#import "NSString+SmalltalkString.h"

@implementation NSString (SmalltalkString)

-(BOOL)includesSubString:(NSString*) subString{
    return [self rangeOfString:subString].location != NSNotFound; 
}

/*
 "Answer whether text matches the pattern in this string.
 Matching ignores upper/lower case differences.
 Where this string contains #, text may contain any character.
 Where this string contains *, text may contain any sequence of characters."
 
 '*'			match: 'zort' true
 '*baz'		match: 'mobaz' true
 '*baz'		match: 'mobazo' false
 '*baz*'		match: 'mobazo' true
 '*baz*'		match: 'mozo' false
 'foo*'		match: 'foozo' true
 'foo*'		match: 'bozo' false
 'foo*baz'	match: 'foo23baz' true
 'foo*baz'	match: 'foobaz' true
 'foo*baz'	match: 'foo23bazo' false
 'foo'		match: 'Foo' true
 'foo*baz*zort' match: 'foobazort' false
 'foo*baz*zort' match: 'foobazzort' true
 '*foo#zort'	match: 'afoo3zortthenfoo3zort' true
 '*foo*zort'	match: 'afoodezortorfoo3zort' true
*/ 
-(BOOL) match: (NSString*) text{
    NSString* pattern = [NSString stringWithFormat:@"^%@$",[[self 
                          stringByReplacingOccurrencesOfString:@"#" withString:@"."] 
                          stringByReplacingOccurrencesOfString:@"*" withString:@".*"]];
    
    NSRegularExpression* regex= [[NSRegularExpression alloc] 
                                    initWithPattern:pattern
                                    options:NSRegularExpressionCaseInsensitive 
                                    error:nil];
    
    int c= [regex numberOfMatchesInString:text 
                                  options:0 
                                    range:NSMakeRange(0, [text length])];
    return c > 0;
} //test it


-(NSString*) trim{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/*
 candidates:
 String >> asNSDate or dateValue. but the format is relevant!
 
 */


@end
