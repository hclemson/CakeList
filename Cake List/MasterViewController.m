//
//  MasterViewController.m
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import "MasterViewController.h"
#import "CakeCell.h"


@interface MasterViewController ()
{
    CakeManager *mgr;
}

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mgr = [[CakeManager alloc] init];
    
    self.imageCache = [[NSMutableDictionary alloc] init];
    
    // Pull to refresh
    [self.tableView.refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    
    // Get the cake data
    [self refreshData];
}

- (void)refreshData {
    // Async download to prevent blocking UI
    [mgr downloadCakesWithCompletion:^(NSArray<Cake *> *data, NSError *error) {
        self.cakes = data;
        [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:NO];
    }];
}

- (void)reloadTable {
    [self.tableView.refreshControl endRefreshing];
    [self.tableView reloadData];
}


#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cakes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CakeCell *cell = (CakeCell*)[tableView dequeueReusableCellWithIdentifier:@"CakeCell"];
    
    Cake *cake = [self.cakes objectAtIndex:indexPath.row];
    cell.titleLabel.text = cake.title;
    cell.descriptionLabel.text = cake.desc;
    cell.cakeImageView.image = nil; // Reset the image
    
    [self imageAtURLString:cake.image completion:^(UIImage *image, BOOL cached) {
        // If using a cached image, can set the image straight away, otherwise reload the cell
        if (cached) {
            cell.cakeImageView.image = image;
        } else {
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Helpers

/**
* Get an image from a url
* Note to reviewer: This could be done in a UIImageView extension with separate image cache
*
* @param urlString The location of the image
* @completion Called on image download, or cached image retrieved
*/
- (void)imageAtURLString:(NSString *)urlString completion:(void(^)(UIImage *, BOOL))completion {
    // If image has already been downloaded
    if (self.imageCache[urlString]) {
        completion(self.imageCache[urlString], YES);
    } else {
        // Download image
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                UIImage *image = [UIImage imageWithData:data];
                if (image) {
                    // Save to cache
                    self.imageCache[urlString] = image;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(image, NO);
                    });
                } else {
                    NSLog(@"Image invalid %@", urlString);
                }
            }
        }];
        [task resume];
    }
}
@end
