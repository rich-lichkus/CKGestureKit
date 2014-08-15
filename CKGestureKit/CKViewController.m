//
//  CKViewController.m
//  CKGestureKit
//
//  Created by Richard Lichkus on 8/14/14.
//  Copyright (c) 2014 Richard Lichkus. All rights reserved.
//

#import "CKViewController.h"
#import "CKDragableImageView.h"


@interface CKViewController ()

@property(strong,nonatomic) CKDragableImageView *dragImage;

@end

@implementation CKViewController

#pragma mark - View

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureDragableView];
}

#pragma mark - Configure Dragable View

-(void)configureDragableView{
    self.dragImage = [[CKDragableImageView alloc] initWithImage:[UIImage imageNamed:@"profile"]];
    self.dragImage.frame = CGRectMake(self.view.center.x-40,
                                      self.view.center.y-50,
                                      90, 100);
    
    [self.view addSubview:self.dragImage];
}

#pragma mark - Memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
