//
//  MenuViewController.m
//  NB_list
//
//  Created by Eric Chang on 10/24/12.
//
//

#import "MenuViewController.h"
#import "JSON.h"
#import "User2.h"
#import "ASIHTTPRequest.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

@synthesize categories, viewmenu, items, prices, categories_i, numbers, numbers_a;

-(IBAction) cancel{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    User2 *user=[User2 sharedUser];
    
  // @"http://api.locu.com/v1_0/menu_item/search/?street_address=300%20East%20Alameda%20Ave.&api_key=19e8f68708daef4c1a6f686e60259c41c7b7f6bd"
   /* NSString *url3 = [NSString stringWithFormat:@"http://api.locu.com/v1_0/menu_item/search/?street_address=300 East Alameda Ave.&api_key=19e8f68708daef4c1a6f686e60259c41c7b7f6bd"];  // server name does not match
    NSURL *URL3 = [NSURL URLWithString:url3];
    
    ASIHTTPRequest *request3 = [ASIHTTPRequest requestWithURL:URL3];
    [request3 startSynchronous];
    NSError *error3 = [request3 error];
    NSString *returnString3;
    if (!error3) {
        returnString3 = [request3 responseString];
        NSLog(@"%@",returnString3);
    }
    
    NSString *calibrated3 = [returnString3 stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    
    NSLog(@"the return string: %@", calibrated3);*/
    
    NSString *url = [NSString stringWithFormat:@"%@/menus_cat.php",user.url];  // server name does not match
    NSURL *URL = [NSURL URLWithString:url];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
    [request startSynchronous];
    NSError *error = [request error];
    NSString *returnString;
    if (!error) {
        returnString = [request responseString];
   //     NSLog(@"%@",returnString);
    }
    
    NSString *calibrated = [returnString stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    
 //    NSLog(@"the return string: %@", calibrated);
    
    NSDictionary *json = [calibrated JSONValue];
    
   categories = [[NSMutableArray alloc] init];
    
   [categories removeAllObjects];
    
    NSArray *items2 = [json valueForKeyPath:@"data"];
    
    int length = [items2 count];
    
    //[arrayNo2 removeAllObjects];
    
    for (int i=0; i<length;i++){
        NSString *merchant=[[items2 objectAtIndex:i] objectForKey:@"merchant"];
        //  NSLog(@"merchant=%@",merchant);
        //  NSLog(@"merchant_section=%@",user.merchant_section);
        NSString *section=[NSString stringWithFormat:@"%@", user.merchant_section];
       // if([merchant isEqualToString:section]){
        if([merchant isEqualToString:section]){
            
            NSString *category=[[items2 objectAtIndex:i] objectForKey:@"category"];
       
            [categories addObject:[NSString stringWithFormat:@"%@",category]];

            
        //    NSLog(@"item=%@", item);
        }
        
        [tableView reloadData];

    }
    
    NSString *url2 = [NSString stringWithFormat:@"%@/menus_detail.php",user.url];  // server name does not match
    NSURL *URL2 = [NSURL URLWithString:url2];
    
    //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[URL2 host]];
    
    ASIHTTPRequest *request2 = [ASIHTTPRequest requestWithURL:URL2];
    [request2 startSynchronous];
    NSError *error2 = [request2 error];
    NSString *returnString2;
    if (!error) {
        returnString2 = [request2 responseString];
    //    NSLog(@"%@",returnString2);
    }
    
    NSString *calibrated2 = [returnString2 stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    
   // NSLog(@"the return string: %@", calibrated2);
    
    NSDictionary *json2 = [calibrated2 JSONValue];
    
    items = [[NSMutableArray alloc] init];
    prices = [[NSMutableArray alloc] init];
    categories_i = [[NSMutableArray alloc] init];
    
    [items removeAllObjects];
    [prices removeAllObjects];
    [categories_i removeAllObjects];
    
    NSArray *items3 = [json2 valueForKeyPath:@"data"];
    
    int length2 = [items3 count];
    
    //[arrayNo2 removeAllObjects];
    
    for (int i=0; i<length2;i++){
        NSString *merchant=[[items3 objectAtIndex:i] objectForKey:@"merchant"];
        //  NSLog(@"merchant=%@",merchant);
        //  NSLog(@"merchant_section=%@",user.merchant_section);
        NSString *section=[NSString stringWithFormat:@"%@", user.merchant_section];

    
        // if([merchant isEqualToString:section]){
        if([merchant isEqualToString:section]){
            
            NSString *item=[[items3 objectAtIndex:i] objectForKey:@"item"];
            NSString *price=[[items3 objectAtIndex:i] objectForKey:@"price"];
            NSString *category_i=[[items3 objectAtIndex:i] objectForKey:@"category"];
            
            [items addObject:[NSString stringWithFormat:@"%@",item]];
            [prices addObject:[NSString stringWithFormat:@"%@",price]];
            [categories_i addObject:[NSString stringWithFormat:@"%@",category_i]];
            
            
            //    NSLog(@"item=%@", item);
        }
        //NSLog(@"%@", [items objectAtIndex:0]);
        
        [tableView reloadData];
        
    }
    
    numbers = [[NSMutableArray alloc] init];
    numbers_a = [[NSMutableArray alloc] init];
    [numbers removeAllObjects];
    [numbers_a removeAllObjects];
    
    int j=1;
    int k=0;
    int m=0;
    for (int i=0; i<length2;i++){
        if ([[categories_i objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"%d", j]]){
            k++;
            m++;
        }
        else{
            [numbers addObject:[NSString stringWithFormat:@"%d", k]];
            [numbers_a addObject:[NSString stringWithFormat:@"%d", m]];
            k=1;
            j++;
        }
    }
    [numbers addObject:[NSString stringWithFormat:@"%d", k]];
    [numbers_a addObject:[NSString stringWithFormat:@"%d", m]];
    //NSLog(@"%d", [[numbers objectAtIndex:1] intValue]);
    
    [tableView reloadData];
    
    l=0;
    
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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table view methods

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    int length=[categories count];
    for (int i=0;i<length;i++){
      if (section==i){
          return [categories objectAtIndex:section];
      }
    }
 // return titleForHeader;
 }

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [categories count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int length=[numbers count];

      for (int i=0;i<length;i++){
          if (section==i){
              return [[numbers objectAtIndex:section] intValue];
          }
      }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:SimpleTableIdentifier] autorelease];
    }

    cell.textLabel.text=[items objectAtIndex:[[numbers_a objectAtIndex:indexPath.section] intValue]-[[numbers objectAtIndex:indexPath.section] intValue]+indexPath.row+indexPath.section];
        
    //cell
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    User2 *user =[User2 sharedUser];
    user.item=[NSString stringWithFormat:@"a/an %@",[items objectAtIndex:[[numbers_a objectAtIndex:indexPath.section] intValue]-[[numbers objectAtIndex:indexPath.section] intValue]+indexPath.row+indexPath.section]];
    [self dismissModalViewControllerAnimated:YES];
    
    if(self.viewmenu == nil) {
        MenuDetailViewController *secondxib =
        [[MenuDetailViewController alloc] initWithNibName:@"MenuDetailViewController" bundle:[NSBundle mainBundle]];
        self.viewmenu = secondxib;
        [secondxib release];
    }

    [self.navigationController pushViewController:self.viewmenu animated:YES];

   // [self presentModalViewController:viewmenu animated:YES];
    
    
    
    
    
}

@end
