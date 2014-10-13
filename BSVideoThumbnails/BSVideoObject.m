//
//  BSVideoObject.m
//  BSVideoThumbnails
//
//  Created by iBlacksus on 10/13/14.
//  Copyright (c) 2014 Borodutch Studio. All rights reserved.
//

#import "BSVideoObject.h"

@implementation BSVideoObject

- (id)initWithUrl:(NSString *)url
{
    if (self = [super init]) {
        _videoUrl = url;
    }
    
    return self;
}

+ (BSVideoObject *)objectWithURL:(NSString *)url
{
    return [[BSVideoObject alloc] initWithUrl:url];
}

@end
