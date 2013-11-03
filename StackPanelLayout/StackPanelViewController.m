//
//  StackPanelViewController.m
//  StackPanelLayout
//
//  Created by Fredrik Göransson on 11/4/13.
//  Copyright (c) 2013 Forefront Consulting Group AB. All rights reserved.
//

#import "StackPanelViewController.h"

@interface StackPanelViewController ()

@end

@implementation StackPanelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if( self.scrollView == nil)
    {
        [NSException raise:@"StackPanelViewController is not connected to a ScrollView"
                    format:@"The StackPanelViewController needs a ScrollView to be connected to the IBOutlet. It is currently nil, it shouldn't be."];
    }
    
    float padding = self.padding;
    [self.scrollView removeConstraints:self.scrollView.constraints];
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *scrollView = self.scrollView;
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-(0)-[scrollView(>=320)]-(0)-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(scrollView)]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-(0)-[scrollView(>=480)]-(0)-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(scrollView)]];
    
    
    NSArray *filteredSubViews = [self.scrollView.subviews filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id object, NSDictionary *bindings) {
        return ![((UIView*)object) isKindOfClass:[UIImageView class]];
    }]];
    NSArray *sortedSubViews = [filteredSubViews sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        float first = ((UIView*)a).frame.origin.y;
        float second = ((UIView*)b).frame.origin.y;
        if (first < second) {
            return NSOrderedAscending;
        } else if (first > second) {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    UIView *firstView = sortedSubViews.firstObject;
    UIView *lastView = sortedSubViews.lastObject;
    UIView *previousView = nil;
    
    for (UIView *subView in sortedSubViews) {
        
        [subView removeConstraints:self.scrollView.constraints];
        subView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.scrollView addConstraints:[NSLayoutConstraint
                                         constraintsWithVisualFormat:@"H:|-(padding)-[subView(>=280)]-(padding)-|"
                                         options:NSLayoutFormatDirectionLeadingToTrailing
                                         metrics:@{@"padding": [NSNumber numberWithFloat:padding]}
                                         views:NSDictionaryOfVariableBindings(subView)]];
        
        float height = subView.frame.size.height;
        [subView addConstraints:[NSLayoutConstraint
                                 constraintsWithVisualFormat:@"V:[subView(height)]"
                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                 metrics:@{@"height":[NSNumber numberWithFloat:height]}
                                 views:NSDictionaryOfVariableBindings(subView)]];
        
        if( subView == firstView) {
            [self.scrollView addConstraints:[NSLayoutConstraint
                                             constraintsWithVisualFormat:@"V:|-(padding)-[subView]"
                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                             metrics:@{@"padding": [NSNumber numberWithFloat:padding]}
                                             views:NSDictionaryOfVariableBindings(subView)]];
        }
        else {
            [self.scrollView addConstraints:[NSLayoutConstraint
                                             constraintsWithVisualFormat:@"V:[previousView]-(padding)-[subView]"
                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                             metrics:@{@"padding": [NSNumber numberWithFloat:padding]}
                                             views:NSDictionaryOfVariableBindings(previousView, subView)]];
        }
        if( subView == lastView) {
            [self.scrollView addConstraints:[NSLayoutConstraint
                                             constraintsWithVisualFormat:@"V:[subView]-(padding)-|"
                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                             metrics:@{@"padding": [NSNumber numberWithFloat:padding]}
                                             views:NSDictionaryOfVariableBindings(previousView, subView)]];
        }
        previousView = subView;
    }
    [self.scrollView updateConstraints];
    [self.view updateConstraints];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (float)heightForView:(UIView*)view
{
    if( view.superview != self.scrollView ) return -1;
    
    for (NSLayoutConstraint *constraint in view.constraints) {
        if( constraint.firstAttribute == NSLayoutAttributeHeight && constraint.secondItem == nil)
        {
            return constraint.constant;
        }
    }
    return -1;
}

- (void)setHeight:(float)height forView:(UIView*)view animated:(BOOL)animate
{
    if( view.superview != self.scrollView ) return;
    
    for (NSLayoutConstraint *constraint in view.constraints) {
        if( constraint.firstAttribute == NSLayoutAttributeHeight && constraint.secondItem == nil && constraint.firstItem == view)
        {
            if( animate )
            {
                [UIView animateWithDuration:.2
                                 animations:^{
                                     constraint.constant = height;
                                     [self.scrollView layoutIfNeeded];
                                 }];
            }
            else
            {
                constraint.constant = height;
                [self.scrollView layoutIfNeeded];
            }
            
            return;
        }
    }
}

@end
