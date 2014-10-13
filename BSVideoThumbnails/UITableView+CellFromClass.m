//
//  UITableView+CellFromClass.m
//
//  Created by iBlacksus.
//  Copyright (c) 2014 Borodutch Studio. All rights reserved.
//

#import "UITableView+CellFromClass.h"

@implementation UITableView (CellFromClass)

- (BSCellWithObject *)cellFromClass:(Class)class withObject:(NSObject * )object
{
    NSString *identifier = NSStringFromClass(class);
    
    BSCellWithObject *cell = [self dequeueReusableCellWithIdentifier:identifier];
    if (object) {
        cell.object = object;
    }
    
    return cell;
}

@end
