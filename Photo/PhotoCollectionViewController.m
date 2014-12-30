//
//  PhotoCollectionViewController.m
//  Photo
//
//  Created by Cyrilshanway on 2014/12/26.
//  Copyright (c) 2014年 Cyrilshanway. All rights reserved.
//

#import "PhotoCollectionViewController.h"
#import "PhotoCollectionHeaderView.h"
#import "PhotoViewController.h"
#import <Social/Social.h>

//UICollectionViewDelegate
//定義了能夠在集合視圖中處理項目的選擇及項目凸顯的方式
//UICollectionViewDataSource
//提供集合視圖的資料
@interface PhotoCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray *imageArray;
    
    //按下share->複選模式，可選取多張照片分享
    BOOL shareEnable;
    //儲存被選取照片的陣列
    NSMutableArray *selectedPhotos;
}

@end

@implementation PhotoCollectionViewController


//static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
     NSArray*oneImageArray = [NSArray arrayWithObjects:@"img6.jpg", @"img7.jpg", @"img8.jpg", @"img9.jpg", @"img10.jpg", @"img11.jpg", nil];
    NSArray *twoImgaeArray = [NSArray arrayWithObjects:@"pic1.jpg", @"pic2.jpg",@"pic3.jpg", nil];
    // Do any additional setup after loading the view.
    imageArray = [NSArray arrayWithObjects:oneImageArray,  twoImgaeArray, nil];
    
    //增加區塊間的空間(UIEdgeInsetsMake(top, left, buttom, right))<區塊邊距>
    UICollectionViewFlowLayout *collectionViewLayout =  (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
    
    selectedPhotos = [[NSMutableArray alloc] initWithCapacity:0];
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
//回傳每一區塊圖片數量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    
    return [[imageArray objectAtIndex:section] count];
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
    //先利用區塊的編號(indexPath.section)來取得陣列，
    //再從那區塊陣列中取得某個項目
    photoImageView.image = [UIImage imageNamed:[imageArray[indexPath.section] objectAtIndex:indexPath.row]];
    cell.backgroundView  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo-frame.png"]];
    
    //顯示項目已經被選取狀態
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo-frame-selected.png"]];
    
    
    return cell;
}

//optional
//回傳在集合視圖中區塊的數量
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [imageArray count];
}

//optional
//標頭與註腳
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        PhotoCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        NSString *title = [[NSString alloc] initWithFormat:@"Photo Group %li", indexPath.section +1];
        headerView.titleLabel.text = title;
        
        reusableview = headerView;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        
        reusableview = footerview;
    }
    
    return reusableview;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showPhotoDetail"]) {
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        PhotoViewController *destVC = segue.destinationViewController;
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
        destVC.photoImageName = [imageArray[indexPath.section] objectAtIndex:indexPath.row];
        [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
    }
}

//只希望在單選時觸發它
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if (shareEnable) {
        return NO;
    }else{
        return YES;
    }
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (shareEnable) {
        //使用indexPath判斷被選取的項目
        NSString *selectedPhoto = [imageArray[indexPath.section] objectAtIndex:indexPath.row];
        //將被選取的項目加入陣列中
        [selectedPhotos addObject:selectedPhoto];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (shareEnable) {
        NSString *deSelectedPhoto = [imageArray[indexPath.section] objectAtIndex:indexPath.row];
        [selectedPhotos removeObject:deSelectedPhoto];
    }
}

- (IBAction)shareButtonTapped:(id)sender {
    
    if (shareEnable) {
        //將選取的圖片分享到fb
        //facebook組合器(composer)
        //ios SDK允許app可以透過SLComposeViewController類別來將社群分享功能組合在一起
        if ([selectedPhotos count] > 0) {
            //檢查使用者裝置是否裝Facebook
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
                SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                
                [controller setInitialText:@"Check out my photos!"];
                
                for (NSString *photoShare in selectedPhotos) {
                    [controller addImage:[UIImage imageNamed:photoShare]];
                }
                //將組合器呈現在畫面上
                [self presentViewController:controller animated:YES completion:nil];
            }
            
        }
        //圖片上傳後，就取消之前被選取的項目，把點選的項目array清空
        //取消項目的選取
        for (NSIndexPath *indexPath in self.collectionView.indexPathsForSelectedItems) {
            [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
        }
        
        //從selectedPhotos陣列中將項目移除
        [selectedPhotos removeAllObjects];
        
        //切換到單選模式，並改變按鈕標題
        //將分享模式改為NO
        shareEnable = NO;
        self.collectionView.allowsMultipleSelection = NO;
        self.shareButton.title = @"Share";
        [self.shareButton setStyle:UIBarButtonItemStylePlain];
        
        } else {
            
        //如果原本的分享模式被關掉，在把app變成分享模式，並允許複選動作，也把標題改為Upload
        //改變shareEnabled為YES並且將按紐文字改為Upload
        shareEnable = YES;
        self.collectionView.allowsMultipleSelection = YES;
        self.shareButton.title = @"Upload";
        [self.shareButton setStyle:UIBarButtonItemStyleDone];
    }
}
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
