//
//  TestViewController.h
//  StackPanelLayout
//
//  Created by Fredrik Göransson on 11/4/13.
//  Copyright (c) 2013 Forefront Consulting Group AB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StackPanelViewController.h"
#import "LabelCollectionViewCell.h"

@interface TestViewController : StackPanelViewController<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

- (IBAction)expandCollapseTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
- (IBAction)addFiveItemsTapped:(id)sender;

@end
