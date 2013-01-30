//
//  NSSet+SmalltalkSet.m
//  SmalltalkExtensions
//
//  Created by Oscar E A Callaú on 12/20/12.
//  Copyright (c) 2012 Uchile. All rights reserved.
//

#import "NSSet+SmalltalkSet.h"

@implementation NSSet (SmalltalkSet)

+(BOOL) isNilOrEmpty: (NSSet*) set{
    return set == nil || set.count == 0;
}

@end
