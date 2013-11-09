//
//  TestViewController.m
//  StackPanelLayout
//
//  Created by Fredrik Göransson on 11/4/13.
//  Copyright (c) 2013 Forefront Consulting Group AB. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()
{
    NSString *loremIpsum;
    int nextItem;
}
@property (nonatomic, strong) LabelCollectionViewCell *sizingCell;
@property (nonatomic, strong) NSMutableArray *items;
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
    
    // get a cell as template for sizing
    self.padding = 20;
    nextItem = 10;
    loremIpsum = @"The dreams of yesterday are the hopes of today and the reality of tomorrow Here men from the planet Earth first set foot upon the Moon July 1969 AD We came in peace for all mankind";
    
    self.items = [[NSMutableArray alloc] initWithArray:[[loremIpsum componentsSeparatedByString:@" "] subarrayWithRange:(NSRange){0, nextItem}]];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    CGSize size = [self.collectionView.collectionViewLayout collectionViewContentSize];
    [self setHeight:size.height + 50 forView:self.collectionView.superview animated:YES];
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

#pragma mark - Collection View Data Source

- (int)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.items count];
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LabelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LabelCell" forIndexPath:indexPath];
    cell.titleLabel.text = [self.items objectAtIndex:indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if( self.sizingCell == nil)
    {
        UINib *cellNib = [UINib nibWithNibName:@"LabelCollectionViewCell" bundle:nil];
        [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"LabelCell"];
        self.sizingCell = [[cellNib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    }
    LabelCollectionViewCell *cell = self.sizingCell;
    
    cell.titleLabel.text = [self.items objectAtIndex:indexPath.row];
    CGSize size =  [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 15, 10, 15);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *item = [self.items objectAtIndex:indexPath.row];
    [self.items removeObject:item];
    [self.collectionView reloadData];
    nextItem--;
    
    CGSize size = [self.collectionView.collectionViewLayout collectionViewContentSize];
    [self setHeight:size.height +50 forView:self.collectionView.superview animated:YES];
}

- (IBAction)addFiveItemsTapped:(id)sender {
    NSArray *loremIpsumComponents = [loremIpsum componentsSeparatedByString:@" "];
    int range = MIN(5, (int)([loremIpsumComponents count] - nextItem));
    if(range <= 0) return;
    NSArray *newItems = [[loremIpsum componentsSeparatedByString:@" "] subarrayWithRange:(NSRange){nextItem, range}];
    
    [self.items addObjectsFromArray:newItems];
    [self.collectionView reloadData];
    nextItem += 5;
    
    CGSize size = [self.collectionView.collectionViewLayout collectionViewContentSize];
    [self setHeight:size.height + 50 forView:self.collectionView.superview animated:YES];
}
@end
