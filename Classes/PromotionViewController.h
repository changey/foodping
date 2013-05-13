//
//  PromotionViewController.h
//  NB_list
//
//  Created by Eric Chang on 11/1/12.
//
//

#import <UIKit/UIKit.h>

@interface PromotionViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    
    NSMutableArray *categories;
    
    NSMutableArray *items;
    NSMutableArray *prices;
    NSMutableArray *categories_i;
    
    NSMutableArray *numbers;
    NSMutableArray *numbers_a;
    
    IBOutlet UITableView *tableView;
    
    int l;
}


@property (nonatomic, retain) NSMutableArray *categories;

@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) NSMutableArray *prices;
@property (nonatomic, retain) NSMutableArray *categories_i;

@property (nonatomic, retain) NSMutableArray *numbers;
@property (nonatomic, retain) NSMutableArray *numbers_a;

- (IBAction) cancel;

@end
