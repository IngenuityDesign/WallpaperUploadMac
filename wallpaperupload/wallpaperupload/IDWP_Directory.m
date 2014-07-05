//
//  IDWP_Directory.m
//  wallpaperupload
//
//  Created by Stephen Parente on 7/4/14.
//  Copyright (c) 2014 Ingenuity Design. All rights reserved.
//

#import "IDWP_Directory.h"

@implementation IDWP_Directory

@synthesize fileList;

+ (IDWP_Directory*) directory {
    return [[self alloc] init];
}

- (NSMutableArray *) enumerateImageFiles: (id) directoryPath {
    NSURL * directoryUrl = [NSURL URLWithString:directoryPath];
    
    if (!directoryUrl) {
        //this means we didn't get one
        //[directoryUrl dealloc];
        
        return nil;
    }
    
    NSMutableArray * fileArray = [[NSMutableArray alloc] init];
    NSFileManager * fileManager = [[NSFileManager alloc] init];
    NSArray * keys = [NSArray arrayWithObject:NSURLIsDirectoryKey];
    
    NSDirectoryEnumerator * enumerator = [fileManager
                                         enumeratorAtURL:directoryUrl
                                         includingPropertiesForKeys:keys
                                         options:0
                                         errorHandler:^(NSURL *url, NSError *error) {
                                             // Handle the error.
                                             // Return YES if the enumeration should continue after the error.
                                             return YES;
                                         }];
    
    for (NSURL *url in enumerator) {
        NSError *error;
        NSNumber *isDirectory = nil;
        if (! [url getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:&error]) {
            // handle error
        }
        else if (! [isDirectory boolValue]) {
            // No error and it’s not a directory; do something with the file
            IDWP_File* aFile = [IDWP_File initializeWithPath: url];
            if ([aFile isValidWallpaper])
                [fileArray addObject:aFile];
        }
    }
    //[fileArray autorelease];
    NSLog(@"%lu", (unsigned long)[fileArray count]);

    [self setFileList:fileArray];
    return fileArray;
};

- (void) processImages {
    NSImage* image;
    
    
}

- (id) init {
    if (self = [super init] ) {

    }
    return self;
}

- (void) dealloc {
    
}

@end
