//
//  User2.m
//  NB_list
//
//  Created by Eric Chang on 6/14/12.
//
//

#import "User2.h"
static User2 *sharedUser = nil;
@implementation User2

@synthesize user, pass;

@synthesize merchant_id, merchant_section, item, promotion, url;

int hours, minutes, seconds;
int secondsLeft;

#pragma mark -
#pragma mark Singleton Methods

+ (User2 *)sharedUser {
	if(sharedUser == nil){
		sharedUser = [[super allocWithZone:NULL] init];
	}
	return sharedUser;
}
+ (id)allocWithZone:(NSZone *)zone {
	return [[self sharedManager] retain];
}
- (id)copyWithZone:(NSZone *)zone {
	return self;
}
- (id)retain {
	return self;
}
- (unsigned)retainCount {
	return NSUIntegerMax;
}
- (void)release {
	//do nothing
}
- (id)autorelease {
	return self;
}
@end