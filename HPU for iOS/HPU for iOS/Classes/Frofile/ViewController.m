//
//  ViewController.m
//  HPU for iOS
//
//  Created by 王晓睿 on 15/7/17.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//

#import "ViewController.h"
#import "ImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "ProfileCell.h"
#import "PickView.h"

#define ORIGINAL_MAX_WIDTH 640.0f

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, ImageCropperDelegate,PickViewDelegate>

@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) PickView *pickview;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)UIView *cover;
@property(nonatomic,strong)UIView *bainjiView;
@property (nonatomic,strong)UITextField *bianjiTextField;


@end

@implementation ViewController
//-(UITextField *)bianjiTextField
//{
//    if (_bianjiTextField == nil) {
//        
//    }
//    return _bianjiTextField;
//}
-(UIView *)cover
{
    if (_cover == nil) {
        _cover = [[UIView alloc]initWithFrame:self.view.window.bounds];
    
        _cover.backgroundColor = [UIColor grayColor];
        _cover.alpha = 0.5;
    }
    return _cover;
}
//-(UILabel *)nameLabel
//{
//    if (_nameLabel == nil) {
//        _nameLabel = [[UILabel alloc]init];
//        _nameLabel.size = CGSizeMake(self.view.width, 30);
//        _nameLabel.centerX = self.portraitImageView.centerX;
//        _nameLabel.centerY = self.portraitImageView.centerY + 80;
//        _nameLabel.textAlignment = NSTextAlignmentCenter;
//        _nameLabel.text = @"wallace";
//        
//    }
//    return _nameLabel;
//}
-(UIView *)topView
{
    if (_topView == nil) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 200)];
//        _topView.backgroundColor = [UIColor colorWithPatternImage:self.portraitImageView.image];
        
        
    }
    return _topView;
}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self.topView addSubview:self.portraitImageView];
    [self.topView addSubview:self.nameLabel];
    self.tableView.tableHeaderView = self.topView;
    [self loadPortrait];
}

- (void)loadPortrait {
    self.portraitImageView.image = [UIImage imageNamed:@"touxiang.png"];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
//        NSURL *portraitUrl = [NSURL URLWithString:@"http://photo.l99.com/bigger/31/1363231021567_5zu910.jpg"];
//        UIImage *protraitImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:portraitUrl]];
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            self.portraitImageView.image = protraitImg;
//        });
//    });
}

- (void)editPortrait {
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    [choiceSheet showInView:self.view];
}

#pragma mark ImageCropperDelegate
- (void)imageCropper:(ImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    self.portraitImageView.image = editedImage;
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
    }];
}

- (void)imageCropperDidCancel:(ImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
        
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 裁剪
        ImageCropperViewController *imgEditorVC = [[ImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark portraitImageView getter
- (UIImageView *)portraitImageView {
    if (!_portraitImageView) {
        CGFloat w = 100.0f; CGFloat h = w;
        CGFloat x = (self.topView.frame.size.width - w) / 2;
        CGFloat y = (self.topView.frame.size.height - h) / 2;
        _portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_portraitImageView.layer setCornerRadius:(_portraitImageView.frame.size.height/2)];
        [_portraitImageView.layer setMasksToBounds:YES];
        [_portraitImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_portraitImageView setClipsToBounds:YES];
        _portraitImageView.layer.shadowColor = [UIColor blackColor].CGColor;
        _portraitImageView.layer.shadowOffset = CGSizeMake(4, 4);
        _portraitImageView.layer.shadowOpacity = 0.5;
        _portraitImageView.layer.shadowRadius = 2.0;
        _portraitImageView.layer.borderColor = [[UIColor blackColor] CGColor];
        _portraitImageView.layer.borderWidth = 2.0f;
        _portraitImageView.userInteractionEnabled = YES;
        _portraitImageView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *portraitTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait)];
        [_portraitImageView addGestureRecognizer:portraitTap];
    }
    return _portraitImageView;
}
#pragma mark - tableView datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    ProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"ProfileCell" owner:self options:nil]lastObject];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.titleLabel.textAlignment = NSTextAlignmentLeft;
    cell.descLabel.textAlignment = NSTextAlignmentRight;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    cell.separatorInset = UIEdgeInsetsMake(0, 160, 0, 160);
    switch (indexPath.row) {
        case 0:
        {
            cell.titleLabel.text = @"昵称";
            
        }
            break;
        case 1:
        {
            cell.titleLabel.text = @"院系";
         
        }
            break;

        case 2:
        {
            cell.titleLabel.text = @"性别";
           
        }
            break;

        case 3:
        {
            cell.titleLabel.text = @"生日";
         
        }
            break;

        case 4:
        {
            cell.titleLabel.text = @"所在地";
           
        }
            break;

            
        default:
            break;
    }
    
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark - UITableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     _indexPath=indexPath;
    
    if (indexPath.row > 0) {
    
    [_pickview remove];
    ProfileCell *cell=(ProfileCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    if ([cell.titleLabel.text isEqualToString:@"生日"]) {
        NSDate *date=[NSDate dateWithTimeIntervalSinceNow:9000000];
        _pickview=[[PickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
    }else if([cell.titleLabel.text isEqualToString:@"院系"]){
        _pickview=[[PickView alloc] initPickviewWithPlistName:cell.titleLabel.text isHaveNavControler:NO];
    }else if([cell.titleLabel.text isEqualToString:@"所在地"]){
        _pickview=[[PickView alloc] initPickviewWithPlistName:cell.titleLabel.text isHaveNavControler:NO];
    }else if([cell.titleLabel.text isEqualToString:@"性别"]){
        _pickview=[[PickView alloc] initPickviewWithPlistName:cell.titleLabel.text isHaveNavControler:NO];
    }
    _pickview.delegate=self;
    
    [_pickview show];

    }else{
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(40, 150, self.view.width - 2 * 40, 180)];
        self.bainjiView = view;
        view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        // titlelabel
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((view.width - 120) / 2, 10, 120, 30)];
        titleLabel.text = @"编辑昵称";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [view addSubview:titleLabel];
        // textField
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.frame) + 10, view.width - 20, 40)];
        self.bianjiTextField = textField;
        textField.backgroundColor = [UIColor whiteColor];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.placeholder = @"请输入昵称";
        [textField becomeFirstResponder];
        [view addSubview:textField];
        // 取消 按钮
        UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(textField.frame), CGRectGetMaxY(textField.frame) + 40, (view.width - 3 *20) / 2, 35)];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"button_selected.png"] forState:UIControlStateHighlighted];
        [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:cancelBtn];
        // 确定 按钮
        UIButton *finishBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cancelBtn.frame) + 20, CGRectGetMaxY(textField.frame) + 40, (view.width - 3 *20) / 2, 35)];
        [finishBtn setTitle:@"确定" forState:UIControlStateNormal];
        
        [finishBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [finishBtn setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
        [finishBtn setBackgroundImage:[UIImage imageNamed:@"button_selected.png"] forState:UIControlStateHighlighted];
        [finishBtn addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:finishBtn];

        [self.view.window addSubview:self.cover];
        [self.view.window addSubview:view];
    }
        
}

- (void)cancel
{
    [self.cover removeFromSuperview];
    [self.bainjiView removeFromSuperview];
}

- (void)finish
{
     ProfileCell * cell=(ProfileCell *)[self.tableView cellForRowAtIndexPath:_indexPath];
    cell.descLabel.text = self.bianjiTextField.text;
    [self cancel];
}

#pragma mark ZhpickVIewDelegate

-(void)toobarDonBtnHaveClick:(PickView *)pickView resultString:(NSString *)resultString{
        ProfileCell * cell=(ProfileCell *)[self.tableView cellForRowAtIndexPath:_indexPath];
    cell.descLabel.text=resultString;
//    [self.cover removeFromSuperview];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}

@end
