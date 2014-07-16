//
//  IDWP_FTP_Uploader.h
//  wallpaperupload
//
//  Created by Stephen Parente on 7/15/14.
//  Copyright (c) 2014 Ingenuity Design. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDWP_FTP_Uploader : NSObject

@property CFWriteStreamRef FTPConnection;

+ (IDWP_FTP_Uploader*) initWithConnectionStrings: (NSString*) hostname
           username: (NSString*)username
           password: (NSString*)password;

- (void) close;
- (id) init;

- (void) open;

- (BOOL) checkStreamIsOpen;
- (BOOL) streamIsOpening;
- (void) onStreamOpen;

@end
