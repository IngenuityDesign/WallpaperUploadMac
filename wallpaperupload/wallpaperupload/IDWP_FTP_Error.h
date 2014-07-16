//
//  IDWP_FTP_Error.h
//  wallpaperupload
//
//  Created by Stephen Parente on 7/15/14.
//  Copyright (c) 2014 Ingenuity Design. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDWP_FTP_Error : NSObject

@property CFErrorRef error;

- (NSString *)toErrorMessage;
- (NSInteger) getErrno;

+ (IDWP_FTP_Error*) initWithError:(CFErrorRef) error;
- (id) init;

- (NSNumber*) getStatusCode;

@end
