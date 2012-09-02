//
//  STStringTests.m
//  SmalltalkExtensions
//
//  Created by Oscar E A Callau on 8/28/12.
//  Copyright (c) 2012 Uchile. All rights reserved.
//

#import "STStringTests.h"
#import "NSString+SmalltalkString.h"

@implementation STStringTests

-(void)testIncludesSubString{
    GHAssertTrue([@"a bcd e" includesSubString:@"bc"],@"inclusion");
    GHAssertFalse([@"a bcd e" includesSubString:@"gh"],@"exclusion");
}

-(void)testMatch{
    GHAssertTrue([@"*"match: @"zort"],@"*",
                 [@"*baz"		match: @"mobaz"],@"*b t"); 
    GHAssertFalse([@"*baz"match: @"mobazo"],@"*b f");
    GHAssertTrue([@"*baz*"		match: @"mobazo"],@"*b* t");
    GHAssertFalse([@"*baz*"match: @"mozo"],@"");
    GHAssertTrue([@"foo*"		match: @"foozo"],@"");
    GHAssertFalse([@"foo*"match: @"bozo"],@"");
    GHAssertTrue([@"foo*baz"	match: @"foo23baz"] ,@"");
    GHAssertTrue([@"foo*baz"	match: @"foobaz"],@"");
    GHAssertFalse([@"foo*baz"match: @"foo23bazo"],@"");
    GHAssertTrue([@"foo"		match: @"Foo" ],@"");
    GHAssertFalse([@"foo*baz*zort" match: @"foobazort"],@"");
    GHAssertTrue([@"foo*baz*zort" match: @"foobazzort"],@"");
    GHAssertTrue([@"*foo#zort"	match: @"afoo38zortthenfoo3zort"],@"" );
    GHAssertTrue([@"*foo*zort"	match: @"afoodezortorfoo3zort"],@"" );
}

-(void)testTrim{
    GHAssertTrue([[@"  aaa " trim] isEqualToString:@"aaa"],@"trimmed1",
                 [[@"  a a " trim] isEqualToString:@"a a"],@"trimmed2",
                 [[@"\n \t aa   " trim] isEqualToString:@"aa"],@"trimmed3");
}

@end
