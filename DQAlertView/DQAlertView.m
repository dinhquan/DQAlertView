//
//  DQAlertView.m
//
//  Created by Dinh Quan on 1/27/14.
//  Copyright (c) 2014 Dinh Quan. All rights reserved.
//

#import "DQAlertView.h"

#define DEFAULT_ALERT_WIDTH 260
#define DEFAULT_ALERT_HEIGHT 120

@interface DQAlertView ()
{
    CGRect titleLabelFrame;
    CGRect messageLabelFrame;
    CGRect cancelButtonFrame;
    CGRect otherButtonFrame;
    
    CGRect verticalSeperatorFrame;
    CGRect horizontalSeperatorFrame;
    
    BOOL hasModifiedFrame;
}

@property (nonatomic, strong) UIView * horizontalSeperator;
@property (nonatomic, strong) UIView * verticalSeperator;

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * message;
@property (nonatomic, strong) NSString * cancelButtonTitle;
@property (nonatomic, strong) NSString * otherButtonTitle;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@end

@implementation DQAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Init method
- (id) initWithTitle:(NSString *) title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle
{
    self.width = DEFAULT_ALERT_WIDTH;
    self.height = DEFAULT_ALERT_HEIGHT;
    
    self = [super initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    if (self) {
        // Initialization code
        
        self.title = title;
        self.message = message;
        self.cancelButtonTitle = cancelButtonTitle;
        self.otherButtonTitle = otherButtonTitle;
        self.appearAnimationType = DQAlertViewAnimationTypeDefault;
        self.disappearAnimationType = DQAlertViewAnimationTypeDefault;
        self.cornerRadius = 4;
        self.buttonClickedHighlight = YES;
        
        self.buttonHeight  = 44;
        self.titleTopPadding = 5;
        self.titleHeight  = 30;
        self.titleBottomPadding = 0;
        self.messageBottomPadding = 10;
        self.messageLeftRightPadding = 10;
        
        
        [self setupItems];

    }
    return self;
}

// Show in specified view
- (void) showInView: (UIView *) view
{
    [self calculateFrame];
    [self setupViews];
    
    if ( ! hasModifiedFrame) {
        self.frame = CGRectMake((view.frame.size.width - self.frame.size.width )/2, (view.frame.size.height - self.frame.size.height) /2, self.frame.size.width, self.frame.size.height);
    }

    [self addThisViewToView:view];
}

// Show in window
- (void) show
{
    [self calculateFrame];
    [self setupViews];
    
    id appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate respondsToSelector:@selector(window)]) {
        UIWindow * window = (UIWindow *) [appDelegate performSelector:@selector(window)];
        
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        self.frame = CGRectMake((screenSize.width - self.frame.size.width )/2, (screenSize.height - self.frame.size.height) /2, self.frame.size.width, self.frame.size.height);

        [self showInView:window];
    }
}

- (void) addThisViewToView: (UIView *) view
{
    NSTimeInterval timeAppear = ( self.appearTime > 0 ) ? self.appearTime : .3;

    [view addSubview:self];
    
    if (self.appearAnimationType == DQAlertViewAnimationTypeDefault)
    {
        self.transform = CGAffineTransformMakeScale(.8, .8);
        self.alpha = .6;
        [UIView animateWithDuration:timeAppear delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.transform = CGAffineTransformIdentity;
            self.alpha = 1;
            
        } completion:^(BOOL finished){
            [self didAppearAlertView];
        }];
    }
    else if ( !self.appearAnimationType || self.appearAnimationType == DQAlertViewAnimationTypeZoomIn)
    {
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
        [UIView animateWithDuration:timeAppear delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished){
            [self didAppearAlertView];
        }];
    }
    else if (self.appearAnimationType == DQAlertViewAnimationTypeFadeIn)
    {
        self.alpha = 0;
        [UIView animateWithDuration:timeAppear delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.alpha = 1;
            
        } completion:^(BOOL finished){
            [self didAppearAlertView];
        }];
    }
    else if (self.appearAnimationType == DQAlertViewAnimationTypeFlyTop)
    {
        CGRect tmpFrame = self.frame;
        self.frame = CGRectMake(self.frame.origin.x, - self.frame.size.height - 10, self.frame.size.width, self.frame.size.height);
        [UIView animateWithDuration:timeAppear delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.frame = tmpFrame;
            
        } completion:^(BOOL finished){
            [self didAppearAlertView];
        }];
        
    }
    else if (self.appearAnimationType == DQAlertViewAnimationTypeFlyBottom)
    {
        CGRect tmpFrame = self.frame;
        self.frame = CGRectMake( self.frame.origin.x, view.frame.size.height + 10, self.frame.size.width, self.frame.size.height);
        [UIView animateWithDuration:timeAppear delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.frame = tmpFrame;
            
        } completion:^(BOOL finished){
            [self didAppearAlertView];
        }];
        
    }
    else if (self.appearAnimationType == DQAlertViewAnimationTypeFlyLeft)
    {
        CGRect tmpFrame = self.frame;
        self.frame = CGRectMake( - self.frame.size.width - 10, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
        [UIView animateWithDuration:timeAppear delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.frame = tmpFrame;
            
        } completion:^(BOOL finished){
            [self didAppearAlertView];
        }];
        
    }
    else if (self.appearAnimationType == DQAlertViewAnimationTypeFlyRight)
    {
        CGRect tmpFrame = self.frame;
        self.frame = CGRectMake(view.frame.size.width + 10, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
        [UIView animateWithDuration:timeAppear delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.frame = tmpFrame;
            
        } completion:^(BOOL finished){
            [self didAppearAlertView];
        }];
    }
    else if (self.appearAnimationType == DQAlertViewAnimationTypeNone)
    {
        [self didAppearAlertView];
    }
}

// Hide and dismiss the alert
- (void) dismiss
{
    
    NSTimeInterval timeDisappear = ( self.disappearTime > 0 ) ? self.disappearTime : .3;
    NSTimeInterval timeDelay = .2;
    
    if (self.appearAnimationType == DQAlertViewAnimationTypeDefault) {
        self.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:timeDisappear delay:timeDelay options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.transform = CGAffineTransformMakeScale(.8, .8);
            self.alpha = .0;
            
        } completion:^(BOOL finished){
            [self removeFromSuperview];
        }];    }
    else if (self.disappearAnimationType == DQAlertViewAnimationTypeZoomOut )
    {
        self.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:timeDisappear delay:timeDelay options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.transform = CGAffineTransformMakeScale(0.01, 0.01);
            
        } completion:^(BOOL finished){
            [self removeFromSuperview];
        }];
    }
    else if (self.disappearAnimationType == DQAlertViewAnimationTypeFaceOut)
    {
        self.alpha = 1;
        [UIView animateWithDuration:timeDisappear delay:timeDelay options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.alpha = 0;
            
        } completion:^(BOOL finished){
            [self removeFromSuperview];
        }];
    }
    else if (self.disappearAnimationType == DQAlertViewAnimationTypeFlyTop)
    {
        [UIView animateWithDuration:timeDisappear delay:timeDelay options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.frame = CGRectMake(self.frame.origin.x, - self.frame.size.height - 10, self.frame.size.width, self.frame.size.height);
            
        } completion:^(BOOL finished){
            [self removeFromSuperview];
        }];
    }
    else if (self.disappearAnimationType == DQAlertViewAnimationTypeFlyBottom)
    {
        [UIView animateWithDuration:timeDisappear delay:timeDelay options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.frame = CGRectMake( self.frame.origin.x, self.superview.frame.size.height + 10, self.frame.size.width, self.frame.size.height);
            
        } completion:^(BOOL finished){
            [self removeFromSuperview];
        }];
    }
    else if (self.disappearAnimationType == DQAlertViewAnimationTypeFlyLeft)
    {
        [UIView animateWithDuration:timeDisappear delay:timeDelay options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.frame = CGRectMake( - self.frame.size.width - 10, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
            
        } completion:^(BOOL finished){
            [self removeFromSuperview];
        }];
    }
    else if (self.disappearAnimationType == DQAlertViewAnimationTypeFlyRight)
    {
        [UIView animateWithDuration:timeDisappear delay:timeDelay options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.frame = CGRectMake(self.superview.frame.size.width + 10, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
            
        } completion:^(BOOL finished){
            [self removeFromSuperview];
        }];
    }
    else if (self.disappearAnimationType == DQAlertViewAnimationTypeNone)
    {
        [self removeFromSuperview];
    }

}

- (void) setCustomFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    self.width = frame.size.width;
    self.height = frame.size.height;
    hasModifiedFrame = YES;

    [self calculateFrame];
}

- (void) calculateFrame
{
    if ( ! hasModifiedFrame )
    {
        UIFont * messageFont = self.titleLabel.font ? self.titleLabel.font : [UIFont systemFontOfSize:14];
        //Calculate label size
        //Calculate the expected size based on the font and linebreak mode of your label
        // FLT_MAX here simply means no constraint in height
        CGSize maximumLabelSize = CGSizeMake(self.width, FLT_MAX);
        CGSize expectedLabelSize = [self.message sizeWithFont:messageFont constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
        CGFloat messageHeight = expectedLabelSize.height;
        
        CGFloat newHeight = messageHeight + self.titleHeight + self.buttonHeight + self.titleTopPadding + self.titleBottomPadding + self.messageBottomPadding;
        self.height = newHeight;
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.height);
        
    }
    
    BOOL hasButton = (self.cancelButtonTitle || self.otherButtonTitle);
    
    if ( ! self.title ) {
        titleLabelFrame = CGRectZero;
    } else {
        titleLabelFrame = CGRectMake(self.messageLeftRightPadding,
                                     self.titleTopPadding,
                                     self.width - self.messageLeftRightPadding * 2,
                                     self.titleHeight);
    }
    if ( ! self.message ) {
        messageLabelFrame = CGRectZero;
    } else if (hasButton) {
        messageLabelFrame = CGRectMake(self.messageLeftRightPadding,
                                       titleLabelFrame.origin.y + titleLabelFrame.size.height + self.titleBottomPadding,
                                       self.width - self.messageLeftRightPadding * 2,
                                       self.height - self.buttonHeight - titleLabelFrame.size.height - self.titleTopPadding - self.titleBottomPadding);
    } else {
        messageLabelFrame = CGRectMake(self.messageLeftRightPadding,
                                       titleLabelFrame.origin.y +  titleLabelFrame.size.height + self.titleBottomPadding,
                                       self.width - self.messageLeftRightPadding * 2,
                                       self.height - titleLabelFrame.size.height - self.titleTopPadding - self.titleBottomPadding);
    }
    
    if ( self.hideSeperator || ! hasButton ) {
        verticalSeperatorFrame = CGRectZero;
        horizontalSeperatorFrame = CGRectZero;
    } else {
        verticalSeperatorFrame = CGRectMake(self.width / 2,
                                            self.height - self.buttonHeight,
                                            0.5,
                                            self.buttonHeight);
        
        horizontalSeperatorFrame = CGRectMake(0,
                                              self.height - self.buttonHeight,
                                              self.width,
                                              0.5);
    }
    
    if ( ! self.cancelButtonTitle ) {
        cancelButtonFrame = CGRectZero;
    } else if ( ! self.otherButtonTitle ) {
        verticalSeperatorFrame = CGRectZero;
        cancelButtonFrame = CGRectMake(0,
                                       self.height - self.buttonHeight,
                                       self.width,
                                       self.buttonHeight);
    } else if ( ! self.cancelButtonPositionRight ) {
        cancelButtonFrame = CGRectMake(0,
                                       self.height - self.buttonHeight,
                                       self.width / 2,
                                       self.buttonHeight);
    } else {
        cancelButtonFrame = CGRectMake(self.width / 2,
                                       self.height - self.buttonHeight,
                                       self.width / 2,
                                       self.buttonHeight);
    }
    
    if ( ! self.otherButtonTitle ) {
        otherButtonFrame = CGRectZero;
    } else if ( ! self.cancelButtonTitle ) {
        verticalSeperatorFrame = CGRectZero;
        otherButtonFrame = CGRectMake(0,
                                      self.height - self.buttonHeight,
                                      self.width,
                                      self.buttonHeight);
    } else if ( ! self.cancelButtonPositionRight ) {
        otherButtonFrame = CGRectMake(self.width / 2,
                                      self.height - self.buttonHeight,
                                      self.width / 2,
                                      self.buttonHeight);
    } else {
        otherButtonFrame = CGRectMake(0,
                                      self.height - self.buttonHeight,
                                      self.width / 2,
                                      self.buttonHeight);
    }
    

}

- (void) setupItems
{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.otherButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // Setup Title Label
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.titleLabel.text = self.title;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    
    // Setup Message Label
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.font = [UIFont systemFontOfSize:14];
    self.messageLabel.text = self.message;
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.textColor = [UIColor blackColor];
    self.messageLabel.backgroundColor = [UIColor clearColor];
    
    //Setup Cancel Button
    self.cancelButton.backgroundColor = [UIColor clearColor];
    [self.cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.cancelButton setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //Setup Other Button
    self.otherButton.backgroundColor = [UIColor clearColor];
    [self.otherButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.otherButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.otherButton setTitle:self.otherButtonTitle forState:UIControlStateNormal];
    [self.otherButton addTarget:self action:@selector(otherButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //Set up Seperator
    self.horizontalSeperator = [[UIView alloc] initWithFrame:CGRectZero];
    self.verticalSeperator = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void) setupViews
{
    // Setup Background
    if (self.backgroundImage) {
        [self setBackgroundColor:[UIColor colorWithPatternImage:self.backgroundImage]];
    } else if (self.backgroundColor) {
        [self setBackgroundColor:self.backgroundColor];
    } else {
        [self setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
    }
    
    if (self.borderWidth) {
        self.layer.borderWidth = self.borderWidth;
    }
    if (self.borderColor) {
        self.layer.borderColor = self.borderColor.CGColor;
    } else {
        self.layer.borderColor = [UIColor clearColor].CGColor;
    }
    
    self.layer.cornerRadius = self.cornerRadius;
    
    // Set Frame
    self.titleLabel.frame = titleLabelFrame;
    self.messageLabel.frame = messageLabelFrame;
    self.cancelButton.frame = cancelButtonFrame;
    self.otherButton.frame = otherButtonFrame;
    
    self.horizontalSeperator.frame = horizontalSeperatorFrame;
    self.verticalSeperator.frame = verticalSeperatorFrame;
    
    if (self.seperatorColor) {
        self.horizontalSeperator.backgroundColor = self.seperatorColor;
        self.verticalSeperator.backgroundColor = self.seperatorColor;
    } else {
        self.horizontalSeperator.backgroundColor = [UIColor lightGrayColor];
        self.verticalSeperator.backgroundColor = [UIColor lightGrayColor];
    }
    
    // Make the message fits to it bounds
    if ( self.title ) {
        [self.messageLabel sizeToFit];
        CGRect myFrame = self.messageLabel.frame;
        myFrame = CGRectMake(myFrame.origin.x, myFrame.origin.y, self.width -  2 * self.messageLeftRightPadding, myFrame.size.height);
        self.messageLabel.frame = myFrame;
    }

    
    // Add subviews
    [self addSubview:self.titleLabel];
    [self addSubview:self.messageLabel];
    [self addSubview:self.cancelButton];
    [self addSubview:self.otherButton];
    [self addSubview:self.horizontalSeperator];
    [self addSubview:self.verticalSeperator];
}

#pragma mark - Actions

- (void) actionWithBlocksCancelButtonHandler:(void (^)(void))cancelHandler otherButtonHandler:(void (^)(void))otherHandler
{
    self.cancelButtonAction = cancelHandler;
    self.otherButtonAction = otherHandler;
}

- (void) cancelButtonClicked: (id) sender
{
    if (self.buttonClickedHighlight)
    {
        UIColor * originColor = [self.cancelButton.backgroundColor colorWithAlphaComponent:0];
        self.cancelButton.backgroundColor = [self.cancelButton.backgroundColor colorWithAlphaComponent:.1];
        double delayInSeconds = .1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            self.otherButton.backgroundColor = originColor;
        });
        
    }

    [self dismiss];
    
    if (self.cancelButtonAction) {
        self.cancelButtonAction();
    }
    
    if ([self.delegate respondsToSelector:@selector(DQAlertViewCancelButtonClicked)]) {
        [self.delegate DQAlertViewCancelButtonClicked];
    }
}

- (void) otherButtonClicked: (id) sender
{
    if (self.buttonClickedHighlight)
    {
        UIColor * originColor = [self.otherButton.backgroundColor colorWithAlphaComponent:0];
        self.otherButton.backgroundColor = [self.otherButton.backgroundColor colorWithAlphaComponent:.1];
        double delayInSeconds = .1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            self.otherButton.backgroundColor = originColor;
        });
    }
    
    if (self.otherButtonAction) {
        self.otherButtonAction();
    }
    
    if ([self.delegate respondsToSelector:@selector(DQAlertViewOtherButtonClicked)]) {
        [self.delegate DQAlertViewOtherButtonClicked];
    }
}

- (void) didAppearAlertView
{
    if ([self.delegate respondsToSelector:@selector(DQAlertViewDidAppear)]) {
        [self.delegate DQAlertViewDidAppear];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
