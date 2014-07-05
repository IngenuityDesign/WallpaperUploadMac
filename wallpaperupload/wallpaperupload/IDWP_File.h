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

@property NSString * month;
@property NSString * year;
@property NSString * type;
@property NSString * subtype;
@property NSString * width;
@property NSString * height;

@property NSString * filename;
@property NSString * extension;


+ (IDWP_File*) file;
+ (IDWP_File*) initializeWithPath: (NSURL*) filePath;

- (void) parseFilename;
- (BOOL) isJPG;
- (BOOL) isValidWallpaper;

@end
