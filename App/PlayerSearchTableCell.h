//
//  PlayerSearchTableCell.h
//  App
//
//  Created by Sai krishna K Rao on 2/9/14.
//  Copyright (c) 2014 Sai krishna K Rao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTPlayer.h"

@interface PlayerSearchTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *playerImage;
@property (weak, nonatomic) IBOutlet UILabel *playerName;
@property (weak, nonatomic) IBOutlet UILabel *playerRank;
@property (weak, nonatomic) IBOutlet UILabel *playerState;


-(void) setPlayerData:(TTPlayer *) player;
@end
