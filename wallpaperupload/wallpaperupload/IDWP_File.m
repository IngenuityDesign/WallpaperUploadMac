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

@synthesize nameHasBeenParsed;

@synthesize filename;
@synthesize extension;

@synthesize imageIsCreated;
@synthesize imageURL;

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
        [self setHeight:[NSNumber numberWithInt:0]];
        [self setWidth: [NSNumber numberWithInt:0]];
        [self setNameHasBeenParsed:NO];
    }
    return self;
}

- (NSString*) description {
    return [NSString stringWithFormat: @"File dump: ext: %@ name: %@",
            [self extension],
            [self filename]];
    
}

- (BOOL) isValidWallpaper {
    if (![self isJPG]) return NO;
    if (![self month] && [self height]) return NO;
    return YES;
    
}

- (BOOL) isJPG {
    if (
        [[self extension] caseInsensitiveCompare:@"jpg"] == NSOrderedSame ||
        [[self extension] caseInsensitiveCompare:@"jpeg"] == NSOrderedSame
        )
    {
        return YES;
    }
    return NO;
}

- (void) parseFilename {
    
    if (![self nameHasBeenParsed]) {
    
        NSString* tempPath = [[self getFilepath] absoluteString];
        [self setFilename:[tempPath lastPathComponent]];
        [self setExtension:[tempPath pathExtension]];
        
        if ([self isJPG]) {
            

            //NSString *searchedString = [[self filename] stringByDeletingPathExtension];
            NSString *searchedString = @"July2014_blue_simple_1366x768";
            NSRange searchedRange = NSMakeRange(0, [searchedString length]);
            NSString *pattern = @"([a-zA-Z]+)([0-9]{2,4})_([^_]+)_([^_]+)_([0-9]{3,4})x([0-9]{3,4})";
            NSError *error = nil;
            
            NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
            
            if (error == nil) {
                NSTextCheckingResult *match = [regex firstMatchInString:searchedString options:0 range: searchedRange];
                [self setMonth:[searchedString substringWithRange:[match rangeAtIndex:1]]];
                [self setYear:[searchedString substringWithRange:[match rangeAtIndex:2]]];
                
                [self setType:[searchedString substringWithRange:[match rangeAtIndex:3]]];
                [self setSubtype:[searchedString substringWithRange:[match rangeAtIndex:4]]];
                
                int a = [[searchedString substringWithRange:[match rangeAtIndex:5]] intValue];
                int b = [[searchedString substringWithRange:[match rangeAtIndex:6]] intValue];
                
                [self setWidth: [NSNumber numberWithInt:a]];
                [self setHeight:[NSNumber numberWithInt:b]];
                
            } else {
                NSLog(@"<Warning>: File is not named properly: %@ #regex #parsing", tempPath);
            }

                
        }
        
        [self setNameHasBeenParsed:YES];
        
    }
    
}

- (NSURL*) createSizedImage {
    if (![self imageIsCreated]) {
        if (![self nameHasBeenParsed]) [self parseFilename];
        [self setImageIsCreated:YES];
        
        NSString* tmp = NSTemporaryDirectory();
        tmp = [tmp stringByAppendingString:[self filename]];
        
        NSLog(@"%@", tmp);
        
        NSImage* temporaryImage = [[NSImage alloc] initByReferencingURL:[self getFilepath]];
        
        if ([temporaryImage isValid]) {
            NSSize filesize = NSMakeSize( [[self width] floatValue], [[self height] floatValue] );
            
            [temporaryImage setSize:filesize];
            
            NSBitmapImageRep *imgRep = [[temporaryImage representations] objectAtIndex: 0];
            NSData *data = [imgRep representationUsingType: NSJPEGFileType properties: nil];
            [data writeToFile: tmp atomically: NO];
            
            NSURL* url = [[NSURL alloc] initFileURLWithPath:tmp];
            [self setImageURL: url];
            [self setImageIsCreated: YES];
            return url;
        } else {
            return nil;
        }
    } else {
        return [self imageURL];
    }
    
}

@end
