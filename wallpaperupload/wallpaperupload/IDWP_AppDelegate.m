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
    
    
}
- (IBAction)submitWindowFormm:(id)sender {
    
    // Insert code here to initialize your application
    IDWP_Directory * directory = [IDWP_Directory directory];
    NSMutableArray * files = [directory enumerateImageFiles:@"/Users/stephen/Pictures"];
    
    [directory processImages];
}

@end
