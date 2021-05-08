//
//  FinderSync.swift
//  quick-symlink-contextual-menu
//
//  Created by Alexander A. Kropotin on 07.05.2021.
//

import Cocoa
import FinderSync

class FinderSync: FIFinderSync {

    var myFolderURL = URL(fileURLWithPath: "/");
    
    override init() {
        super.init()
        
        NSLog("FinderSync() launched from %@", Bundle.main.bundlePath as NSString);
        
        // Set up the directory we are syncing.
        let finderSync = FIFinderSyncController.default();
        
        // Shared group preferences required
        let sharedDefaults = UserDefaults.init(suiteName: "org.ololx.quick-symlink")
        
        if let mountedVolumes = FileManager.default.mountedVolumeURLs(includingResourceValuesForKeys: nil,
                                                                      options: .skipHiddenVolumes) {
            finderSync.directoryURLs = Set<URL>(mountedVolumes);
        }
        
        let notificationCenter = NSWorkspace.shared.notificationCenter
        notificationCenter.addObserver(forName: NSWorkspace.didMountNotification, object: nil, queue: .main) {
            (notification) in
            if let volumeURL = notification.userInfo?[NSWorkspace.volumeURLUserInfoKey] as? URL {
                finderSync.directoryURLs.insert(volumeURL)
            }
        }
        
        //FIFinderSyncController.default().directoryURLs = [self.myFolderURL];
    }
    
    override func menu(for menuKind: FIMenuKind) -> NSMenu {
        // Produce a menu for the extension (to be shown when right clicking a folder in Finder)
        let quickSymLinkMainMenu = NSMenu(title: "")
        let quickSymlinkMenu = NSMenu(title: "")
        let quickSymlinkMenuItem = NSMenuItem(title: "Quick Symlink", action: nil, keyEquivalent: "")
        
        quickSymlinkMenu.addItem(withTitle: "Pastle from clipboard", action: #selector(pastleSymlinkFromClipboard(_:)), keyEquivalent: "")
        quickSymlinkMenu.addItem(withTitle: "Copy to clipboard", action: #selector(copyPathToClipboard), keyEquivalent: "")
        
        quickSymLinkMainMenu.setSubmenu(quickSymlinkMenu, for: quickSymlinkMenuItem)
        quickSymLinkMainMenu.addItem(quickSymlinkMenuItem)
        
        return quickSymLinkMainMenu
    }
    
    @IBAction func copyPathToClipboard(_ sender: AnyObject?) {
        //Get all selected path
        guard let target = FIFinderSyncController.default().selectedItemURLs() else {
            NSLog("FinderSync() failed to obtain targeted URLs: %@");

            return;
        }
        
        // Append all selected paths to string
        var paths = ""
        for path in target {
            paths.append(contentsOf: path.relativePath);
            paths.append(";");
        }
        paths.removeLast();

        //Copy path list to clipboard
        let pasteboard = NSPasteboard.general;
        pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil);
        pasteboard.setString(paths, forType: NSPasteboard.PasteboardType.string);
    }
    
    @IBAction func pastleSymlinkFromClipboard(_ sender: AnyObject?) {
        //Get selected folder path
        guard let target = FIFinderSyncController.default().targetedURL() else {
            NSLog("FinderSync() failed to obtain targeted URL: %@");
                
            return;
        }
        
        let pathsFromClipboard = NSPasteboard.general.string(forType: NSPasteboard.PasteboardType.string) ?? "";
        if pathsFromClipboard.isEmpty {
            return;
        }
        
        let paths = pathsFromClipboard.components(separatedBy: ";");
        for path in paths {
            var targetPath = target
            let pathUrl = URL(fileURLWithPath: path);
            let originSourceName = pathUrl.absoluteURL.deletingPathExtension().lastPathComponent;
            let fileType = pathUrl.absoluteURL.pathExtension;
            
            var fileExtention = fileType;
            if !fileType.isEmpty {
                fileExtention = ".\(fileType)"
            }
            
            var fileName = "\(originSourceName)\(fileExtention)";
            var counter = 1
            while FileManager.default.fileExists(atPath: targetPath.appendingPathComponent(fileName).path) {
                fileName = "\(originSourceName)-\(counter)\(fileExtention)";
                counter += 1;
                targetPath = target
            }
        
            do {
                try FileManager.init().createSymbolicLink(at: targetPath.appendingPathComponent(fileName), withDestinationURL: URL(fileURLWithPath: path));
            } catch let error as NSError {
                NSLog("FileManager.createSymbolicLink() failed to create file: %@", error.description as NSString);
            }
        }
    }
}
