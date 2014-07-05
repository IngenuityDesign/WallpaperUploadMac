//
//  IDWP_AppDelegate.m
//  wallpaperupload
//
//  Created by Stephen Parente on 7/4/14.
//  Copyright (c) 2014 Ingenuity Design. All rights reserved.
//

#import "IDWP_AppDelegate.h"
#import "IDWP_Directory.h"
#import "IDWP_File.h"

@implementation IDWP_AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    IDWP_Directory * directory = [[IDWP_Directory alloc] init];
    IDWP_File * files = [directory enumerateImageFiles:@"/Users/stephen/Documents"];
    
}

@end
