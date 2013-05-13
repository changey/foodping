//
//  Menu2ViewController.h
//  NB_list
//
//  Created by Eric Chang on 11/9/12.
//
//

#import <UIKit/UIKit.h>

@interface Menu2ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{

    
    NSMutableArray *categories;
    
    NSMutableArray *items;
    NSMutableArray *prices;
    NSMutableArray *categories_i;
    NSMutableArray *names;
    
    NSMutableArray *numbers;
    NSMutableArray *numbers_a;
    
    IBOutlet UITableView *tableView;
    
    int l;
}

@property (nonatomic, retain) NSMutableArray *names;

@property (nonatomic, retain) NSMutableArray *categories;

@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) NSMutableArray *prices;
@property (nonatomic, retain) NSMutableArray *categories_i;

@property (nonatomic, retain) NSMutableArray *numbers;
@property (nonatomic, retain) NSMutableArray *numbers_a;

- (IBAction) cancel;

@end
