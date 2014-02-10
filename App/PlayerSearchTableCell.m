//
//  PlayerSearchTableCell.m
//  App
//
//  Created by Sai krishna K Rao on 2/9/14.
//  Copyright (c) 2014 Sai krishna K Rao. All rights reserved.
//

#import "PlayerSearchTableCell.h"

@implementation PlayerSearchTableCell

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
-(void) setPlayerData:(TTPlayer *) player
{
    self.layer.borderWidth = 0.3f;
    [self setupImageView];
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.playerName.text = [NSString stringWithFormat:@"Name: %@", player.name ];
    self.playerRank.text = [NSString stringWithFormat:@"Rating: %@", player.rating ];
    self.playerState.text = [NSString stringWithFormat:@"State: %@", player.state ];
}

-(void) setupImageView{
    CALayer *imageLayer = self.playerImage.layer;
    self.playerImage.image = [UIImage imageNamed:@"Player"];
    imageLayer.borderColor = [UIColor blackColor].CGColor;
    imageLayer.borderWidth = 1;
    [imageLayer setCornerRadius:20];
    [imageLayer setMasksToBounds:YES];
}

@end
