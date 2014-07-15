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
    
    // Create the File Open Dialog class.
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    
    // Enable the selection of files in the dialog.
    [openDlg setCanChooseFiles:YES];
    
    // Enable the selection of directories in the dialog.
    [openDlg setCanChooseDirectories:YES];
    
    // Display the dialog.  If the OK button was pressed,
    // process the files.
    if ( [openDlg runModalForDirectory:nil file:nil] == NSOKButton )
    {
        // Get an array containing the full filenames of all
        // files and directories selected.
        NSArray* files = [openDlg filenames];
        
        // Loop through all the files and process them.
        NSString* fileName = [files objectAtIndex:0];
        IDWP_Directory * directory = [IDWP_Directory directory];
        NSMutableArray * foundFiles = [directory enumerateImageFiles:fileName];
        [directory processImages];

       
    }
    
}

@end
