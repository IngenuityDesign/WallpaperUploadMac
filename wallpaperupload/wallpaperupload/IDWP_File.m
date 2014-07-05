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
@synthesize month;
@synthesize year;
@synthesize type;
@synthesize subtype;
@synthesize height;
@synthesize width;

@synthesize filename;
@synthesize extension;

+ (IDWP_File*) initializeWithPath: (id) filePath {
    
    IDWP_File* newInstance = [IDWP_File file];
    [newInstance setFilepath:filePath];
    [newInstance parseFilename];
    return newInstance;
    
};

+ (IDWP_File*) file {
    IDWP_File* file = [[IDWP_File alloc] init];
    //return [file autorelease];
    return file;
}

- (id) init {
    if ( self = [super init]) {
        
    }
    return self;
}

- (NSString*) description {
    return [NSString stringWithFormat: @"File dump: ext: %@ name: %@",
            [self extension],
            [self filename]];
    
}

- (void) parseFilename {
    
    /*
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(?P<month>[a-z]+)(?P<year>[0-9]{2,4})_(?P<type>[^_]+)_(?P<subtype>[^_]+)_(?P<width>[0-9]{3,4})x(?P<height>[0-9]{3,4})"
                                                                           options:NSRegularExpressionCaseInsensitivez
                                                                             error:&error];
    */
    NSString* tempPath = [[self getFilepath] absoluteString];
    [self setFilename:[tempPath lastPathComponent]];
    [self setExtension:[tempPath pathExtension]];
        
}

@end
