//
//  Menu2ViewController.m
//  NB_list
//
//  Created by Eric Chang on 11/9/12.
//
//

#import "Menu2ViewController.h"
#import "JSON.h"
#import "User2.h"

@interface Menu2ViewController ()

@end

@implementation Menu2ViewController

@synthesize categories, items, prices, categories_i, numbers, numbers_a;

-(IBAction) cancel{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    User2 *user=[User2 sharedUser];
    
    NSString *url = [NSString stringWithFormat:@"%@/menus_cat.php",user.url];  // server name does not match
    NSURL *URL = [NSURL URLWithString:url];
    
    //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[URL host]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLResponse *response;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest: request returningResponse: &response error: &error];
    
    
    // NSString *urlString = [NSString stringWithFormat:@"http://gsuccessprep.com/pa12/menus_cat.php"];
    //NSString *urlString = [NSString stringWithFormat:@"http://107.21.202.8/discounts_list.php"];
    
    //NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString: urlString]];
    NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *calibrated = [returnString stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    
    NSLog(@"the return string: %@", calibrated);
    
    NSDictionary *json = [calibrated JSONValue];
    
    categories = [[NSMutableArray alloc] init];
    
    [categories removeAllObjects];
    
    NSArray *items2 = [json valueForKeyPath:@"data"];
    
    int length = [items2 count];
    
    //[arrayNo2 removeAllObjects];
    
    for (int i=0; i<length;i++){
        NSString *merchant=[[items2 objectAtIndex:i] objectForKey:@"merchant"];
        //  NSLog(@"merchant=%@",merchant);
        NSLog(@"merchant_section=%@",user.merchant_section);
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
    
    NSURLRequest *request2 = [NSURLRequest requestWithURL:URL2];
    
    NSURLResponse *response2;
    NSError *error2 = nil;
    NSData *data2 = [NSURLConnection sendSynchronousRequest: request2 returningResponse: &response2 error: &error2];
    
    NSString *returnString2 = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
    NSString *calibrated2 = [returnString2 stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    
    NSLog(@"the return string: %@", calibrated2);
    
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
    
   /* if(self.viewmenu == nil) {
        MenuDetailViewController *secondxib =
        [[MenuDetailViewController alloc] initWithNibName:@"MenuDetailViewController" bundle:[NSBundle mainBundle]];
        self.viewmenu = secondxib;
        [secondxib release];
    }
    
    [self.navigationController pushViewController:self.viewmenu animated:YES];*/
    
    // [self presentModalViewController:viewmenu animated:YES];
    
    
    
    
    
}

@end
