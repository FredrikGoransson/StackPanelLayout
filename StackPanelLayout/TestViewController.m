//
//  TestViewController.m
//  StackPanelLayout
//
//  Created by Fredrik Göransson on 11/4/13.
//  Copyright (c) 2013 Forefront Consulting Group AB. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

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
    self.padding = 20;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)expandCollapseTapped:(id)sender {
    
    // NOTE: Yes, this is ugly :)
    UIButton *button = (UIButton*)sender;
    if( [button.titleLabel.text isEqualToString:@"[-]"]) {
        [self setHeight:50 forView:button.superview animated:YES];
        button.titleLabel.text = @"[+]";
    }
    else {
        [self setHeight:300 forView:button.superview animated:YES];
        button.titleLabel.text = @"[-]";
    }
}
@end
