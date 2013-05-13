//
//  MerDiscountsViewController.h
//  NB_list
//
//  Created by Eric Chang on 10/12/12.
//
//

#import <UIKit/UIKit.h>
#import "MerchantViewController.h"

@class MerchantViewController;

@interface MerDiscountsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    
    MerchantViewController *viewmer;
    
    NSMutableArray *ide;
    NSMutableArray *items;
    NSMutableArray *discounts;
    NSMutableArray *expirations;
    
    IBOutlet UITableView *tableView;
    
}

- (IBAction) Edit:(id)sender;
- (IBAction) newd;

@property (nonatomic, retain) MerchantViewController *viewmer;

@property (nonatomic, retain) NSMutableArray *ide;
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) NSMutableArray *discounts;
@property (nonatomic, retain) NSMutableArray *expirations;

@end
