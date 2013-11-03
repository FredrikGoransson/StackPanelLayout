//
//  StackPanelViewController.h
//  StackPanelLayout
//
//  Created by Fredrik Göransson on 11/4/13.
//  Copyright (c) 2013 Forefront Consulting Group AB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StackPanelViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic) float padding;

- (float)heightForView:(UIView*)view;
- (void)setHeight:(float)height forView:(UIView*)view animated:(BOOL)animate;

@end
