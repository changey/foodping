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
#import "ASIHTTPRequest.h"
#import "MenuCell.h"

@interface Menu2ViewController ()

@end

@implementation Menu2ViewController

@synthesize categories, items, prices, categories_i, numbers, numbers_a, names;

-(IBAction) cancel{
    [self dismissModalViewControllerAnimated:YES];
}

/*void UIImageFromURL( NSURL * URL, void (^imageBlock)(UIImage * image), void (^errorBlock)(void) )
{
    dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 ), ^(void)
                   {
                       NSData * data = [[[NSData alloc] initWithContentsOfURL:URL] autorelease];
                       UIImage * image = [[[UIImage alloc] initWithData:data] autorelease];
                       dispatch_async( dispatch_get_main_queue(), ^(void){
                           if( image != nil )
                           {
                               imageBlock( image );
                           } else {
                               errorBlock();
                           }
                       });
                   });
}*/

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    User2 *user=[User2 sharedUser];
    
    NSString *url3 = [NSString stringWithFormat:@"http://api.locu.com/v1_0/menu_item/search/?street_address=300 East Alameda Ave.&api_key=19e8f68708daef4c1a6f686e60259c41c7b7f6bd"];  // server name does not match
    NSString* escapedUrl = [url3 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *URL3 = [NSURL URLWithString:escapedUrl];
    
    // [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[URL host]];
    
    NSURLRequest *request3 = [NSURLRequest requestWithURL:URL3];
    
    NSURLResponse *response3;
    NSError *error3 = nil;
    NSData *data3 = [NSURLConnection sendSynchronousRequest: request3 returningResponse: &response3 error: &error3];
    
    NSString *returnString3 = [[NSString alloc] initWithData:data3 encoding:NSUTF8StringEncoding];
    
   // NSLog(@"the return string: %@", returnString3);
    
    NSDictionary *json3 = [returnString3 JSONValue];
    
    NSArray *objects=[json3 objectForKey:@"objects"];
    
    int length3=[objects count];
    
    NSString *name;
    NSDictionary *obj;
    
    names = [[NSMutableArray alloc] init];
    
    [names removeAllObjects];
    
    for (int i=0;i<10;i++){
        obj=[objects objectAtIndex:i];
        name=[obj objectForKey:@"name"];
        [names addObject:name];
    }
    
   // NSDictionary *obj=[objects objectAtIndex:0];
    
   // NSString *name=[obj objectForKey:@"name"];
    
    NSLog(@"%@", [names objectAtIndex:0]);
    
  //  NSLog(@"%@",mer_name);
    
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
    
   // NSLog(@"the return string: %@", calibrated);
    
    NSDictionary *json = [calibrated JSONValue];
    
    categories = [[NSMutableArray alloc] init];
    
    [categories removeAllObjects];
    
    NSArray *items2 = [json valueForKeyPath:@"data"];
    
    int length = [items2 count];
    
    //[arrayNo2 removeAllObjects];
    
    for (int i=0; i<length;i++){
        NSString *merchant=[[items2 objectAtIndex:i] objectForKey:@"merchant"];
        //  NSLog(@"merchant=%@",merchant);
       // NSLog(@"merchant_section=%@",user.merchant_section);
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
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int length=[names count];
    
    return length;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:SimpleTableIdentifier] autorelease];
    }
    
    //cell.textLabel.text=[items objectAtIndex:[[numbers_a objectAtIndex:indexPath.section] intValue]-[[numbers objectAtIndex:indexPath.section] intValue]+indexPath.row+indexPath.section];
    cell.textLabel.text=[names objectAtIndex:indexPath.row];*/
    
    static NSString *CellIdentifier = @"CustomCell";
	
    MenuCell *cell = (MenuCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MenuCell" owner:self options:nil];
		
		for (id currentObject in topLevelObjects){
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell =  (MenuCell *) currentObject;
				break;
			}
		}
	}
    
    NSString *urlString =@"";
    int num;
    num=indexPath.row+1;
    
    User2 *user=[User2 sharedUser];
    
    urlString = [NSString stringWithFormat:@"%@/images/%d.jpg", user.url,num+1];
    //[self.mut objectAtIndex:num]
    
    // NSString *urlString = [NSString stringWithFormat:@"http://gsuccessprep.com/pfoap/images/58.png"];
    UIImageFromURL( [NSURL URLWithString:urlString], ^( UIImage * image )
                   {
                       cell.imgv.image = image;
                       //NSLog(@"%@",image);
                   }, ^(void){
                       // NSLog(@"%@",@"error!");
                   });
    //cell.imgv.image = [UIImage imageWithData:data];
    if (indexPath.row+1<[names count]){
	  cell.mer_name.text = [NSString stringWithFormat:@"%@",[names objectAtIndex:indexPath.row+1]];
    }
    else{
      cell.mer_name.text = [NSString stringWithFormat:@"%@",[names objectAtIndex:[names count]-1]];
    }
  //  cell.mer_address.text = [NSString stringWithFormat:@"%@", [mer_addresses objectAtIndex:indexPath.row]];
    
    //cell
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    User2 *user =[User2 sharedUser];
    user.item=[names objectAtIndex:indexPath.row+1];
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
