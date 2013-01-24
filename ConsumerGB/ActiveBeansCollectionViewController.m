//
//  ActiveBeansCollectionViewController.m
//  ConsumerGB
//
//  Created by Srikanth on 1/24/13.
//  Copyright (c) 2013 GreenBeans. All rights reserved.
//

#import "ActiveBeansCollectionViewController.h"

@interface ActiveBeansCollectionViewController ()

@end

@implementation ActiveBeansCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_beans count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BeanCell" forIndexPath:indexPath];

    return myCell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
