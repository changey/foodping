//
//  RootViewController.m
//  NavApp
//
//  Created by Eric Chang on 10/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "JSON.h"
#import "User2.h"
#import "Parse/Parse.h"
#import "ASIHTTPRequest.h"
#import <SinglySDK/SinglySDK.h>

@interface NSURLRequest (DummyInterface)
//+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;
//+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host;



@end

@implementation RootViewController


//@synthesize viewsecond;
//json
@synthesize sendButton;
@synthesize messageTextView;
@synthesize responseTextView;
@synthesize receivedData,responseData,user,pass,received;
@synthesize viewcus, viewmer, merchant_id, viewsign, imageView, welcomePhotos, viewmerdis, fbGraph, responseString;

-(IBAction)gconnect{
    SinglyService *service=[SinglyService serviceWithIdentifier:@"google"];
    service.delegate=self;
    [service requestAuthorizationWithViewController:self];
   
}

-(IBAction)fbconnect{
    
   /* if(self.viewcus == nil) {
        Customer2ViewController *secondxib =
        [[Customer2ViewController alloc] initWithNibName:@"Customer2ViewController" bundle:[NSBundle mainBundle]];
        self.viewcus = secondxib;
        [secondxib release];
    }
    
    [self.navigationController pushViewController:self.viewcus animated:YES];*/
    
    SinglyService *service=[SinglyService serviceWithIdentifier:@"facebook"];
    service.delegate=self;
    [service requestAuthorizationWithViewController:self];
    
    
    /*Facebook Application ID*/
	/*NSString *client_id = @"303431939770587";
	
	//alloc and initalize our FbGraph instance
	self.fbGraph = [[FbGraph alloc] initWithFbClientID:client_id];
	
	//begin the authentication process.....
	[fbGraph authenticateUserWithCallbackObject:self andSelector:@selector(fbGraphCallback:)
						 andExtendedPermissions:@"user_photos,user_videos,publish_stream,offline_access,user_checkins,friends_checkins"];*/
	
	/**
	 * OR you may wish to 'anchor' the login UIWebView to a window not at the root of your application...
	 * for example you may wish it to render/display inside a UITabBar view....
	 *
	 * Feel free to try both methods here, simply (un)comment out the appropriate one.....
	 **/
	//	[fbGraph authenticateUserWithCallbackObject:self andSelector:@selector(fbGraphCallback:) andExtendedPermissions:@"user_photos,user_videos,publish_stream,offline_access" andSuperView:self.view];
}

- (void)singlyServiceDidAuthorize:(SinglyService *)service
{
    User2 *user =[User2 sharedUser];
    user.user=@"";
    user.pass=@"";
    user.pass=@"1";
    
    user.url=@"https://54.243.144.241";
    if(self.viewcus == nil) {
        Customer2ViewController *secondxib =
        [[Customer2ViewController alloc] initWithNibName:@"Customer2ViewController" bundle:[NSBundle mainBundle]];
        self.viewcus = secondxib;
        [secondxib release];
    }
    
    [self.navigationController pushViewController:self.viewcus animated:YES];
    NSLog(@"Authorized with %@", service.serviceIdentifier);
}

- (void)singlyServiceDidFail:(SinglyService *)service withError:(NSError *)error
{
    NSLog(@"Failed to authorize service %@", service.serviceIdentifier);
    NSLog(@"Error: %@", error);
}

#pragma mark -
#pragma mark FbGraph Callback Function
/**
 * This function is called by FbGraph after it's finished the authentication process
 **/
- (void)fbGraphCallback:(id)sender {
	
	if ( (fbGraph.accessToken == nil) || ([fbGraph.accessToken length] == 0) ) {
		
		NSLog(@"You pressed the 'cancel' or 'Dont Allow' button, you are NOT logged into Facebook...I require you to be logged in & approve access before you can do anything useful....");
		
		//restart the authentication process.....
		[fbGraph authenticateUserWithCallbackObject:self andSelector:@selector(fbGraphCallback:)
							 andExtendedPermissions:@"user_photos,user_videos,publish_stream,offline_access,user_checkins,friends_checkins"];
		
	} else {
		//pop a message letting them know most of the info will be dumped in the log
		/*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Note" message:@"For the simplest code, I've written all output to the 'Debugger Console'." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];*/
        
        User2 *user =[User2 sharedUser];
        user.user=@"";
        user.pass=@"";
        user.pass=@"1";
        
        user.url=@"https://54.243.144.241";
		
		if(self.viewcus == nil) {
            Customer2ViewController *secondxib =
            [[Customer2ViewController alloc] initWithNibName:@"Customer2ViewController" bundle:[NSBundle mainBundle]];
            self.viewcus = secondxib;
            [secondxib release];
        }
        
        [self.navigationController pushViewController:self.viewcus animated:YES];
		
	}
	
}

-(IBAction)signup{
    NSString *user2=user.text;
    NSString *pass2=pass.text;
    
    User2 *user=[User2 sharedUser];
    
    user.url=@"https://54.243.144.241";
    
    NSString *url = [NSString stringWithFormat:@"%@/post_signup.php?user=%@&pass=%@",user.url, user2,pass2];  // server name does not match
    
    NSLog(@"%@", url);
    
    NSURL *URL = [NSURL URLWithString:url];
    
    //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[URL host]];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
    [request startSynchronous];
    NSError *error = [request error];
    NSString *returnString;
    if (!error) {
        returnString = [request responseString];
        NSLog(@"%@",returnString);
    }
    
    NSLog(@"the return string: %@", returnString);
    
    user.user=user2;
    user.pass=pass2;
    
    if([returnString isEqualToString:@"0"]){
        //    if([user2 isEqualToString:@"Wei.God"]){
        
        UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Error" message:@"That username already exists"
                                                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertsuccess show];
        [alertsuccess release];
    }
    else if([returnString isEqualToString:@"1"]){
        //   else if([user2 isEqualToString:@"Wei.God2"]){
        
        if(self.viewcus == nil) {
            Customer2ViewController *secondxib =
            [[Customer2ViewController alloc] initWithNibName:@"Customer2ViewController" bundle:[NSBundle mainBundle]];
            self.viewcus = secondxib;
            [secondxib release];
        }
        
        [self.navigationController pushViewController:self.viewcus animated:YES];
    }
    else{
        UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Error" message:@"That username already exists"
                                                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertsuccess show];
        [alertsuccess release];
    }


}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString *user2=user.text;
    NSString *pass2=pass.text;
    
    [pass resignFirstResponder];
    User2 *user=[User2 sharedUser];
    
    
   // NSString *urlString = [NSString stringWithFormat:@"https://54.243.144.241/rnlogin2.php?user=%@&pass=%@",user2,pass2];
    user.url=@"https://54.243.144.241";
    
    NSString *url = [NSString stringWithFormat:@"%@/rnlogin2.php?user=%@&pass=%@",user.url,user2,pass2];  // server name does not match
    NSURL *URL = [NSURL URLWithString:url];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
    [request startSynchronous];
    NSError *error = [request error];
    NSString *returnString;
    if (!error) {
        returnString = [request responseString];
        NSLog(@"%@",returnString);
    }
    
   // [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[URL host]];
    
  /*  NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLResponse *response;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest: request returningResponse: &response error: &error];
    
    //NSString *urlString = [NSString stringWithFormat:@"http://gsuccessprep.com/pa12/rnlogin2.php?user=%@&pass=%@",user2,pass2];
    //http://107.21.202.8/
   // NSLog(@"%@", urlString);
   
   // NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString: urlString]];
    NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"the return string: %@", returnString);*/
    
    
    user.user=user2;
    user.pass=pass2;
    
    if([returnString isEqualToString:@"0"]){
    //        if([user2 isEqualToString:@"test"]){
        
        if(self.viewcus == nil) {
            Customer2ViewController *secondxib =
            [[Customer2ViewController alloc] initWithNibName:@"Customer2ViewController" bundle:[NSBundle mainBundle]];
            self.viewcus = secondxib;
            [secondxib release];
        }
        
        [self.navigationController pushViewController:self.viewcus animated:YES];
    }
    else if([returnString isEqualToString:@"1"]){
    //       else if([user2 isEqualToString:@"test2"]){
        
        if(self.viewmerdis == nil) {
            MerDiscountsViewController *secondxib =
            [[MerDiscountsViewController alloc] initWithNibName:@"MerDiscountsViewController" bundle:[NSBundle mainBundle]];
            self.viewmerdis = secondxib;
            [secondxib release];
        }
        
        [self.navigationController pushViewController:self.viewmerdis animated:YES];
        
       /* if(self.viewmer == nil) {
            MerchantViewController *secondxib =
            [[MerchantViewController alloc] initWithNibName:@"MerchantViewController" bundle:[NSBundle mainBundle]];
            self.viewmer = secondxib;
            [secondxib release];
        }
        
        [self.navigationController pushViewController:self.viewmer animated:YES];*/
    }
    else{
        UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Username/Password invalid"
                                                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertsuccess show];
        [alertsuccess release];
    }
    return NO;
}

-(IBAction)signin{
    NSString *user2=user.text;
    NSString *pass2=pass.text;
    
    [pass resignFirstResponder];
    User2 *user=[User2 sharedUser];
    
    
    // NSString *urlString = [NSString stringWithFormat:@"https://54.243.144.241/rnlogin2.php?user=%@&pass=%@",user2,pass2];
   // user.url=@"http://107.22.99.26";
    user.url=@"https://54.243.144.241";
    
    NSString *url = [NSString stringWithFormat:@"%@/rnlogin2.php?user=%@&pass=%@",user.url,user2,pass2];  // server name does not match
    
    
    NSURL *URL = [NSURL URLWithString:url];
    
  //  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
   // request = [ASIHTTPRequest requestWithURL:URL];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
    [request startSynchronous];
    NSError *error = [request error];
    NSString *response;
    if (!error) {
        response = [request responseString];
        NSLog(@"%@",response);
    }
    
    user.user=user2;
    user.pass=pass2;
    
    if([response isEqualToString:@"0"]){
        //        if([user2 isEqualToString:@"test"]){
        
        if(self.viewcus == nil) {
            Customer2ViewController *secondxib =
            [[Customer2ViewController alloc] initWithNibName:@"Customer2ViewController" bundle:[NSBundle mainBundle]];
            self.viewcus = secondxib;
            [secondxib release];
        }
        
        [self.navigationController pushViewController:self.viewcus animated:YES];
    }
    else if([response isEqualToString:@"1"]){
        //       else if([user2 isEqualToString:@"test2"]){
        
        if(self.viewmerdis == nil) {
            MerDiscountsViewController *secondxib =
            [[MerDiscountsViewController alloc] initWithNibName:@"MerDiscountsViewController" bundle:[NSBundle mainBundle]];
            self.viewmerdis = secondxib;
            [secondxib release];
        }
        
        [self.navigationController pushViewController:self.viewmerdis animated:YES];
        
    }
    else{
        UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Username/Password invalid"
                                                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertsuccess show];
        [alertsuccess release];
    }
  /*  [request setRequest:[ASIHTTPRequest requestWithURL:URL]];
    
    // Start the request
	[request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        NSLog(@"%@",response);
    }
    NSString *responseString = [request responseString];
    NSLog(@"%@",responseString);*/
  /*  [request setCompletionBlock:^{
        // Use when fetching text data
        responseString = [request responseString];
        NSLog(@"%@",responseString);
        
  
    }];*/
    
    
   // [request startAsynchronous];

    
 //   NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
  /*  NSURLResponse *response;
    //NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest: request returningResponse: &response error: &error];
    
    // NSLog(@"%@", urlString);
    
    // NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString: urlString]];
    NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"the return string: %@", returnString);
    
    
    user.user=user2;
    user.pass=pass2;
    
    if([returnString isEqualToString:@"0"]){
        //        if([user2 isEqualToString:@"test"]){
        
        if(self.viewcus == nil) {
            Customer2ViewController *secondxib =
            [[Customer2ViewController alloc] initWithNibName:@"Customer2ViewController" bundle:[NSBundle mainBundle]];
            self.viewcus = secondxib;
            [secondxib release];
        }
        
        [self.navigationController pushViewController:self.viewcus animated:YES];
    }
    else if([returnString isEqualToString:@"1"]){
        //       else if([user2 isEqualToString:@"test2"]){
        
        if(self.viewmerdis == nil) {
            MerDiscountsViewController *secondxib =
            [[MerDiscountsViewController alloc] initWithNibName:@"MerDiscountsViewController" bundle:[NSBundle mainBundle]];
            self.viewmerdis = secondxib;
            [secondxib release];
        }
        
        [self.navigationController pushViewController:self.viewmerdis animated:YES];
        
        }
    else{
        UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Username/Password invalid"
                                                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertsuccess show];
        [alertsuccess release];
    }*/
    //return NO;
}

-(IBAction)connect
{
    
    
    NSString *user2=user.text;
    NSString *pass2=pass.text;
    
   /* NSString *urlString = [NSString stringWithFormat:@"%@",@"https://gsuccessprep.com/cb_rest_api/authenticate_user"];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    //  parameter username
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"username\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[user2 dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //  parameter username
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"password\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[pass2 dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // now lets make the connection to the web
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    //  NSLog(@"%@", returnString);
    
    NSString *finalString = [returnString stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    //NSLog(@"%s - receviedDataAsString: %@", __FUNCTION__, finalString);
    NSString *cut=[finalString substringWithRange:NSMakeRange(1, finalString.length-2)];
    // NSLog(@"%s - receviedDataAsString: %@", __FUNCTION__, cut);
    NSString *added=[NSString stringWithFormat:@"{ \"data\": {%@} }", cut];
  //  NSLog(@"%s - receviedDataAsString: %@", __FUNCTION__, added);
    
    // if(mode==0){
    
    NSDictionary *json = [added JSONValue];
    
    int auth=0;
    NSDictionary *item = [json valueForKeyPath:@"data"];
    NSArray *groups = [item valueForKeyPath:@"groups"];
    NSArray *person_orgs = [item valueForKeyPath:@"info"];
    int length_info=[person_orgs count];
    
    
    User2 *user3=[User2 sharedUser];
    user3.org_names=[[NSMutableArray alloc]init];
    for(int i=0; i<length_info;i++){
        [user3.org_names addObject:[[person_orgs objectAtIndex:i] valueForKeyPath:@"org_name"]];
    }
    
    //  NSLog(@"%@", [item objectAtIndex:0]);
    //BOOL isTheObjectThere = [myArray containsObject: @"my string"];
    
    if ([groups containsObject:@"coordinator"]==true){
        auth=1;
    }
    else if ([groups containsObject:@"physician"]==true){
        auth=2;
    }
    else{
        auth=1;
    }*/
    
    int auth=0;
    
    if(auth!=1){
                  
    }
  //  NSString *urlString = [NSString stringWithFormat:@"http://gsuccessprep.com/pa12/rnlogin2.php?user=%@&pass=%@",user2,pass2];
    NSString *urlString = [NSString stringWithFormat:@"http://gsuccessprep.com/pa12/rnlogin2.php?user=%@&pass=%@",user2,pass2];
    //http://107.21.202.8/
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString: urlString]];
    NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"the return string: %@", returnString);
    
    User2 *user=[User2 sharedUser];
    user.user=user2;
    user.pass=pass2;
   
    if([returnString isEqualToString:@"0"]){
  //    if([user2 isEqualToString:@"Wei.God"]){
        
        if(self.viewcus == nil) {
            Customer2ViewController *secondxib =
            [[Customer2ViewController alloc] initWithNibName:@"Customer2ViewController" bundle:[NSBundle mainBundle]];
            self.viewcus = secondxib;
            [secondxib release];
        }
        
        [self.navigationController pushViewController:self.viewcus animated:YES];
        }
    else if([returnString isEqualToString:@"1"]){
   //   else if([user2 isEqualToString:@"Wei.God2"]){
        
       /* if(self.viewmerdis == nil) {
            MerDiscountsViewController *secondxib =
            [[MerDiscountsViewController alloc] initWithNibName:@"MerDiscountsViewController" bundle:[NSBundle mainBundle]];
            self.viewmerdis = secondxib;
            [secondxib release];
        }
        
        [self.navigationController pushViewController:self.viewmerdis animated:YES];*/
        
        /*if(self.viewmer == nil) {
            MerchantViewController *secondxib =
            [[MerchantViewController alloc] initWithNibName:@"MerchantViewController" bundle:[NSBundle mainBundle]];
            self.viewmer = secondxib;
            [secondxib release];
        }
        
        [self.navigationController pushViewController:self.viewmer animated:YES];*/
    }
    else{
        UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Username/Password invalid"
                                                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertsuccess show];
        [alertsuccess release];
    }
    //}
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}


- (void)viewDidLoad
{
    
    user.text=@"test2";
    pass.text=@"1";
    [self.navigationController setNavigationBarHidden:YES];
    pass.returnKeyType = UIReturnKeyGo;
    
    self.welcomePhotos = [NSArray arrayWithObjects:@"boston3.png",@"charles3.png", @"mass3.png", nil];
    self.imageView.image = [UIImage imageNamed:[self.welcomePhotos objectAtIndex:0]];
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(transitionPhotos) userInfo:nil repeats:YES];
    
    
    /*imageView.animationImages = [NSArray arrayWithObjects:
                                 [UIImage imageNamed:@"boston3.png"],
                                 [UIImage imageNamed:@"charles3.png"],
                                 [UIImage imageNamed:@"mass3.png"], nil];
    imageView.animationDuration = 7.00; //1 second
    imageView.animationRepeatCount = 0; //infinite
    
    [imageView startAnimating]; //start the animation*/
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)transitionPhotos{
    
    if (photoCount < [self.welcomePhotos count] - 1){
        photoCount ++;
    }else{
        photoCount = 0;
    }
    [UIView transitionWithView:self.imageView
                      duration:2.0
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{ self.imageView.image = [UIImage imageNamed:[self.welcomePhotos objectAtIndex:photoCount]]; }
                    completion:NULL];    
}

#pragma mark -
#pragma mark NSURLConnection Callbacks
// Connection response.

- (void) connection:(NSURLConnection *)connection
didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
    if ([challenge previousFailureCount] > 0) {
        // Do something, like prompt for credentials or cancel the connection
    } else {
        NSURLCredential *creds = [NSURLCredential
                                  credentialWithUser:@"someUser"
                                  password:@"somePassword"
                                  persistence:NSURLCredentialPersistenceForSession];
        
        [[challenge sender]  useCredential:creds forAuthenticationChallenge:challenge];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{
    NSLog(@"%s - Response Code: %d\n", __FUNCTION__, [(NSHTTPURLResponse *)response statusCode]);
    NSLog(@"%s - Content-Type: %@\n",  __FUNCTION__, [[(NSHTTPURLResponse *)response allHeaderFields] objectForKey:@"Content-Type"]);
    // Clear the NSMutableData receivedData.
    [receivedData setLength:0];
}
// You got data.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
    NSLog(@"%s", __FUNCTION__);
    // Append the data to our NSMutableData receivedData.
    [receivedData appendData:data];
}
// Sorry Dude, connection failed gloriously.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{
    NSLog(@"%s", __FUNCTION__);
    
    // Create noxious error message.
    NSString *errorMessage = [[NSString alloc]initWithFormat: @"Connection failed! Error - %@ (URL: %@)", [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]];
    // Throw up a noxious error message.
    UIAlertView *alert = [[UIAlertView alloc] 
                          initWithTitle:@"Sorry!"
                          message:errorMessage 
                          delegate:self
                          cancelButtonTitle:@"Close"
                          otherButtonTitles:nil];
    [alert show];
    // Clean up
    [connection release];
    self.receivedData = nil; 
    [alert release];
    [errorMessage release];
}
// Finally the data is completely loaded.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"%s", __FUNCTION__);
    // Encode received data to NSUTF8StringEncoding
    NSString *receviedDataAsString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"%s - receviedDataAsString: %@", __FUNCTION__, receviedDataAsString);
    // Show received data in the responseTextView.
    responseTextView.text = receviedDataAsString;
    received=receviedDataAsString;
    
    NSLog(@"%@",receviedDataAsString);
    // receviedDataAsString=@"lala";
    if(receviedDataAsString==@" yes"){
        NSLog(@"lala");
    };
    // Clean up.
    [receviedDataAsString release];
    [connection release];
    self.receivedData = nil;
}


#pragma mark -
#pragma mark Rotation support

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    
}


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}


#pragma mark -
#pragma mark Memory management

/*
 - (void)didReceiveMemoryWarning {
 // Releases the view if it doesn't have a superview.
 [super didReceiveMemoryWarning];
 
 // Release any cached data, images, etc that aren't in use.
 }
 */

- (void)dealloc {
    
    
    [super dealloc];
}

@end
