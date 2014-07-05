//
//  IDWP_File.h
//  wallpaperupload
//
//  Created by Stephen Parente on 7/4/14.
//  Copyright (c) 2014 Ingenuity Design. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDWP_File : NSObject

@property (
           retain,
           getter=getFilepath, setter=setFilepath:,
           readwrite
           ) NSURL* filepath;

+ (IDWP_File*) initializeWithPath: (NSURL*) filePath;

@end
