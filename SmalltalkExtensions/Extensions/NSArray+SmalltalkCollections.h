//
//  NSArray+SmalltalkCollections.h
//  SmalltalkExtensions
//
//  Created by Oscar E A Callau on 8/26/12.
//  Copyright (c) 2012 Uchile. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL(^STPredicate)(id obj);
typedef id(^STTranslator)(id obj);
typedef id(^STThunk)();
typedef id(^STBinary)(id obj1, id obj2);

@interface NSArray (SmalltalkCollections)

-(id) first;
-(id) second;
-(id) third;
-(id) fourth;
-(id) anyOne;

-(NSMutableArray*) asNSMutableArray;
-(NSSet*) asNSSet;


-(BOOL) isEmpty;

-(BOOL) allSatisfy: (STPredicate) predicate;
-(BOOL) anySatisfy: (STPredicate) predicate;
-(BOOL) noneSatisfy: (STPredicate) predicate;

-(id) detect:(STPredicate) predicate ifNone: (STThunk) exBlock;
-(id) inject: (id) acc into: (STBinary)binaryBlock;
-(id) reduce:(STBinary) binaryBlock;

-(NSArray*) collect: (STTranslator) transalator;
-(NSArray*) reject: (STPredicate) predicate;
-(NSArray*) select: (STPredicate) predicate;

@end
