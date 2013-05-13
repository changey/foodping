//
//  MenuViewController.h
//  NB_list
//
//  Created by Eric Chang on 10/24/12.
//
//

#import <UIKit/UIKit.h>
#import "MenuDetailViewController.h"

@class MenuDetailViewController;

@interface MenuViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    
    MenuDetailViewController *viewmenu;
    
    NSMutableArray *categories;
    
    NSMutableArray *items;
    NSMutableArray *prices;
    NSMutableArray *categories_i;
    
    NSMutableArray *numbers;
    NSMutableArray *numbers_a;
    
    IBOutlet UITableView *tableView;
    
    int l;
}

@property (nonatomic, retain) MenuDetailViewController *viewmenu;

@property (nonatomic, retain) NSMutableArray *categories;

@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) NSMutableArray *prices;
@property (nonatomic, retain) NSMutableArray *categories_i;

@property (nonatomic, retain) NSMutableArray *numbers;
@property (nonatomic, retain) NSMutableArray *numbers_a;

- (IBAction) cancel;

@end
