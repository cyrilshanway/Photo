//
//  PhotoCollectionViewController.m
//  Photo
//
//  Created by Cyrilshanway on 2014/12/26.
//  Copyright (c) 2014年 Cyrilshanway. All rights reserved.
//

#import "PhotoCollectionViewController.h"

@interface PhotoCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray *imageArray;
}

@end

@implementation PhotoCollectionViewController


//static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    imageArray = [NSArray arrayWithObjects:@"img1.png", @"img2.png", @"img3.png", @"img4.png", @"img5.png", nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>


//require
//回傳圖片數量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    //return 0;
    return [imageArray count];
}

//require
//提供資料給集合視圖的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //定義一個cell識別碼
    static NSString *identifier = @"Cell";
    //要求集合視圖使用那個識別碼來排列一個可重複使用的cell
    //dequeueReusableCellWithReuseIdentifier:方法會自動建立一個cell，
    //或者從再利用佇列(re-use queue)回傳一個cell給你
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    //利用標籤值來取得圖像視圖，並將圖片指定給它
    UIImageView *photoImageView = (UIImageView *)[cell viewWithTag:100];
    
    photoImageView.backgroundColor = [UIColor redColor];
    photoImageView.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
    cell.backgroundView  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo-frame.png"]];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
