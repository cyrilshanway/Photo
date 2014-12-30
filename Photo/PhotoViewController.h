//
//  PhotoViewController.h
//  Photo
//
//  Created by Cyrilshanway on 2014/12/30.
//  Copyright (c) 2014年 Cyrilshanway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController

@property (nonatomic, strong) NSString *photoImageName;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
- (IBAction)close:(id)sender;

@end
