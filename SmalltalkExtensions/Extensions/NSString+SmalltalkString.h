//
//  NSString+SmalltalkString.h
//  SmalltalkExtensions
//
//  Created by Oscar E A Callau on 8/26/12.
//  Copyright (c) 2012 Uchile. All rights reserved.
//



@interface NSString (SmalltalkString)


-(BOOL)includesSubString:(NSString*) subString;
-(BOOL) match: (NSString*) text;
-(NSString*) trim;

@end
