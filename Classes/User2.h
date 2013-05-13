//
//  User2.h
//  NB_list
//
//  Created by Eric Chang on 6/14/12.
//
//

#import <Foundation/Foundation.h>

@interface User2 : NSObject{
    NSTimer *timer;
    
    NSString *merchant_id;
    NSString *merchant_section;
    
	NSString *correct;
	NSString *total;
    
    NSString *seconds2, *minutes2;
    
    NSString *instructions;
    
    NSString *rotate1;
    
    NSString *user;
    NSString *pass;
    
    NSString *item;
    NSString *promotion;
    
    NSString *url;

	
}
@property (retain, nonatomic) NSString *url;

@property (retain, nonatomic) NSString *item;
@property (retain, nonatomic) NSString *promotion;

@property (retain, nonatomic) NSString *merchant_id;
@property (retain, nonatomic) NSString *merchant_section;


@property (nonatomic,strong) NSString *user;
@property (nonatomic,strong) NSString *pass;


+ (User2 *)sharedUser;
@end
