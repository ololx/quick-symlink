//
//  AppDelegate.swift
//  quick-symlink
//
//  Created by Alexander A. Kropotin on 07.05.2021.
//

import Cocoa
import FinderSync

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    // Close app when toolbar red button is pushed
    func applicationShouldTerminateAfterLastWindowClosed(_ app: NSApplication) -> Bool {
        return true
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        NSApp.activate(ignoringOtherApps: true)
        // Terminate the application, as it is not needed anymore
        NSApplication.shared.terminate(self)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
