//
//  IDWP_FTP_Error.m
//  wallpaperupload
//
//  Created by Stephen Parente on 7/15/14.
//  Copyright (c) 2014 Ingenuity Design. All rights reserved.
//

#import "IDWP_FTP_Error.h"

@implementation IDWP_FTP_Error

@synthesize error;

- (id) init {
    if (self = [super init] ) {
        
    }
    return self;
}

+ (IDWP_FTP_Error*) initWithError:(CFErrorRef) error {
    IDWP_FTP_Error *x = [[self alloc] init];
    [x setError:error];
    return x;
}

- (NSInteger) getErrno {
    
    CFIndex i = CFErrorGetCode([self error]);
    return i;
    
}

- (NSString*) toErrorMessage {
    NSLog(@"Error code: %ld", (long)[[self getStatusCode] integerValue] );
    return CFBridgingRelease(CFErrorCopyDescription([self error]));
}

-(NSNumber*)getStatusCode {
    CFDictionaryRef dict = CFErrorCopyUserInfo([self error]);
    if (CFDictionaryContainsKey(dict, kCFFTPStatusCodeKey)) {
        CFStringRef x = CFDictionaryGetValue(dict, kCFFTPStatusCodeKey);
        NSString* statusCodeString = ((__bridge NSString*)(x));
        return [NSNumber numberWithInt:[statusCodeString integerValue]];
    }
    return [NSNumber numberWithInt:0];
}

@end
