//
//  IDWP_FTP_Uploader.m
//  wallpaperupload
//
//  Created by Stephen Parente on 7/15/14.
//  Copyright (c) 2014 Ingenuity Design. All rights reserved.
//

#import "IDWP_FTP_Uploader.h"
#import "IDWP_FTP_Error.h"


@implementation IDWP_FTP_Uploader

@synthesize FTPConnection;

- (id) init {
    if (self = [super init] ) {
        
    }
    return self;
}

- (void) close {
    CFRelease(FTPConnection);
}

+ (IDWP_FTP_Uploader*) initWithConnectionStrings: (NSString*) hostname
           username: (NSString*)username
           password: (NSString*)password {
    
    CFStringRef hostnameCFString = (__bridge CFStringRef) hostname;
    CFStringRef usernameCFString = (__bridge CFStringRef) username;
    CFStringRef passwordCFString = (__bridge CFStringRef) password;
    
    CFURLRef url = CFURLCreateWithString(NULL, hostnameCFString, NULL);
    
    CFWriteStreamRef FTPConnection = CFWriteStreamCreateWithFTPURL (NULL, url);
    
    CFWriteStreamSetProperty(FTPConnection, kCFStreamPropertyFTPUserName, usernameCFString);
    CFWriteStreamSetProperty(FTPConnection, kCFStreamPropertyFTPUsePassiveMode, kCFBooleanTrue);
    CFWriteStreamSetProperty(FTPConnection, kCFStreamPropertyFTPPassword, passwordCFString);
    
    IDWP_FTP_Uploader* instance = [[self alloc] init];
    
    CFRelease(url);
    
    [instance setFTPConnection:FTPConnection];
    return instance;
    
    
}

- (void) onStreamOpen {
    
}

- (void) open {
    CFWriteStreamOpen([self FTPConnection]);
    
    NSLog(@"Opening");
    
    CFStreamClientContext context = {
        0,
        //(__bridge void *)(self),
        (void*) CFBridgingRetain(self),
        NULL,
        NULL,
        NULL
    };
    
    
    CFWriteStreamSetClient([self FTPConnection], kCFStreamEventEndEncountered, MyCallBack, &context );
    CFWriteStreamSetClient([self FTPConnection], kCFStreamStatusError, MyCallBack, &context );
    CFWriteStreamSetClient([self FTPConnection], kCFStreamStatusAtEnd, MyCallBack, &context );
    CFWriteStreamSetClient([self FTPConnection], kCFStreamEventErrorOccurred, MyCallBack, &context );
    
    CFWriteStreamScheduleWithRunLoop([self FTPConnection], CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);

    
}

- (BOOL) streamIsOpening {
    CFStreamStatus status = CFWriteStreamGetStatus([self FTPConnection]);
    
    if (status == kCFStreamStatusOpening) {
        return YES;
    }
    return NO;
    
}

- (BOOL) checkStreamIsOpen {
    
    CFStreamStatus status = CFWriteStreamGetStatus([self FTPConnection]);
    if (status == kCFStreamStatusOpen) {
        NSLog(@"FTP is open");
        return YES;
    } else {
        NSLog(@"FTP is probably closed");
        return NO;
    }

}

- (IDWP_FTP_Error*) errorFromCFStreamError:(CFStreamError) error {
    return [IDWP_FTP_Error initWithError:error];
}

void static MyCallBack (CFWriteStreamRef stream,CFStreamEventType eventType,void *clientCallBackInfo) {
    
    IDWP_FTP_Uploader *self = CFBridgingRelease(clientCallBackInfo);
    
    
    NSLog(@"in call back");
    
    switch (eventType)
    {
        case kCFStreamEventEndEncountered:
        {
            NSLog(@"in CallBack: kCFStreamEventEndEncounteredd");
            CFWriteStreamClose(stream);
            break;
        }
        case kCFStreamEventErrorOccurred:
        {
            NSLog(@"in CallBack: kCFStreamEventErrorOccurred");
            CFStreamError error = CFWriteStreamGetError(stream);
            NSLog([self errorFromCFStreamError:error]);
            //NSLog(@"%d",[[self errorFromCFStreamError:error] code] );
            break;
            
        }
        case kCFStreamEventCanAcceptBytes:
        {
            NSLog(@"in CallBack: kCFStreamEventCanAcceptBytes, ");
            
            
        }
        case kCFStreamEventNone:
        {
            NSLog(@"in CallBack: kCFStreamEventNone");
            break;
        }
        case kCFStreamEventOpenCompleted:
        {
            NSLog(@"in CallBack: kCFStreamEventNone");
            break;
        }
    }
    

    
}

@end
