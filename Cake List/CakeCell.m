//
//  CakeCell.m
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import "CakeCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation CakeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cakeImageView.layer.cornerRadius = 2;
    self.cakeImageView.layer.masksToBounds = true;
}

@end
