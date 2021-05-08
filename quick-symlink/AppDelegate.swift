//
//  AppDelegate.swift
//  quick-symlink
//
//  Created by Alexander A. Kropotin on 07.05.2021.
//

import Cocoa
import SwiftUI
import FinderSync

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        // Show extensions, if FinderUtilities is not approved
        if !FIFinderSyncController.isExtensionEnabled {
            FIFinderSyncController.showExtensionManagementInterface()
        }
        
        // Terminate the application, as it is not needed anymore
        NSApplication.shared.terminate(self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

