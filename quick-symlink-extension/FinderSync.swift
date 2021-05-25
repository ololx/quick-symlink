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
    
    let quickSymlinkToolbarItemImage = NSImage(named:NSImage.Name(rawValue: "quick-symlink-toolbar-item-image"));
    
    override init() {
        super.init()
        
        NSLog("FinderSync() launched from %@", Bundle.main.bundlePath as NSString);
        
        // Set up the directory we are syncing.
        let finderSync = FIFinderSyncController.default();
        
        // Shared group preferences required
        _ = UserDefaults.init(suiteName: "org.ololx.quick-symlink")
        
        if let mountedVolumes = FileManager.default.mountedVolumeURLs(includingResourceValuesForKeys: nil,
                                                                      options: .skipHiddenVolumes) {
            finderSync.directoryURLs = Set<URL>(mountedVolumes);
        }
        
        let notificationCenter = NSWorkspace.shared.notificationCenter
        notificationCenter.addObserver(forName: NSWorkspace.didMountNotification, object: nil, queue: .main) {
            (notification) in
            if let volumeURL = notification.userInfo?[NSWorkspace.volumeURLUserInfoKey] as? URL {
                finderSync.directoryURLs.insert(volumeURL);
            }
        }
        
        //FIFinderSyncController.default().directoryURLs = [self.myFolderURL];
    }
    
    // MARK: - Primary Finder Sync protocol methods
    
    override func beginObservingDirectory(at url: URL) {
        // The user is now seeing the container's contents.
        // If they see it in more than one view at a time, we're only told once.
        NSLog("beginObservingDirectoryAtURL: %@", url.path as NSString);
    }
    
    
    override func endObservingDirectory(at url: URL) {
        // The user is no longer seeing the container's contents.
        NSLog("endObservingDirectoryAtURL: %@", url.path as NSString);
    }
    
    // MARK: - Menu and toolbar item support
    
    override var toolbarItemName: String {
        return "Quick Symlink";
    }
    
    override var toolbarItemToolTip: String {
        return "Quick Symlink: Click the toolbar item for a menu";
    }
    
    override var toolbarItemImage: NSImage {
        return quickSymlinkToolbarItemImage!;
    }
    
    override func menu(for menuKind: FIMenuKind) -> NSMenu {
        // Produce a menu for the extension (to be shown when right clicking a folder in Finder)
        let quickSymlinkMenu = NSMenu(title: "");
        quickSymlinkMenu.addItem(withTitle: "Paste from clipboard", action: #selector(pastleSymlinkFromClipboard(_:)), keyEquivalent: "");
        quickSymlinkMenu.addItem(withTitle: "Copy to clipboard", action: #selector(copyPathToClipboard), keyEquivalent: "");
        
        if menuKind.rawValue == 3 {
            return quickSymlinkMenu;
        } else {
            let quickSymLinkMainMenu = NSMenu(title: "");
            let quickSymlinkMenuItem = NSMenuItem(title: "Quick Symlink", action: nil, keyEquivalent: "");
            quickSymLinkMainMenu.setSubmenu(quickSymlinkMenu, for: quickSymlinkMenuItem);
            quickSymLinkMainMenu.addItem(quickSymlinkMenuItem);
            
            return quickSymLinkMainMenu;
        }
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
