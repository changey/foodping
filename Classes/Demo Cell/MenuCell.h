//
//  MenuCell.h
//  NB_list
//
//  Created by Eric Chang on 11/18/12.
//
//

#import <UIKit/UIKit.h>

@interface MenuCell : UITableViewCell{
    IBOutlet UIImageView *imgv;
    IBOutlet UILabel *mer_name;
    IBOutlet UILabel *mer_address;
    
    IBOutlet UILabel *item;
}

@property (nonatomic,retain) IBOutlet UILabel *mer_name;
@property (nonatomic,retain) IBOutlet UILabel *mer_address;

@property (nonatomic,retain) IBOutlet UIImageView *imgv;

@end
