//
//  STArrayTests.m
//  SmalltalkExtensions
//
//  Created by Oscar E A Callau on 9/1/12.
//  Copyright (c) 2012 Uchile. All rights reserved.
//

#import "STArrayTests.h"
#import "NSArray+SmalltalkCollections.h"

@implementation STArrayTests{
    NSArray* array;
    NSArray* empty;
    NSString* one;
    NSString* two;
    NSString* three;
    NSString* four;
}

-(void) setUpClass{
    one=@"1";
    two=@"2";
    three=@"3";
    four=@"4";
}

-(void) setUp{
    array = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4", nil];
    empty = [NSArray array];
}

-(void) testPositions{
    GHAssertTrue([array first] == one,@"1",
                 [array second] == two,@"2",
                 [array third] == three,@"3",
                 [array fourth] == four,@"4");
    
    GHAssertThrows([empty first],@"1",
                   [empty second],@"2",
                   [empty third],@"3",
                   [empty fourth],@"4");
}

-(void) testEmpty{
    GHAssertFalse([array isEmpty],@"full");
    GHAssertTrue([empty isEmpty],@"empty");
}

-(void) testAnyOne{
    GHAssertTrue([array containsObject:[array anyOne]],@"any one");
    GHAssertThrows([empty anyOne],@"any one -empty");
}

-(void) testMutableArray{
    NSMutableArray *marray = [array asNSMutableArray];
    GHAssertTrue([marray count] == 4, @"same size");
    GHAssertFalse(marray == array,@"diff obj");
    GHAssertTrue([marray containsObject:[array first]],@"1",
                 [marray containsObject:[array second]],@"2",
                 [marray containsObject:[array third]],@"3",
                 [marray containsObject:[array fourth]],@"4");
    
    GHAssertTrue([[empty asNSMutableArray] isEmpty],@"empty mutable");
}

-(void) testSet{
    NSSet *set= [array asNSSet];
    GHAssertTrue([set count] == 4,@"same size");
    GHAssertTrue([set containsObject:[array first]],@"1",
                 [set containsObject:[array second]],@"2",
                 [set containsObject:[array third]],@"3",
                 [set containsObject:[array fourth]],@"4");
    
    GHAssertTrue([[empty asNSSet] count] == 0,@"empty set");
}

-(void) testSatisfy{
    GHAssertTrue([array allSatisfy:^BOOL(id obj) {
                    return [obj isKindOfClass:[NSString class]];}],@"all strings",
                 [array allSatisfy:^BOOL(id obj) {
                    return [obj length] == 1; }],@"all size",
                 [array anySatisfy:^BOOL(id obj){
                    return [obj isEqualToString:@"2"];}], @"any 2",
                 [array noneSatisfy:^BOOL(id obj) {
                    return [obj length] > 1;}], @"none size");
    GHAssertFalse([array allSatisfy:^BOOL(id obj) {
                    return [obj intValue] < 4;}],@"not all <4",
                  [array anySatisfy:^BOOL(id obj) {
                    return [obj isKindOfClass:[NSArray class]];} ],@"not arrays",
                  [array noneSatisfy:^BOOL(id obj) {
                    return [obj isEqualToString:@"1"];}],@"here is 1");
    
    GHAssertTrue([empty allSatisfy:^BOOL(id obj) {
                    return true;}], @"default ",
                 [empty noneSatisfy:^BOOL(id obj) {
                    return false;}],@"default "  );
    GHAssertFalse([empty anySatisfy:^BOOL(id obj) {
                    return true;}],@"default ");
}

-(void) testCollect{
    NSArray* ints = [array collect:^id(id obj) { 
        return [NSNumber numberWithInt:[obj intValue]]; }];
    
    GHAssertTrue([ints allSatisfy:^BOOL(id obj) {
                    return [obj isKindOfClass:[NSNumber class]];}],@"all numbers",
                 [[ints second] intValue] == 2, @"2nd",
                 [[empty collect:nil] isEmpty], @"empty collect");
    
}

-(void) testSelect{
    NSArray *selected = [array select:^BOOL(id obj) {
        return [obj intValue] > 2; }];
    
    GHAssertTrue([selected count] == 2, @"2 elems",
                 [[selected first] intValue]== 3, @"3",
                 [[selected second]intValue] == 4,@"4",
                 [[empty select:nil] isEmpty], @"empty select",
                 [[array select:^BOOL(id obj) {
                     return false;}] isEmpty], @"none selected");
}

-(void) testReject{
    NSArray *selected = [array reject:^BOOL(id obj) {
        return [obj intValue] <= 2; }];
    
    GHAssertTrue([selected count] == 2, @"2 elems",
                 [[selected first] intValue]== 3, @"3",
                 [[selected second]intValue] == 4,@"4",
                 [[empty reject:nil] isEmpty], @"empty select",
                 [[array reject:^BOOL(id obj) {
                    return true;}] isEmpty], @"none selected");
}

-(void) testDetect{
    GHAssertTrue([[array detect:^BOOL(id obj) {
                    return [obj intValue] == 2;} ifNone:nil] intValue] == 2, @"2",
                 [[array detect:^BOOL(id obj) { return false; } 
                        ifNone:^id{ return @"0";}] intValue] == 0, @"0",
                 [[empty detect:nil ifNone:^id{ return @"0";}] intValue] == 0, @"e");
}

-(void) testInjectReduce{
    STBinary binaryBlock= ^id(id obj1, id obj2){
        return [NSNumber numberWithInt:[obj1 intValue] + [obj2 intValue]];};
    GHAssertTrue([[array inject:@"0" into:binaryBlock] intValue] == 10, @"injt-sum",
                 [[array reduce:binaryBlock] intValue] == 10, @"redu-sum",
                 [[empty inject:@"0" into:nil] intValue] == 0, @"e");
    
    GHAssertThrows([empty reduce:binaryBlock],@"empty reduce");
}

-(void) tearDown{
    array = nil;
    empty = nil;
}

-(void) tearDownClass{
    one=nil;
    two=nil;
    three=nil;
    four=nil;
}

@end
