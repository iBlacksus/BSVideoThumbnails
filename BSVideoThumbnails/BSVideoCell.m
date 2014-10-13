//
//  BSVideoCell.m
//  BSVideoThumbnails
//
//  Created by iBlacksus on 10/13/14.
//  Copyright (c) 2014 Borodutch Studio. All rights reserved.
//

#import "BSVideoCell.h"
#import "SDImageCache.h"
#import <AVFoundation/AVFoundation.h>

static CGFloat const ratio = 1.3333;

@interface BSVideoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation BSVideoCell

#pragma mark - Accessors -

- (void)setObject:(BSVideoObject *)object
{
    [super setObject:object];
    [self configure];
}

#pragma mark - Public methods -

+ (CGFloat)height
{
    return [UIScreen mainScreen].bounds.size.width * ratio;
}

#pragma mark - General methods -

- (void)configure
{
    self.photoImageView.alpha = 0.f;
    
    [self loadVideoWithAnimation];
}

- (void)loadVideoWithAnimation
{
    NSString *imageCacheKey = [[self.object.videoUrl lastPathComponent] stringByDeletingPathExtension];
    
    [[SDImageCache sharedImageCache] queryDiskCacheForKey:imageCacheKey done:^(UIImage *image, SDImageCacheType cacheType) {
        if (image) {
            [self setImageForVideo:image];
        } else {
            [self.activityIndicator startAnimating];
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL URLWithString:self.object.videoUrl] options:nil];
                AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
                generator.appliesPreferredTrackTransform = YES;
                NSError *error;
                CGImageRef imageRef = [generator copyCGImageAtTime:CMTimeMake(1, 2) actualTime:NULL error:&error];
                if (!error) {
                    UIImage *image = [[UIImage alloc] initWithCGImage:imageRef];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[SDImageCache sharedImageCache] storeImage:image forKey:imageCacheKey];
                        [[NSNotificationCenter defaultCenter] postNotificationName:newImageInCacheNotification object:nil];
                        [self setImageForVideo:image];
                    });
                }
            });
        }
    }];
}

- (void)setImageForVideo:(UIImage *)image
{
    [self.activityIndicator stopAnimating];
    self.photoImageView.image = image;
    [UIView animateWithDuration:0.25 animations:^{
        self.photoImageView.alpha = 1.f;
    }];
}

@end
