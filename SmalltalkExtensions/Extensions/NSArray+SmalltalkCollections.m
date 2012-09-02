//
//  NSArray+SmalltalkCollections.m
//  SmalltalkExtensions
//
//  Created by Oscar E A Callau on 8/26/12.
//  Copyright (c) 2012 Uchile. All rights reserved.
//

#import "NSArray+SmalltalkCollections.h"

@implementation NSArray (SmalltalkCollections)

-(id) first{
    return [self objectAtIndex:0];
}
-(id) second{
    return [self objectAtIndex:1];
}
-(id) third{
    return [self objectAtIndex:2];
}
-(id) fourth{
    return [self objectAtIndex:3];
}


-(BOOL) isEmpty{
    return [self count] == 0;
}

-(id) anyOne{
    if([self isEmpty]) 
        [NSException raise:@"There is no elements" 
                     format:@"%@ is empty",self];
    int idx = arc4random() % [self count];
    return [self objectAtIndex:idx];
}

-(NSMutableArray*) asNSMutableArray{
    return [NSMutableArray arrayWithArray:self];
}

-(NSSet*) asNSSet{
    return [NSSet setWithArray:self];
}

-(BOOL) allSatisfy: (STPredicate) predicate{
    for(id object in self){ // may an enumeration? but for each is fast, isn't it?
        if(!predicate(object)) return false;
    }
    return true;
}

-(BOOL) anySatisfy: (STPredicate) predicate{
    for(id object in self)
        if(predicate(object)) return true;
    
    return false;
}

-(NSArray*) collect: (STTranslator) transalator{
    NSMutableArray* neo= [NSMutableArray arrayWithCapacity:[self count]];
    for(id obj in self){
        [neo addObject:transalator(obj)];
    }
    return neo;
}

-(id) detect:(STPredicate) predicate ifNone: (STThunk) exBlock{
    for(id object in self)
        if(predicate(object)) return object;

    return exBlock();
}

-(id) inject: (id) acc into: (STBinary)binaryBlock{ 
    for(id obj in self){
        acc = binaryBlock(acc,obj);
    }
    return acc;   //must be tested!!!
}

-(BOOL) noneSatisfy: (STPredicate) predicate{
    return ![self anySatisfy:predicate];
}

-(id)reduce:(STBinary) binaryBlock{
    id acc = [self first];
    for(int idx = 1 ; idx < [self count] ; idx ++){
        acc = binaryBlock(acc, [self objectAtIndex:idx]);
    }
    return acc;
};

-(NSArray*) reject: (STPredicate) predicate{
    return [self select:^BOOL(id obj) {
        return !predicate(obj);
    }];
}

-(NSArray*) select: (STPredicate) predicate{
    NSMutableArray* neo=[NSMutableArray arrayWithCapacity:[self count]];
    for (id obj in self) 
        if (predicate(obj)) [neo addObject:obj];
    
    return neo;
}



/*
 Next Candidates:
 Collection >> groupedBy:
    >> asCommaString
    >> asStringOn:delimiter:last: 
 
 SequenceableCollection >> reverse
    >> reduceLeft:
    >> reduceRight:
 */


@end