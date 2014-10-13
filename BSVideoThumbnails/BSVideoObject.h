//
//  BSVideoObject.h
//  BSVideoThumbnails
//
//  Created by iBlacksus on 10/13/14.
//  Copyright (c) 2014 Borodutch Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSVideoObject : NSObject

@property (nonatomic, readonly) NSString *videoUrl;

- (id)initWithUrl:(NSString *)url;

+ (BSVideoObject *)objectWithURL:(NSString *)url;

@end
