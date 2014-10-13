//
//  BSVideoCell.h
//  BSVideoThumbnails
//
//  Created by iBlacksus on 10/13/14.
//  Copyright (c) 2014 Borodutch Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSCellWithObject.h"
#import "BSVideoObject.h"

static NSString *const newImageInCacheNotification = @"newImageInCacheNotification";

@interface BSVideoCell : BSCellWithObject

@property (nonatomic) BSVideoObject *object;

+ (CGFloat)height;

@end
