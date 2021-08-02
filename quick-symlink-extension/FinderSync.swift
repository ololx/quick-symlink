//
//  FinderSync.swift
//  quick-symlink-contextual-menu
//
//  Created by Alexander A. Kropotin on 07.05.2021.
//

import Cocoa
import FinderSync

class FinderSync: FIFinderSync {
    
    let quickSymlinkToolbarItemImage = NSImage(named:NSImage.Name(rawValue: "quick-symlink-toolbar-item-image"));
    
    let copyPathAction = CopyPathAction.init();
    let pasteLinkAction = PasteLinkAction.init();
    let replaceWithLinkAction = ReplaceWithLinkAction.init();
    let createSymlink = CreateLinkAction.init();
    
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
        return  NSLocalizedString("EXTENTION_NAME", comment: "");
    }
    
    override var toolbarItemToolTip: String {
        return NSLocalizedString("EXTENTION_TOOL_TIP", comment: "");
    }
    
    override var toolbarItemImage: NSImage {
        return quickSymlinkToolbarItemImage!;
    }
    
    override func menu(for menuKind: FIMenuKind) -> NSMenu {
        // Produce a menu for the extension (to be shown when right clicking a folder in Finder)
        let quickSymlinkMenu = NSMenu(title: "");
        quickSymlinkMenu.addItem(
            withTitle: NSLocalizedString("CREATE_LINK_ACTION_NAME", comment: ""),
            action: #selector(createSymlink(_:)),
            keyEquivalent: ""
        );
        quickSymlinkMenu.addItem(
            withTitle: NSLocalizedString("COPY_PATH_ACTION_NAME", comment: ""),
            action: #selector(copyPathToClipboard(_:)),
            keyEquivalent: ""
        );
        quickSymlinkMenu.addItem(
            withTitle: NSLocalizedString("PASTE_LINK_ACTION_NAME", comment: ""),
            action: #selector(pastleSymlinkFromClipboard(_:)),
            keyEquivalent: ""
        );
        quickSymlinkMenu.addItem(
            withTitle: NSLocalizedString("REPLACE_WITH_LINK_ACTION_NAME", comment: ""),
            action: #selector(replaceFileWithSymlinkFromClipboard(_:)),
            keyEquivalent: ""
        );
        
        if menuKind.rawValue == 3 {
            return quickSymlinkMenu;
        } else {
            let quickSymLinkMainMenu = NSMenu(title: "");
            let quickSymlinkMenuItem = NSMenuItem(
                title:  NSLocalizedString("EXTENTION_NAME", comment: ""),
                action: nil,
                keyEquivalent: ""
            );
            quickSymLinkMainMenu.setSubmenu(quickSymlinkMenu, for: quickSymlinkMenuItem);
            quickSymLinkMainMenu.addItem(quickSymlinkMenuItem);
            
            return quickSymLinkMainMenu;
        }
    }
    
    @IBAction func copyPathToClipboard(_ sender: AnyObject?) {
        self.copyPathAction.execute();
    }
    
    @IBAction func replaceFileWithSymlinkFromClipboard(_ sender: AnyObject?) {
        self.replaceWithLinkAction.execute();
    }
    
    @IBAction func pastleSymlinkFromClipboard(_ sender: AnyObject?) {
        self.pasteLinkAction.execute();
    }
    
    @IBAction func createSymlink(_ sender: AnyObject?) {
        self.createSymlink.execute();
    }
}
