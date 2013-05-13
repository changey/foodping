//
//  FrequentsViewController.m
//  NB_list
//
//  Created by Eric Chang on 10/22/12.
//
//

#import "FrequentsViewController.h"
#import "JSON.h"
#import "User2.h"
#import "ASIHTTPRequest.h"

@interface FrequentsViewController ()

@end

@implementation FrequentsViewController

@synthesize ids, items, discounts;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    User2 *user =[User2 sharedUser];
    
    NSString *url = [NSString stringWithFormat:@"%@/discounts_frequents.php", user.url];  // server name does not match
    NSString *finalString= [url stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    
    NSURL *URL = [NSURL URLWithString:finalString];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
    [request startSynchronous];
    NSError *error = [request error];
    NSString *returnString;
    if (!error) {
        returnString = [request responseString];
        NSLog(@"%@",returnString);
    }
    
    NSString *calibrated = [returnString stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    
   // NSLog(@"the return string: %@", calibrated);
    
    NSDictionary *json = [calibrated JSONValue];
    
    ids = [[NSMutableArray alloc] init];
    items = [[NSMutableArray alloc] init];
    discounts = [[NSMutableArray alloc] init];
    
    [ids removeAllObjects];
    [items removeAllObjects];
    [discounts removeAllObjects];
    
    NSArray *items2 = [json valueForKeyPath:@"data"];
    
    int length = [items2 count];
    
    //[arrayNo2 removeAllObjects];
    
    for (int i=0; i<length;i++){
        NSString *merchant=[[items2 objectAtIndex:i] objectForKey:@"merchant"];
        
        if([merchant isEqualToString:user.merchant_id]){
            
            NSString *ided=[[items2 objectAtIndex:i] objectForKey:@"id"];
            NSString *item=[[items2 objectAtIndex:i] objectForKey:@"item"];
            NSString *discount=[[items2 objectAtIndex:i] objectForKey:@"promotion"];
            
            [ids addObject:[NSString stringWithFormat:@"%@",ided]];
            [items addObject:[NSString stringWithFormat:@"%@",item]];
            [discounts addObject:[NSString stringWithFormat:@"%@",discount]];
            
        }
    }
    
        [tableView reloadData];

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [items count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
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
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:SimpleTableIdentifier] autorelease];
    }
    
    if(indexPath.row==0){
        cell.textLabel.text=@"Item";
        cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",[items objectAtIndex:indexPath.section]];
    }
    else if(indexPath.row==1){
        cell.textLabel.text=@"Promotion";
        cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",[discounts objectAtIndex:indexPath.section]];
    }
    //cell
	
    return cell;
}

-(IBAction)cancel{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self dismissModalViewControllerAnimated:YES];
    
     User2 *user=[User2 sharedUser];
     user.item=[items objectAtIndex:indexPath.section];
     user.promotion=[discounts objectAtIndex:indexPath.section];
    
    
}


@end
