//
//  MasterViewController.h
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cake_List-Swift.h"

@class CakeManager;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) NSArray<Cake*> *cakes;
@property (strong, nonatomic) NSMutableDictionary *imageCache;

@end

