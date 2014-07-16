//
//  IDWP_AppDelegate.h
//  wallpaperupload
//
//  Created by Stephen Parente on 7/4/14.
//  Copyright (c) 2014 Ingenuity Design. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "IDWP_Directory.h"
#import "IDWP_File.h"
#import "IDWP_FTP_Uploader.h"

@interface IDWP_AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (retain) IBOutlet NSTextField* IDWP_FolderPathTextView;

//FTP Fields

@property (retain) IBOutlet NSTextField* IDWP_FTPHostname;
@property (retain) IBOutlet NSTextField* IDWP_FTPUser;
@property (retain) IBOutlet NSSecureTextField* IDWP_FTPPassword;


@end
