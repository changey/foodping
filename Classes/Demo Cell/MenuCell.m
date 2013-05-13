//
//  MenuCell.m
//  NB_list
//
//  Created by Eric Chang on 11/18/12.
//
//

#import "MenuCell.h"

@implementation MenuCell

@synthesize imgv, mer_name, mer_address;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
