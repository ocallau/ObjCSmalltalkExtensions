//
//  NSMutableArray+SmalltalkCollections.m
//  SmalltalkExtensions
//
//  Created by Oscar E A Callau on 8/26/12.
//  Copyright (c) 2012 Uchile. All rights reserved.
//

#import "NSMutableArray+SmalltalkCollections.h"

@implementation NSMutableArray (SmalltalkCollections)

-(NSMutableArray*) collect: (STTranslator) transalator{
    return (NSMutableArray*) [super collect:transalator]; //test it
}

-(NSMutableArray*) collectInside: (STTranslator) transalator{
    for (int idx=0; idx < [self count]; idx++) {
        [self replaceObjectAtIndex: idx 
              withObject: transalator([self objectAtIndex:idx])];
    }
    return self;
}

-(NSMutableArray*) reject: (STPredicate) predicate{
    return (NSMutableArray*) [super reject:predicate];
}

-(NSMutableArray*) select: (STPredicate) predicate{
    return (NSMutableArray*) [super select:predicate];
}

-(NSMutableArray*) rejectInside: (STPredicate) predicate{
    return [self removeAllSuchThat:predicate];
}

-(NSMutableArray*) selectInside: (STPredicate) predicate{
    return [self removeAllSuchThat:^BOOL(id obj) {
        return !predicate(obj);
    }];
}

-(id) removeFirstObject{
    id first = [self first];
    [self removeObjectAtIndex:0];
    return first;
}

-(NSMutableArray*) removeAllSuchThat:(STPredicate)predicate{
    //may be return void? but void is the worst thing in the universe!
    
    NSArray* array=[self select:predicate];
    for (id obj in array) {
        [self removeObject:obj]; //test it!
    }
    
    return self;
}

@end
