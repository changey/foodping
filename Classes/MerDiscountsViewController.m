//
//  MerDiscountsViewController.m
//  NB_list
//
//  Created by Eric Chang on 10/12/12.
//
//

#import "MerDiscountsViewController.h"
#import "MerDiscountsCell.h"
#import "JSON.h"
#import "User2.h"
#import "ASIHTTPRequest.h"

@interface NSURLRequest (DummyInterface)
//+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;
//+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host;
@end

@implementation MerDiscountsViewController

@synthesize ide, items, discounts, expirations, viewmer;

-(IBAction)newd{
    if(self.viewmer == nil) {
        MerchantViewController *secondxib =
        [[MerchantViewController alloc] initWithNibName:@"MerchantViewController" bundle:[NSBundle mainBundle]];
        self.viewmer = secondxib;
        [secondxib release];
    }
    
    [self presentModalViewController:viewmer animated:YES];
    
   // [self.navigationController pushViewController:self.viewmer animated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    User2 *user=[User2 sharedUser];
    NSLog(@"%@", user.user);
    
   // NSString *urlString = [NSString stringWithFormat:@"https://54.243.144.241/merchant_id.php?user=%@",user.user];
    
    NSString *url = [NSString stringWithFormat:@"%@/merchant_id.php?user=%@",user.url,user.user];  // server name does not match
    NSURL *URL = [NSURL URLWithString:url];
    
   // [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[URL host]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
    [request startSynchronous];
    NSError *error = [request error];
    NSString *returnString;
    if (!error) {
        returnString = [request responseString];
        NSLog(@"%@",returnString);
    }
    
    NSLog(@"the return string: %@", returnString);
    
    user.merchant_id=[NSString stringWithFormat:@"%@", returnString];
    user.merchant_section=[NSString stringWithFormat:@"%@", returnString];
    
   // NSString *urlString2 = [NSString stringWithFormat:@"https://54.243.144.241/discounts_list.php"];
    
    NSString *url2 = [NSString stringWithFormat:@"%@/discounts_list.php", user.url];  // server name does not match
    NSURL *URL2 = [NSURL URLWithString:url2];
    
    
    NSURLRequest *request2 = [NSURLRequest requestWithURL:URL2];
    
    NSURLResponse *response2;
    NSError *error2 = nil;
    NSData *data2 = [NSURLConnection sendSynchronousRequest: request2 returningResponse: &response2 error: &error2];
    
   // NSData *data2 = [NSData dataWithContentsOfURL:[NSURL URLWithString: urlString2]];
    NSString *returnString2 = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
    NSString *calibrated2 = [returnString2 stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    
    NSLog(@"the return string: %@", calibrated2);
    
    NSDictionary *json = [calibrated2 JSONValue];
    
    ide = [[NSMutableArray alloc] init];
    items = [[NSMutableArray alloc] init];
    discounts = [[NSMutableArray alloc] init];
    expirations = [[NSMutableArray alloc] init];
    
    [ide removeAllObjects];
    [items removeAllObjects];
    [discounts removeAllObjects];
    [expirations removeAllObjects];
    
    NSArray *items2 = [json valueForKeyPath:@"data"];
    
    int length = [items2 count];
    
    for (int i=0; i<length;i++){
        NSString *merchant=[[items2 objectAtIndex:i] objectForKey:@"merchant"];
        
        if([merchant isEqualToString:user.merchant_id]){
            
            NSString *ided=[[items2 objectAtIndex:i] objectForKey:@"id"];
            NSString *item=[[items2 objectAtIndex:i] objectForKey:@"item"];
            NSString *discount=[[items2 objectAtIndex:i] objectForKey:@"discount"];
            NSString *expiration=[[items2 objectAtIndex:i] objectForKey:@"expiration"];
            
            [ide addObject:[NSString stringWithFormat:@"%@",ided]];
            [items addObject:[NSString stringWithFormat:@"%@",item]];
            [discounts addObject:[NSString stringWithFormat:@"%@",discount]];
            [expirations addObject:[NSString stringWithFormat:@"%@",expiration]];
            
        }
        
        [tableView reloadData];
        // NSLog(@"%@", first_p);
        
        //   [arrayNo2 addObject:[NSString stringWithFormat:@"%@ %@ %@",first_p, middle_p, last_p]];
        //NSLog(@"%@", [arrayNo2 objectAtIndex:0]);
    }
    
}

- (void)viewDidLoad
{
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(Edit:)];
	[self.navigationItem setRightBarButtonItem:addButton];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // self.imageView.image = [UIImage imageNamed:@"gold_bg.jpeg"];
}

-(void)viewDidAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (IBAction) Edit:(id)sender{
	if(self.editing)
	{
		[super setEditing:NO animated:NO];
		[tableView setEditing:NO animated:NO];
		[tableView reloadData];
		[self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
		[self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStylePlain];
	}
	else
	{
		[super setEditing:YES animated:YES];
		[tableView setEditing:YES animated:YES];
		[tableView reloadData];
		[self.navigationItem.rightBarButtonItem setTitle:@"Done"];
		[self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStyleDone];
	}
}

- (IBAction)DeleteButtonAction:(id)sender{
    
	[items removeLastObject];
    [discounts removeLastObject];
    [expirations removeLastObject];
	[tableView reloadData];
}

- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
	
    
	if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSString *first=[ide objectAtIndex:indexPath.row];
        
        User2 *user=[User2 sharedUser];
        NSString *url = [NSString stringWithFormat:@"%@/discounts_delete.php?id=%@", user.url, first];  // server name does not match
        NSURL *URL = [NSURL URLWithString:url];
        
        
        NSLog(@"%@", first);
        
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        NSURLResponse *response;
        NSError *error = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest: request returningResponse: &response error: &error];
        
        //NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString: urlString]];
        NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *calibrated = [returnString stringByReplacingOccurrencesOfString:@"_" withString:@" "];
        NSString *item=[items objectAtIndex:indexPath.row];
        NSString *discount=[discounts objectAtIndex:indexPath.row];
        NSString *message=[NSString stringWithFormat:@"%@ was sold out, sorry!", item];
        
      //  [PFPush sendPushMessageToChannelInBackground:@"" withMessage:message];
        
       // NSLog(@"the return string: %@", calibrated);
        
        [ide removeObjectAtIndex:indexPath.row];
        [items removeObjectAtIndex:indexPath.row];
        [discounts removeObjectAtIndex:indexPath.row];
        [expirations removeObjectAtIndex:indexPath.row];
		[tableView reloadData];
    } /*else if (editingStyle == UITableViewCellEditingStyleInsert) {
        [items insertObject:@"SaturDay" atIndex:[dataList count]];
		[tableView reloadData];
    }*/
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
    return [items count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"MerDiscountCell";
	
    MerDiscountsCell *cell = (MerDiscountsCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MerDiscountsCell" owner:self options:nil];
		
		for (id currentObject in topLevelObjects){
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell =  (MerDiscountsCell *) currentObject;
				break;
			}
		}
	}
    
    /*  static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
     UITableViewCell *cell = [tableView
     dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
     if (cell == nil) {
     cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle
     reuseIdentifier:SimpleTableIdentifier] autorelease];
     }*/
    
    
    
    //NSString *urlString =@"";
    int num;
    //  num=length-indexPath.row-1;
    // urlString = [NSString stringWithFormat:@"http://gsuccessprep.com/pfoap/images/%@.png",  [self.mut objectAtIndex:num]];
    //[self.mut objectAtIndex:num]
    
    // NSString *urlString = [NSString stringWithFormat:@"http://gsuccessprep.com/pfoap/images/58.png"];
    /*  UIImageFromURL( [NSURL URLWithString:urlString], ^( UIImage * image )
     {
     cell.imgv.image = image;
     //NSLog(@"%@",image);
     }, ^(void){
     // NSLog(@"%@",@"error!");
     });*/
    //cell.imgv.image = [UIImage imageWithData:data];
	//cell.capitalLabel.text = [NSString stringWithFormat:@"%d. Food Truck",indexPath.row+1];
	
    //cell.backgroundColor = [UIColor clearColor];
    cell.item.text=[NSString stringWithFormat:@"Buy %@ get %@",[items objectAtIndex:indexPath.row], [discounts objectAtIndex:indexPath.row]];
    cell.expiration.text=[NSString stringWithFormat:@"Expired: %@",[expirations objectAtIndex:indexPath.row]];
    
    /* cell.textLabel.text=[NSString stringWithFormat:@"Buy %@ get %@",[items objectAtIndex:indexPath.row], [discounts objectAtIndex:indexPath.row]];
     cell.detailTextLabel.text=[NSString stringWithFormat:@"Expired: %@",[expirations objectAtIndex:indexPath.row]];*/
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    // User *user=[User sharedUser];
    // user.imageNum=[self.mut objectAtIndex:length-indexPath.row-1];
    
    
}

@end
