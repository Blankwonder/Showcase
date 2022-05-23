//
//  ViewController.m
//  Showcase
//
//  Created by Blankwonder on 2022/5/23.
//

#import "ViewController.h"


@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    IBOutlet UIImageView *_imageView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage *savedImage = [UIImage imageWithContentsOfFile:self.imagePath];
    
    if (savedImage) {
        if (savedImage.size.width > savedImage.size.height) {
            savedImage = [[UIImage alloc] initWithCGImage:savedImage.CGImage
                                                    scale:savedImage.scale
                                              orientation:UIImageOrientationRight];
        }
        
        _imageView.image = savedImage;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!_imageView.image) {
        [self selectImage];
    }
}

- (IBAction)selectImage {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:^{}];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info {

    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    if (image.size.width > image.size.height) {
        image = [[UIImage alloc] initWithCGImage:image.CGImage
                                           scale:image.scale
                                     orientation:UIImageOrientationRight];
    }
    
    _imageView.image = image;
    [UIImagePNGRepresentation(image) writeToFile:self.imagePath atomically:YES];
    
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (NSString *)imagePath {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"image"];
}

@end
