//
//  Customer2ViewController.m
//  NB_list
//
//  Created by Eric Chang on 10/9/12.
//
//

#import "Customer2ViewController.h"
#import "CustomCell.h"
#import "User2.h"
#import "JSON.h"
#import <objc/runtime.h>
#import "ASIHTTPRequest.h"


@interface Customer2ViewController ()

@end

@implementation Customer2ViewController

@synthesize viewdis, mer_names, mer_addresses, mer_ids, label, viewmenu;

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

    [self.navigationController setNavigationBarHidden:NO];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // self.imageView.image = [UIImage imageNamed:@"gold_bg.jpeg"];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

void UIImageFromURL( NSURL * URL, void (^imageBlock)(UIImage * image), void (^errorBlock)(void) )
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
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [mer_names count];
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CustomCell";
	
    CustomCell *cell = (CustomCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
		
		for (id currentObject in topLevelObjects){
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell =  (CustomCell *) currentObject;
				break;
			}
		}
	}
    
    NSString *urlString =@"";
    int num;
    num=indexPath.row+1;
    
    User2 *user=[User2 sharedUser];
    
    urlString = [NSString stringWithFormat:@"%@/images/%d.jpg", user.url,num];
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
	cell.mer_name.text = [NSString stringWithFormat:@"%d. %@",indexPath.row+1, [mer_names objectAtIndex:indexPath.row]];
    cell.mer_address.text = [NSString stringWithFormat:@"%@", [mer_addresses objectAtIndex:indexPath.row]];
    if (indexPath.row==0){
        cell.mer_name.text = [NSString stringWithFormat:@"1. Savory Food Truck"];
        cell.mer_address.text = [NSString stringWithFormat:@"77 Massachusetts Avenue"];
    }
    
	
    return cell;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
//    User2 *user =[User2 sharedUser];
//    if([user.pass isEqualToString:@"1"]){
//        label.text=@"Yes";
//    }
//    
//    [super viewWillAppear:animated];
//    
//   
//    
//    NSString *url = [NSString stringWithFormat:@"%@/merchants_list.php", user.url];  // server name does not match
//    
//    NSURL *URL = [NSURL URLWithString:url];
//    
//   // [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[URL host]];
//    
//    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
//    [request startSynchronous];
//    NSError *error = [request error];
//    NSString *returnString;
//    if (!error) {
//        returnString = [request responseString];
//        NSLog(@"%@",returnString);
//    }
//    
//    NSDictionary *json = [returnString JSONValue];
//    
//    mer_names = [[NSMutableArray alloc] init];
//    mer_addresses = [[NSMutableArray alloc] init];
//    mer_ids = [[NSMutableArray alloc] init];
//
//    
//    NSArray *items = [json valueForKeyPath:@"data"];
//    
//    int length = [items count];
//    
//   // NSLog(@"%d", length);
//    
//    //[arrayNo2 removeAllObjects];
//    
//    for (int i=0; i<length;i++){
//        
//        
//        NSString *mer_name=[[items objectAtIndex:i] objectForKey:@"mer_name"];
//        NSString *mer_address=[[items objectAtIndex:i] objectForKey:@"mer_address"];
//        NSString *mer_id=[[items objectAtIndex:i] objectForKey:@"mer_id"];
//        [mer_names addObject:[NSString stringWithFormat:@"%@",mer_name]];
//        [mer_addresses addObject:[NSString stringWithFormat:@"%@",mer_address]];
//        [mer_ids addObject:[NSString stringWithFormat:@"%@",mer_id]];
//        
//        //   [arrayNo2 addObject:[NSString stringWithFormat:@"%@ %@ %@",first_p, middle_p, last_p]];
//        //NSLog(@"%@", [arrayNo2 objectAtIndex:0]);
//    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    User2 *user = [User2 sharedUser];
    user.merchant_section=[mer_ids objectAtIndex:indexPath.row];
    
    if(self.viewdis == nil) {
        DiscountsViewController *secondxib =
        [[DiscountsViewController alloc] initWithNibName:@"DiscountsViewController" bundle:[NSBundle mainBundle]];
        self.viewdis = secondxib;
        [secondxib release];
    }
    
    [self.navigationController pushViewController:self.viewdis animated:YES];

   // User *user=[User sharedUser];
   // user.imageNum=[self.mut objectAtIndex:length-indexPath.row-1];
    
      
}


@end
