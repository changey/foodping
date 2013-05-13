//
//  MerchantViewController.m
//  NB_list
//
//  Created by Eric Chang on 10/9/12.
//
//

#import "MerchantViewController.h"
#import "Parse/Parse.h"
#import "User2.h"
#import "TDSemiModal.h"
#import "ASIHTTPRequest.h"

@interface MerchantViewController ()

@end

@implementation MerchantViewController

@synthesize item, discount, expiration, merchant_id, message, viewmer, viewfreq, viewmenu, viewpromo, offer;

@synthesize scrollView;

-(IBAction)promo{
    if(self.viewpromo == nil) {
        PromotionViewController *secondxib =
        [[PromotionViewController alloc] initWithNibName:@"PromotionViewController" bundle:[NSBundle mainBundle]];
        self.viewpromo = secondxib;
        [secondxib release];
    }
    
    [self presentModalViewController:viewpromo animated:YES];
}

-(IBAction)menu{
    if(self.viewmenu == nil) {
        Menu2ViewController *secondxib =
        [[Menu2ViewController alloc] initWithNibName:@"Menu2ViewController" bundle:[NSBundle mainBundle]];
        self.viewmenu = secondxib;
        [secondxib release];
    }
    
    [self presentModalViewController:viewmenu animated:YES];
}

- (IBAction)cancel{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    User2 *user=[User2 sharedUser];
  
}
-(IBAction)send:(id)sender{
    
    NSString *item_s=item.text;
    NSString *discount_s=discount.text;
    NSString *expiration_s=expiration.text;
    message=[NSString stringWithFormat:@"Buy %@ get %@. Expired: %@",item_s, discount_s,expiration_s];
    
  /*  UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Is this correct?" message:message
                                                          delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Send", nil];
    [alertsuccess show];
    [alertsuccess release];*/
    
    if([item_s isEqualToString:@""]){
        UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Enter an item"
                                                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertsuccess show];
        [alertsuccess release];
    }
    else if([discount_s isEqualToString:@""]){
        UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Enter a promotion"
                                                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertsuccess show];
        [alertsuccess release];
    }
    else if([expiration_s isEqualToString:@"Pick a time"]){
        UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Pick a expiration time"
                                                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertsuccess show];
        [alertsuccess release];
    }
    else{
        
        UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Promotion" message:message
                                                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertsuccess show];
        [alertsuccess release];
    
   // [PFPush sendPushMessageToChannelInBackground:@"" withMessage:message];
    
        User2 *user=[User2 sharedUser];
        
        //NSString *finalString= [urlString stringByReplacingOccurrencesOfString:@" " withString:@"_"];
        
        //NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString: finalString]];
        
        NSString *url = [NSString stringWithFormat:@"%@/discounts.php?merchant=%@&item=%@&discount=%@&expiration=%@", user.url, user.merchant_id, item_s,discount_s,expiration_s];  // server name does not match
        NSString *finalString= [url stringByReplacingOccurrencesOfString:@" " withString:@"_"];
        
        NSURL *URL = [NSURL URLWithString:finalString];
        
      //  [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[URL host]];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
        [request startSynchronous];
        NSError *error = [request error];
        NSString *returnString;
        if (!error) {
            returnString = [request responseString];
            NSLog(@"%@",returnString);
        }
        
        [self dismissModalViewControllerAnimated:YES];
    }
    
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    User2 *user = [User2 sharedUser];
    
    if ([user.item isEqualToString:@""]==false && [user.promotion isEqualToString:@""]==false){
        item.text=user.item;
        discount.text=user.promotion;
    }
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
}

-(IBAction)promotions{
    if(self.viewmer == nil) {
        MerDiscountsViewController *secondxib =
        [[MerDiscountsViewController alloc] initWithNibName:@"MerDiscountsViewController" bundle:[NSBundle mainBundle]];
        self.viewmer = secondxib;
        [secondxib release];
    }
    
    [self.navigationController pushViewController:self.viewmer animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *item_s=item.text;
    NSString *discount_s=discount.text;
    NSString *expiration_s=expiration.text;
    switch (buttonIndex) {
        case 0:
          //  printf("Cancel button pressedn");
            break;
            
        case 1:
            printf("first button pressedn");
            //[send_info];
           // [PFPush sendPushMessageToChannelInBackground:@"" withMessage:message];
            
            User2 *user=[User2 sharedUser];
            
            NSString *url = [NSString stringWithFormat:@"%@/discounts.php?merchant=%@&item=%@&discount=%@&expiration=%@", user.url, user.merchant_id, item_s,discount_s,expiration_s];  // server name does not match
            NSString *finalString= [url stringByReplacingOccurrencesOfString:@" " withString:@"_"];
            
            NSURL *URL = [NSURL URLWithString:finalString];
            
         //   [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[URL host]];
            
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
            [request startSynchronous];
            NSError *error = [request error];
            NSString *returnString;
            if (!error) {
                returnString = [request responseString];
              //  NSLog(@"%@",returnString);
            }
            
          //  NSLog(@"the return string: %@", returnString);
            
            
            break;

        default:
            break;
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    //---set the viewable frame of the scroll view---
   // scrollView.frame = CGRectMake(0, 0, 320, 460);
    
    //---set the content size of the scroll view---
   // [scrollView setContentSize:CGSizeMake(320, 713)];
    
    tableView.scrollEnabled = NO;
    scrollView.contentSize = CGSizeMake(320, 600);
    

    
    [scrollView flashScrollIndicators];
  /*  UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Frequent promotions" style:UIBarButtonItemStyleBordered target:self action:@selector(frequent:)];
	[self.navigationItem setRightBarButtonItem:addButton];*/
    
    [self.navigationController setNavigationBarHidden:NO];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction) frequent{
   /* if(self.viewmenu == nil) {
        MenuViewController *secondxib =
        [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:[NSBundle mainBundle]];
        self.viewmenu = secondxib;
        [secondxib release];
    }
    
    [self presentModalViewController:viewmenu animated:YES];*/
    
	if(self.viewfreq == nil) {
        FrequentsViewController *secondxib =
        [[FrequentsViewController alloc] initWithNibName:@"FrequentsViewController" bundle:[NSBundle mainBundle]];
        self.viewfreq = secondxib;
        [secondxib release];
    }
    
    [self presentModalViewController:viewfreq animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

/*- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // return titleForHeader;
}*/

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:SimpleTableIdentifier] autorelease];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if(indexPath.row==0){
     /* loginId = [[UITextField alloc] initWithFrame:CGRectMake(200, 0, 280, 21)];
        loginId .placeholder = @"e.g. an orange chicken";
        loginId .autocorrectionType = UITextAutocorrectionTypeNo;
        [loginId setClearButtonMode:UITextFieldViewModeWhileEditing];
        cell.accessoryView = loginId ;
        UITextField *textField = [[UITextField alloc] init];*/
        // Set a unique tag on each text field
       /* textField.tag = indexPath.row;
        textField.placeholder=@"e.g. an orange chicken";
        cell.accessoryView
        [cell.contentView addSubview:textField];
        [textField release];*/
        cell.textLabel.text=@"Item";
    }
    else if(indexPath.row==1){
        cell.textLabel.text=@"Promo";
    }
    else if(indexPath.row==2){
        cell.textLabel.text=@"Exp";
    }
    else if(indexPath.row==3){
        cell.textLabel.text=@"# of offers";
    }
    //cell
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row==2){
        [item resignFirstResponder];
        [discount resignFirstResponder];
        [self presentSemiModalViewController:datePickerView];
    }
    
    // User *user=[User sharedUser];
    // user.imageNum=[self.mut objectAtIndex:length-indexPath.row-1];
    
    
}

#pragma mark -
#pragma mark Date Picker Delegate

-(void)datePickerSetDate:(TDDatePickerController*)viewController {
	[self dismissSemiModalViewController:datePickerView];
    
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
	selectedDate = viewController.datePicker.date;
    NSString *timeString = [dateFormatter stringFromDate:selectedDate];
    expiration.text=[NSString stringWithFormat:@"%@",timeString];
}

-(void)datePickerClearDate:(TDDatePickerController*)viewController {
	[self dismissSemiModalViewController:datePickerView];
    
	selectedDate = nil;
}

-(void)datePickerCancel:(TDDatePickerController*)viewController {
	[self dismissSemiModalViewController:datePickerView];
}



@end
