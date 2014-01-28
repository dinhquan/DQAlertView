DQAlertView
===========

The best iOS customizable AlertView.

DQAlertView is the best alternative for UIKit's UIAlertView.
With DQAlertView, you can easily make your desired Alert View in some lines of code.

## Usage

### Initilization

Set the title to nil to make the alert be no title.

```objective-c
DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:@"Title" 
                                              message:@"Sample Message"
                                              cancelButtonTitle:@"Cancel" 
                                              otherButtonTitle:@"OK"];
```

### Show and dismiss

```objective-c
// Show in specified view
// If the custom frame has not been set, the alert will be shown at the center of the view
- (void) showInView: (UIView *) view;

// Show in window (if you want it always appears at the front, use this method)
// Always show at center
- (void) show;

// Dismiss the alert
- (void) dismiss;

```

### Button touching event handler

```objective-c

alertView.cancelButtonAction = ^{
    NSLog(@"Cancel Clicked");
};
alertView.otherButtonAction = ^{
    NSLog(@"OK Clicked");
};
    
//    // You can also use:
//    [alertView actionWithBlocksCancelButtonHandler:^{
//        NSLog(@"Cancel Clicked");
//    } otherButtonHandler:^{
//        NSLog(@"OK Clicked");
//    }];
    
```

If you don't want to use blocks, implement ```<DQAlertViewDelegate>``` and use delegate methods:

```objective-c

alertView.delegate = self;

-(void)DQAlertViewCancelButtonClicked {
    NSLog(@"Cancel Clicked");
}

-(void) DQAlertViewOtherButtonClicked {
    NSLog(@"OK Clicked");
}

```
### Customization

DQAlertView can be customized with the following properties:

```objective-c

// Set the custom frame for the Alert View
@property (nonatomic, assign) CGRect customFrame; // Default is same as UIAlertView

// You can get buttons and labels for customizing their appearance
@property (nonatomic, strong) UIButton * cancelButton; // Default is in blue color and system font 16
@property (nonatomic, strong) UIButton * otherButton; // Default is in blue color and system font 16
@property (nonatomic, strong) UILabel * titleLabel; // Default is in black color and system bold font 16
@property (nonatomic, strong) UILabel * messageLabel; // Default is in black color and system font 14

@property (nonatomic, assign) BOOL cancelButtonPositionRight; // Default is NO

// Set the height of title and button; and the padding of elements. The message label height is calculated based on its text and font.
@property (nonatomic, assign) CGFloat buttonHeight; // Default is 44
@property (nonatomic, assign) CGFloat titleHeight; // Default is 30

@property (nonatomic, assign) CGFloat titleTopPadding; //Default is 5
@property (nonatomic, assign) CGFloat titleBottomPadding; // Default is 0
@property (nonatomic, assign) CGFloat messageBottomPadding; // Default is 10
@property (nonatomic, assign) CGFloat messageLeftRightPadding; // Default is 10

// Customize the background and border
@property (nonatomic, strong) UIColor * borderColor; // Default is no border
@property (nonatomic, assign) CGFloat borderWidth; // Default is 0
@property (nonatomic, assign) CGFloat cornerRadius; // Default is 4
// inherits from UIView @property (nonatomic, strong) UIColor * backgroundColor; // Default is white color
@property (nonatomic, strong) UIImage * backgroundImage; // Default is nil

// Customize the seperator
@property (nonatomic, assign) BOOL hideSeperator; // Default is NO
@property (nonatomic, strong) UIColor * seperatorColor; // Default is light gray color

// Customize the appearing and disappearing animations
@property (nonatomic, assign) DQAlertViewAnimationType appearAnimationType;
@property (nonatomic, assign) DQAlertViewAnimationType disappearAnimationType;
@property (nonatomic, assign) NSTimeInterval appearTime; // Default is 0.5
@property (nonatomic, assign) NSTimeInterval disappearTime; // Default is 0.3

```

## Contacts

If you have any questions, feature suggestions or bug reports, please send me an email to dinhquan191@gmail.com.


