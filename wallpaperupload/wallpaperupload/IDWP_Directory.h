//
//  IDWP_Directory.h
//  wallpaperupload
//
//  Created by Stephen Parente on 7/4/14.
//  Copyright (c) 2014 Ingenuity Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDWP_File.h"

@interface IDWP_Directory : NSObject

@property (retain) NSString* path;

- (id) init;
- (void) dealloc;

- (IDWP_File*) enumerateImageFiles: (NSString *) directoryPath;

@end
