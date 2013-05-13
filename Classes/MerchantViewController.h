//
//  MerchantViewController.h
//  NB_list
//
//  Created by Eric Chang on 10/9/12.
//
//

#import <UIKit/UIKit.h>
#import "TDDatePickerController.h"
#import "MerDiscountsViewController.h"
#import "FrequentsViewController.h"
#import "Menu2ViewController.h"
#import "PromotionViewController.h"

@class MerDiscountsViewController;
@class FrequentsViewController;
@class Menu2ViewController;
@class PromotionViewController;

@interface MerchantViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>{
    
    PromotionViewController *viewpromo;
    
    Menu2ViewController *viewmenu;
    
    MerDiscountsViewController *viewmer;
    FrequentsViewController *viewfreq;
    
    IBOutlet UITextField *item;
    IBOutlet UITextField *discount;
    IBOutlet UILabel *expiration;
    IBOutlet UITextField *offer;
    
    IBOutlet UITableView *tableView;
    
    IBOutlet TDDatePickerController* datePickerView;
    
    NSString *merchant_id;
    NSString *message;
    
    NSDate* selectedDate;
    
    IBOutlet UIScrollView *scrollView;
    
    UITextField *loginId; 
}

@property (nonatomic, retain) UIScrollView *scrollView;

@property (nonatomic, retain) PromotionViewController *viewpromo;

@property (nonatomic, retain) Menu2ViewController *viewmenu;
@property (nonatomic, retain) MerDiscountsViewController *viewmer;
@property (nonatomic, retain) FrequentsViewController *viewfreq;

@property (nonatomic, retain)  NSString *message;
@property (nonatomic, retain) NSString *merchant_id;

@property (nonatomic, retain) IBOutlet UITextField *item;
@property (nonatomic, retain) IBOutlet UITextField *discount;
@property (nonatomic, retain) IBOutlet UILabel *expiration;
@property (nonatomic, retain) IBOutlet UITextField *offer;


- (IBAction) frequent;

- (IBAction)send:(id)sender;
- (IBAction)promotions;

- (IBAction)cancel;

-(IBAction)menu;

-(IBAction)promo;


@end
