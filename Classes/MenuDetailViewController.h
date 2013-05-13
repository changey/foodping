//
//  MenuDetailViewController.h
//  NB_list
//
//  Created by Eric Chang on 10/29/12.
//
//

#import <UIKit/UIKit.h>

@interface MenuDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    
    NSMutableArray *items;
    NSMutableArray *prices;
    
}

@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) NSMutableArray *prices;

-(IBAction) cancel;

@end
