//
//  ProcessesPrefs.m
//  ProcessesPrefs
//
//  Created by Stephen Sykes on 27/01/16.
//  Copyright © 2016 Switchstep. All rights reserved.
//

#import "ProcessesPrefs.h"

NSString *const kAllProcesses = @"allProcesses";
NSString *const kAllProcessesNotifcationName = @"com.switchstep.allProcessesNotification";
NSString *const kTheApp = @"com.switchstep.Processes";

@interface ProcessesPrefs ()

@property (nonatomic, weak) IBOutlet NSButton *allProcesses;
@property (nonatomic) NSUserDefaults *defaults;

@end

@implementation ProcessesPrefs

- (void)mainViewDidLoad
{
    // Can get the prefs via NSUserDefaults
    NSDictionary *defaults = [[NSUserDefaults standardUserDefaults] persistentDomainForName:kTheApp];
    BOOL allProcessesDefault = [[defaults objectForKey:@"allProcesses"] boolValue];

    self.allProcesses.state = allProcessesDefault ? NSOnState : NSOffState;
}


- (IBAction)allProcessesChanged:(NSButton *)sender
{
    // Have to set the prefs using Carbon
    if (sender.state == NSOnState) {
        CFPreferencesSetAppValue((CFStringRef)kAllProcesses, kCFBooleanTrue, (CFStringRef)kTheApp);
        CFPreferencesAppSynchronize((CFStringRef)kTheApp);
        [[NSDistributedNotificationCenter defaultCenter] postNotificationName:kAllProcessesNotifcationName object:@"YES" userInfo:nil deliverImmediately:YES];
    } else {
        CFPreferencesSetAppValue((CFStringRef)kAllProcesses, kCFBooleanFalse, (CFStringRef)kTheApp);
        CFPreferencesAppSynchronize((CFStringRef)kTheApp);
        [[NSDistributedNotificationCenter defaultCenter] postNotificationName:kAllProcessesNotifcationName object:@"NO" userInfo:nil deliverImmediately:YES];
    }
}

@end
