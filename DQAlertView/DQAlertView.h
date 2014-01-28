//
//  DQAlertView.h
//
//  Version 0.1
//
//  Created by Dinh Quan on 1/27/14.
//  Copyright (c) 2014 Dinh Quan. All rights reserved.
//
// This code is distributed under the terms and conditions of the MIT license.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import <UIKit/UIKit.h>

@protocol DQAlertViewDelegate <NSObject>

@optional
- (void) DQAlertViewDidAppear;

- (void) DQAlertViewCancelButtonClicked;
- (void) DQAlertViewOtherButtonClicked;

@end

typedef enum
{
    DQAlertViewAnimationTypeNone        = 0,
    DQAlertViewAnimationTypeDefault     = 1,
    DQAlertViewAnimationTypeFadeIn      = 2,
    DQAlertViewAnimationTypeFaceOut     = 3,
    DQAlertViewAnimationTypeFlyTop      = 4,
    DQAlertViewAnimationTypeFlyBottom   = 5,
    DQAlertViewAnimationTypeFlyLeft     = 6,
    DQAlertViewAnimationTypeFlyRight    = 7,
    DQAlertViewAnimationTypeZoomIn      = 8,
    DQAlertViewAnimationTypeZoomOut     = 9
    
} DQAlertViewAnimationType;

typedef void (^DQAlertViewBlock)(void);

@interface DQAlertView : UIView

#pragma mark - Public Properties

// Set the custom frame for the Alert View
@property (nonatomic, assign) CGRect customFrame; // Default is same as UIAlertView


// You can get buttons and labels for customizing their appearance
@property (nonatomic, strong) UIButton * cancelButton; // Default is in blue color and system font 16
@property (nonatomic, strong) UIButton * otherButton; // Default is in blue color and system font 16
@property (nonatomic, strong) UILabel * titleLabel; // Default is in black color and system bold font 16
@property (nonatomic, strong) UILabel * messageLabel; // Default is in gray color and system font 14

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
// inherits from UIView @property (nonatomic, strong) UIColor * backgroundColor; // Default is white color with alpha 0.8
@property (nonatomic, strong) UIImage * backgroundImage; // Default is nil


// Customize the seperator
@property (nonatomic, assign) BOOL hideSeperator; // Default is NO
@property (nonatomic, strong) UIColor * seperatorColor; // Default is light gray color


// Customize the appearing and disappearing animations
@property (nonatomic, assign) DQAlertViewAnimationType appearAnimationType;
@property (nonatomic, assign) DQAlertViewAnimationType disappearAnimationType;
@property (nonatomic, assign) NSTimeInterval appearTime; // Default is 0.5
@property (nonatomic, assign) NSTimeInterval disappearTime; // Default is 0.3


// Handle the button touch
@property (readwrite, copy) DQAlertViewBlock cancelButtonAction;
@property (readwrite, copy) DQAlertViewBlock otherButtonAction;

@property (nonatomic, assign) BOOL buttonClickedHighlight; //Default is YES

// Delegate
@property (nonatomic, strong) id<DQAlertViewDelegate> delegate;

#pragma mark - Public Methods

// Init method
// If you pass the title by nil, the alert will be no title. If you pass the otherButtonTitle by nil, the alert will only have cancel button. You can remove all buttons by set all buton titles to nil.
- (id) initWithTitle:(NSString *) title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle;


// You can use this methods instead of calling these properties:
// @property (readwrite, copy) DQAlertViewBlock cancelButtonAction;
// @property (readwrite, copy) DQAlertViewBlock otherButtonAction;
- (void) actionWithBlocksCancelButtonHandler:(void (^)(void))cancelHandler otherButtonHandler:(void (^)(void))otherHandler;


// Show in specified view
// If the custom frame has not been set, the alert will be shown at the center of the view
- (void) showInView: (UIView *) view;


// Show in window
// Always show at center
- (void) show;


// Dismiss the alert
- (void) dismiss;


@end
