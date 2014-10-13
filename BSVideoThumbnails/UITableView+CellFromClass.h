//
//  UITableView+CellFromClass.h
//
//  Created by iBlacksus.
//  Copyright (c) 2014 Borodutch Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSCellWithObject.h"

@interface UITableView (CellFromClass)

- (BSCellWithObject *)cellFromClass:(Class)class withObject:(NSObject * )object;

@end
