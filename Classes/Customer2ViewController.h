//
//  Customer2ViewController.h
//  NB_list
//
//  Created by Eric Chang on 10/9/12.
//
//

#import <UIKit/UIKit.h>
#import "DiscountsViewController.h"
#import "Menu2ViewController.h"

@class DiscountsViewController;
@class Menu2ViewController;

@interface Customer2ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    
    Menu2ViewController *viewmenu;
    
    DiscountsViewController *viewdis;
    
    NSMutableArray *mer_names;
    NSMutableArray *mer_addresses;
    NSMutableArray *mer_ids;
    
    IBOutlet UILabel *label;
    
}

@property (nonatomic, retain) Menu2ViewController *viewmenu;

@property (nonatomic, retain) IBOutlet UILabel *label;

@property (nonatomic, retain) DiscountsViewController *viewdis;

@property (nonatomic, retain) NSMutableArray *mer_names;
@property (nonatomic, retain) NSMutableArray *mer_addresses;
@property (nonatomic, retain) NSMutableArray *mer_ids;

@end
