//
//  DQViewController.m
//  DQAlertViewDemo
//
//  Created by Dinh Quan on 1/27/14.
//  Copyright (c) 2014 Dinh Quan. All rights reserved.
//

#import "DQViewController.h"
#import "DQAlertView.h"

@interface DQViewController () <DQAlertViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *demoArray;

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
    
    self.demoArray = @[@"Short Message",
                       @"Long Message",
                       @"No Title",
                       @"One Button",
                       @"Custom Background Color",
                       @"Custom Background Image",
                       @"Custom Frame",
                       @"Custom Content View",
                       @"Appear Fade In",
                       @"Appear From Left"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.demoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"DemoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = self.demoArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch (indexPath.row + 1) {
        case 1:
        {
            DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:sampleTitle message:sampleMessage delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
            
            [alertView show];
        }
            break;
            
        case 2:
        {
            DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:sampleTitle message:longSampleMessage cancelButtonTitle:@"Cancel" otherButtonTitle:@"OK"];
                        
            alertView.shouldDimBackgroundWhenShowInView = YES;
            alertView.shouldDismissOnOutsideTapped = YES;
            [alertView show];
        }
            break;
            
        case 3:
        {
            DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:nil message:sampleMessage cancelButtonTitle:@"Cancel" otherButtonTitle:@"OK"];
            
            [alertView show];
        }
            break;
            
        case 4:
        {
            DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:sampleTitle message:sampleMessage cancelButtonTitle:@"Cancel" otherButtonTitle:nil];
            
            [alertView show];
        }
            break;
            
        case 5:
        {
            DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:sampleTitle message:sampleMessage cancelButtonTitle:@"Cancel" otherButtonTitle:@"OK"];
            
            alertView.backgroundColor = [UIColor orangeColor];
            alertView.separatorColor = [UIColor blackColor];
            
            [alertView show];
        }
            break;
            
        case 6:
        {
            DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:sampleTitle message:sampleMessage cancelButtonTitle:@"Close" otherButtonTitle:nil];
            
            UIImage * image = [UIImage imageNamed:@"alert-box.png"];
            alertView.backgroundImage = image;
            alertView.hideSeperator = YES;
            alertView.customFrame = CGRectMake((self.view.frame.size.width - image.size.width )/2, (self.view.frame.size.height - image.size.height)/2, image.size.width, image.size.height);
            
            [alertView show];
        }
            break;
            
        case 7:
        {
            DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:sampleTitle message:sampleMessage cancelButtonTitle:@"Cancel" otherButtonTitle:@"OK"];
            
            alertView.customFrame = CGRectMake(30, 30, 200, 150);
            alertView.appearAnimationType = DQAlertViewAnimationTypeNone;
            
            [alertView show];
        }
            break;
            
        case 8:
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
        }
            break;
            
        case 9:
        {
            DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:sampleTitle message:sampleMessage cancelButtonTitle:@"Cancel" otherButtonTitle:@"OK"];
            
            alertView.appearAnimationType = DQAlertViewAnimationTypeFadeIn;
            alertView.disappearAnimationType = DQAlertViewAnimationTypeFaceOut;
            
            alertView.appearTime = 1;
            alertView.disappearTime = 1;
            
            [alertView show];
        }
            break;
            
        case 10:
        {
            DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:sampleTitle message:sampleMessage cancelButtonTitle:@"Cancel" otherButtonTitle:@"OK"];
            
            alertView.appearAnimationType = DQAlertViewAnimationTypeFlyLeft;
            alertView.disappearAnimationType = DQAlertViewAnimationTypeFlyRight;
            
            alertView.appearTime = 1;
            alertView.disappearTime = 1;
            
            [alertView show];
        }
            break;
            
        default:
            break;
    }
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
