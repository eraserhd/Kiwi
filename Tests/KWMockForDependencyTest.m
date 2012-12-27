//
// Licensed under the terms in License.txt
//
// Copyright 2012 Allen Ding. All rights reserved.
//

#import "Kiwi.h"
#import "KiwiTestConfiguration.h"
#import "KWIntercept.h"
#import "TestClasses.h"

#if KW_TESTS_ENABLED

@interface KWMockForDependencyTest : SenTestCase

@end

@implementation KWMockForDependencyTest

- (void)tearDown {
	KWClearStubsAndSpies();
}

- (void)testItCanNullMockADependencyWithASpecifiedType {
	Cruiser *cruiser = [[[Cruiser alloc] init] autorelease];
	id engine = [cruiser nullMockForDependency:@"engine" ofType:[Engine class]];
	STAssertNotNil(engine, @"expected nullMockForDependency:ofType: to return a value");
	STAssertTrue([engine isNullMock], @"expected nullMockForDependency:ofType: to return a null mock");
	STAssertTrue([engine isKindOfClass:[Engine class]], @"expected mock to be of the correct type");
	STAssertTrue(engine == [cruiser valueForKey:@"engine"], @"expected mock to be injected");
}

- (void)testItCanMockADependencyWithASpecifiedType {
	Cruiser *cruiser = [[[Cruiser alloc] init] autorelease];
	id engine = [cruiser mockForDependency:@"engine" ofType:[Engine class]];
	STAssertNotNil(engine, @"expected mockForDependency:ofType: to return a value");
	STAssertFalse([engine isNullMock], @"expected mockForDependency:ofType: to return a mock which isn't a null mock");
	STAssertTrue([engine isKindOfClass:[Engine class]], @"expected mock to be of the correct type");
	STAssertTrue(engine == [cruiser valueForKey:@"engine"], @"expected mock to be injected");
}

- (void)testItShouldReturnTheSameNullMockEachTime {
	Cruiser *cruiser = [[[Cruiser alloc] init] autorelease];
	id engine1 = [cruiser nullMockForDependency:@"engine" ofType:[Engine class]];
	id engine2 = [cruiser nullMockForDependency:@"engine" ofType:[Engine class]];
	STAssertTrue(engine1 == engine2, @"expectd nullMockForDependency:ofType: to return the same mock each time");
}

- (void)testItShouldReturnTheSameMockEachTime {
	Cruiser *cruiser = [[[Cruiser alloc] init] autorelease];
	id engine1 = [cruiser mockForDependency:@"engine" ofType:[Engine class]];
	id engine2 = [cruiser mockForDependency:@"engine" ofType:[Engine class]];
	STAssertTrue(engine1 == engine2, @"expectd mockForDependency:ofType: to return the same mock each time");
}

@end

#endif // #if KW_TESTS_ENABLED
