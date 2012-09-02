//
//  NSMutableArray+SmalltalkCollections.h
//  SmalltalkExtensions
//
//  Created by Oscar E A Callau on 8/26/12.
//  Copyright (c) 2012 Uchile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSArray+SmalltalkCollections.h"

@interface NSMutableArray (SmalltalkCollections)

-(NSMutableArray*) collect: (STTranslator) transalator;
-(NSMutableArray*) collectInside: (STTranslator) transalator;

-(NSMutableArray*) reject: (STPredicate) predicate;
-(NSMutableArray*) select: (STPredicate) predicate;
-(NSMutableArray*) rejectInside: (STPredicate) predicate;
-(NSMutableArray*) selectInside: (STPredicate) predicate;

-(id) removeFirstObject;
-(NSMutableArray*)removeAllSuchThat: (STPredicate) predicate;
@end
