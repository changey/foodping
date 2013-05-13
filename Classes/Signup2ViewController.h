//
//  Signup2ViewController.h
//  NB_list
//
//  Created by Shiyang Liu on 10/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Customer2ViewController.h"

@class Customer2ViewController;

@interface Signup2ViewController : UIViewController{
    Customer2ViewController *viewcus;
    
    IBOutlet UITextField *user;
    IBOutlet UITextField *pass;
}

@property (nonatomic, retain) Customer2ViewController *viewcus;

@property (nonatomic, retain) IBOutlet UITextField *user;
@property (nonatomic, retain) IBOutlet UITextField *pass;

-(IBAction)connect;

@end
