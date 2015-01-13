//
//  DQViewController.m
//  DQAlertViewDemo
//
//  Created by Dinh Quan on 1/27/14.
//  Copyright (c) 2014 Dinh Quan. All rights reserved.
//

#import "DQViewController.h"
#import "DQAlertView.h"

@interface DQViewController () <DQAlertViewDelegate>

@end

NSString * sampleTitle = @"Title";
NSString * shortSampleMessage = @"Hello World!";
NSString * sampleMessage = @"The quick brown fox jumps over the lazy dog.";
NSString * longSampleMessage = @"Yesterday, all my troubles seemed so far away. Now it looks as though they're here to stay. Oh, I believe in yesterday. Suddenly I'm not half the man I used to be. There's a shadow hanging over me. Oh, yesterday came suddenly.";


@implementation DQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shortMessage:(id)sender
{
    DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:sampleTitle message:sampleMessage delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK"];

    [alertView show];
}

- (IBAction)longMessage:(id)sender
{
    DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:sampleTitle message:longSampleMessage cancelButtonTitle:@"Cancel" otherButtonTitle:@"OK"];
    
    alertView.messageBottomPadding = -20;
    
    alertView.shouldDimBackgroundWhenShowInView = YES;
    alertView.shouldDismissOnOutsideTapped = YES;
    [alertView showInView:self.view];
}

- (IBAction)noTitle:(id)sender
{
    DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:nil message:sampleMessage cancelButtonTitle:@"Cancel" otherButtonTitle:@"OK"];
    
    [alertView showInView:self.view];
}

- (IBAction)oneButton:(id)sender
{
    DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:sampleTitle message:sampleMessage cancelButtonTitle:@"Cancel" otherButtonTitle:nil];
    
    
    [alertView showInView:self.view];
}

- (IBAction)cancelRight:(id)sender
{
    DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:sampleTitle message:sampleMessage cancelButtonTitle:@"Cancel" otherButtonTitle:@"OK"];
    
    alertView.cancelButtonPositionRight = YES;
    alertView.borderColor = [UIColor blackColor];
    alertView.borderWidth = 2;
    
    [alertView showInView:self.view];
}

- (IBAction)noCorner:(id)sender
{
    DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:sampleTitle message:sampleMessage cancelButtonTitle:@"Cancel" otherButtonTitle:@"OK"];
    
    alertView.cornerRadius = 0;
    
    [alertView showInView:self.view];
}

- (IBAction)customeFrame:(id)sender
{
    DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:sampleTitle message:sampleMessage cancelButtonTitle:@"Cancel" otherButtonTitle:@"OK"];
    
    alertView.customFrame = CGRectMake(30, 30, 200, 150);
    alertView.appearAnimationType = DQAlertViewAnimationTypeNone;

    [alertView show];
}

- (IBAction)backgroundColor:(id)sender
{
    DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:sampleTitle message:sampleMessage cancelButtonTitle:@"Cancel" otherButtonTitle:@"OK"];
    
    alertView.backgroundColor = [UIColor orangeColor];
    alertView.seperatorColor = [UIColor blackColor];
    [alertView showInView:self.view];
}

- (IBAction)backgroundImage:(id)sender
{
    DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:sampleTitle message:sampleMessage cancelButtonTitle:@"Close" otherButtonTitle:nil];
    
    UIImage * image = [UIImage imageNamed:@"alert-box.png"];
    alertView.backgroundImage = image;
    alertView.hideSeperator = YES;
    alertView.customFrame = CGRectMake((self.view.frame.size.width - image.size.width )/2, (self.view.frame.size.height - image.size.height)/2, image.size.width, image.size.height);
    
    [alertView showInView:self.view];
}

- (IBAction)customFont:(id)sender
{
    DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:sampleTitle message:sampleMessage cancelButtonTitle:@"Cancel" otherButtonTitle:@"OK"];
    
    alertView.titleLabel.font = [UIFont fontWithName:@"Arial" size:18];
    alertView.messageLabel.font = [UIFont fontWithName:@"Arial" size:16];
    
    [alertView showInView:self.view];
}

- (IBAction)customeColor:(id)sender
{
    DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:sampleTitle message:sampleMessage cancelButtonTitle:@"Cancel" otherButtonTitle:@"OK"];
    
    alertView.seperatorColor = [UIColor blueColor];
    alertView.titleLabel.textColor = [UIColor redColor];
    alertView.messageLabel.textColor = [UIColor brownColor];
    [alertView.cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [alertView.otherButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [alertView showInView:self.view];
}

- (IBAction)appearZoomIn:(id)sender
{
    DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:sampleTitle message:sampleMessage cancelButtonTitle:@"Cancel" otherButtonTitle:@"OK"];
    
    alertView.appearAnimationType = DQAlertViewAnimationTypeZoomIn;
    alertView.disappearAnimationType = DQAlertViewAnimationTypeZoomOut;
    
    [alertView showInView:self.view];
}

- (IBAction)appearFadeIn:(id)sender
{
    DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:sampleTitle message:sampleMessage cancelButtonTitle:@"Cancel" otherButtonTitle:@"OK"];
    
    alertView.appearAnimationType = DQAlertViewAnimationTypeFadeIn;
    alertView.disappearAnimationType = DQAlertViewAnimationTypeFaceOut;
    
    alertView.appearTime = 1;
    alertView.disappearTime = 1;
    
    [alertView showInView:self.view];
}

- (IBAction)appearFromTop:(id)sender
{
    DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:sampleTitle message:sampleMessage cancelButtonTitle:@"Cancel" otherButtonTitle:@"OK"];
    
    alertView.appearAnimationType = DQAlertViewAnimationTypeFlyTop;
    alertView.disappearAnimationType = DQAlertViewAnimationTypeFlyBottom;
    
    [alertView showInView:self.view];
}
- (IBAction)appearFromLeft:(id)sender
{
    DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:sampleTitle message:sampleMessage cancelButtonTitle:@"Cancel" otherButtonTitle:@"OK"];
    
    alertView.appearAnimationType = DQAlertViewAnimationTypeFlyLeft;
    alertView.disappearAnimationType = DQAlertViewAnimationTypeFlyRight;
    
    alertView.appearTime = 1;
    alertView.disappearTime = 1;
    
    [alertView showInView:self.view];
}

- (IBAction)contentView:(id)sender
{
    DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:sampleTitle message:sampleMessage cancelButtonTitle:@"Cancel" otherButtonTitle:@"OK"];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
    contentView.backgroundColor = [UIColor yellowColor];
    
    alertView.contentView = contentView;
    
    [alertView show];
    
    alertView.cancelButtonAction = ^{
        NSLog(@"Cancel Clicked");
    };
    
    alertView.otherButtonAction = ^{
        NSLog(@"OK Clicked");
    };
    
//    // You can also use:
//    [alertView actionWithBlocksCancelButtonHandler:^{
//        NSLog(@"Cancel Clicked");
//
//    } otherButtonHandler:^{
//        NSLog(@"OK Clicked");
//
//    }];
}

#pragma mark - DQAlertViewDelegate

- (void)willAppearAlertView:(DQAlertView *)alertView
{
    NSLog(@"Alert View Will Appear");
}

- (void)didAppearAlertView:(DQAlertView *)alertView
{
    NSLog(@"Alert View Did Appear");
}

- (void)cancelButtonClickedOnAlertView:(DQAlertView *)alertView {
    NSLog(@"Cancel Clicked");
}

- (void)otherButtonClickedOnAlertView:(DQAlertView *)alertView {
    NSLog(@"OK Clicked");
}

@end
