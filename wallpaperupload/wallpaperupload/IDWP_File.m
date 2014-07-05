//
//  IDWP_File.m
//  wallpaperupload
//
//  Created by Stephen Parente on 7/4/14.
//  Copyright (c) 2014 Ingenuity Design. All rights reserved.
//

#import "IDWP_File.h"

@implementation IDWP_File

@synthesize filepath;

+ (IDWP_File*) initializeWithPath: (id) filePath {
    
    IDWP_File* newInstance = [[self alloc] init];
    [newInstance setFilepath:filePath];
    return newInstance;
    
};

- (id) init {
    if ( self = [super init]) {
    
    }
    return self;
}

@end
