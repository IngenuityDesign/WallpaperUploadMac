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

+ (IDWP_FTP_Error*) initWithError:(CFStreamError) error {
    IDWP_FTP_Error *x = [[self alloc] init];
    [x setError:error];
    return x;
}

- (void) getOSError {
    if ([self error].domain == kCFStreamErrorDomainPOSIX) {
        // Interpret myErr.error as a UNIX errno.
        
    } else if ([self error].domain == kCFStreamErrorDomainMacOSStatus) {
        // Interpret myErr.error as a MacOS error code.
        OSStatus macError = (OSStatus)[self error].error;
        
        // Check other error domains.
    }

}

- (NSString*) description {
    [self getOSError];
    return @"";
    
}

@end
