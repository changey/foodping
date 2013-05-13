//
//  FrequentsViewController.h
//  NB_list
//
//  Created by Eric Chang on 10/22/12.
//
//

#import <UIKit/UIKit.h>
#import "MerchantViewController.h"

@interface FrequentsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    
    NSMutableArray *ids;
    NSMutableArray *items;
    NSMutableArray *discounts;
    
    IBOutlet UITableView *tableView;
}

@property (nonatomic, retain) NSMutableArray *ids;
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) NSMutableArray *discounts;

- (IBAction)cancel;

@end
