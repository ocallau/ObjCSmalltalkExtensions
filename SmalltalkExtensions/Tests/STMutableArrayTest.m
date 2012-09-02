//
//  STMutableArrayTest.m
//  SmalltalkExtensions
//
//  Created by Oscar E A Callau on 9/1/12.
//  Copyright (c) 2012 Uchile. All rights reserved.
//

#import "STMutableArrayTest.h"
#import "NSMutableArray+SmalltalkCollections.h"

@implementation STMutableArrayTest{
    NSMutableArray* array;
    NSMutableArray* empty;
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
    array = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4", nil];
    empty = [NSMutableArray array];
}

-(void) testRemoves{
    GHAssertTrue([array removeFirstObject] == one,@"ex-1",
                 [array count] == 3, @"size",
                 [array first] == two, @"new-1");
    GHAssertFalse([array containsObject:one], @"no-1");
    
    GHAssertThrows([empty removeFirstObject], @"rem-empty");
    
    GHAssertNoThrow([array removeAllSuchThat:^BOOL(id obj) {
                        return [obj length] ==1;}],@"rem-all",
                    [empty removeAllSuchThat: nil], @"rem-empty");
    
    GHAssertTrue([array isEmpty], @"empty1",
                 [empty isEmpty], @"empty2");
    
}

-(void) testCollectInside{
    GHAssertTrue([[empty collectInside:nil] isEmpty],@"default");
    [array collectInside:^id(id obj) {
        return [NSArray arrayWithObject:obj];
    }];
    
    GHAssertTrue([array count] == 4,@"same size",
                 [array allSatisfy:^BOOL(id obj) {
                    return [obj isKindOfClass:[NSArray class]];}], @"all array",
                 [[array second] first] == two, @"2-1");
}

-(void) testSelectInside{
    [array selectInside:^BOOL(id obj) {
        return [obj intValue] > 2; }];
    
    GHAssertTrue([array count] == 2, @"2 elems",
                 [array first] == three, @"3",
                 [array second] == four,@"4",
                 [[empty selectInside:nil] isEmpty], @"empty select",
                 [[array selectInside:^BOOL(id obj) {
                    return false;}] isEmpty], @"none selected",
                 [array isEmpty], @"now is empty");
}

-(void) testRejectInside{
    [array rejectInside:^BOOL(id obj) {
        return [obj intValue] <= 2; }];
    
    GHAssertTrue([array count] == 2, @"2 elems",
                 [array first] == three, @"3",
                 [array second] == four,@"4",
                 [[empty rejectInside:nil] isEmpty], @"empty select",
                 [[array rejectInside:^BOOL(id obj) {
                    return true;}] isEmpty], @"none selected",
                 [array isEmpty], @"now is empty");
}


-(void) tearDown{
    array = nil;
    empty = nil;
}
@end
