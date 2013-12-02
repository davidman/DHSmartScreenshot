//
//  DHScreenshotViewController.m
//  TableViewScreenshots
//
//  Created by Hernandez Alvarez, David on 11/28/13.
//  Copyright (c) 2013 David Hernandez. All rights reserved.
//

#import "DHScreenshotViewController.h"

@interface DHScreenshotViewController () <UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *screenshotImageView;
@end

@implementation DHScreenshotViewController

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	self.screenshotImageView = [[UIImageView alloc] initWithImage:self.screenshot];
	[self.screenshotImageView setBackgroundColor:[UIColor whiteColor]];
	[self.scrollView addSubview:self.screenshotImageView];
	[self.scrollView setContentSize:self.screenshotImageView.bounds.size];
	[self.scrollView setMinimumZoomScale:1.f];
	[self.scrollView setMaximumZoomScale:3.f];
	[self.scrollView setDelegate:self];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return self.screenshotImageView;
}

@end
