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
    var quickSymlinkDefaults: QuickSymlinkDefaults! = QuickSymlinkDefaults(key: "relative-path-strategy", defaultValue: true);
    
    let copyPathAction = CopyPathAction.init();
    let pasteLinkAction = PasteLinkAction.init(fileLinkManager: SoftLinkManager.init());
    let replaceWithLinkAction = ReplaceWithLinkAction.init(fileLinkManager: SoftLinkManager.init());
    let createSymlink = CreateLinkAction.init(fileLinkManager: SoftLinkManager.init());
    
    override init() {
        super.init()
        
        NSLog("FinderSync() launched from %@", Bundle.main.bundlePath as NSString);
        
        // Set up the directory we are syncing.
        let finderSync = FIFinderSyncController.default();
        
        // Shared group preferences required
        //_ = UserDefaults.init(suiteName: "org.ololx.QuickSymlink")
        
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
        return  NSLocalizedString("SOFT_LINK_ACTIONS_EXTENTION_NAME", comment: "");
    }
    
    override var toolbarItemToolTip: String {
        return NSLocalizedString("SOFT_LINK_ACTIONS_EXTENTION_TOOL_TIP", comment: "");
    }
    
    override var toolbarItemImage: NSImage {
        return quickSymlinkToolbarItemImage!;
    }
    
    override func menu(for menuKind: FIMenuKind) -> NSMenu {
        // Produce a menu for the extension (to be shown when right clicking a folder in Finder)
        let quickSymlinkMenu = NSMenu(title: "");
        
        quickSymlinkMenu.insertItem(
            withTitle: NSLocalizedString("CREATE_LINK_ACTION_NAME", comment: ""),
            action: #selector(createSymlink(_:)),
            keyEquivalent: "",
            at: 0
        );
        
        quickSymlinkMenu.insertItem(
            withTitle: NSLocalizedString("COPY_PATH_ACTION_NAME", comment: ""),
            action: #selector(copyPathToClipboard(_:)),
            keyEquivalent: "",
            at: 1
        );
        
        let pastleSymlinkFromClipboardMenuItem = NSMenuItem.init(
            title: NSLocalizedString("PASTE_LINK_ACTION_NAME", comment: ""),
            action: #selector(pastleSymlinkFromClipboard(_:)),
            keyEquivalent: ""
        );
        quickSymlinkMenu.insertItem(pastleSymlinkFromClipboardMenuItem, at: 2);
        
        let replaceFileWithSymlinkFromClipboardMenuItem = NSMenuItem.init(
            title: NSLocalizedString("REPLACE_WITH_LINK_ACTION_NAME", comment: ""),
            action: #selector(replaceFileWithSymlinkFromClipboard(_:)),
            keyEquivalent: ""
        );
        quickSymlinkMenu.insertItem(replaceFileWithSymlinkFromClipboardMenuItem, at: 3);
        
        if (NSPasteboard.init(name: NSPasteboard.Name.init(rawValue: "qs")).string(forType: NSPasteboard.PasteboardType.string) ?? "").isEmpty {
            pastleSymlinkFromClipboardMenuItem.isEnabled = false;
            replaceFileWithSymlinkFromClipboardMenuItem.isEnabled = false;
        }
        
        quickSymlinkMenu.addItem(NSMenuItem.separator());
        let pathStrategyItem = NSMenuItem.init(
            title: NSLocalizedString("PATH_STRATEGY_OPTION", comment: ""),
            action: #selector(onPathStrategyChange(_:)),
            keyEquivalent: ""
        );
        pathStrategyItem.target = self;
        pathStrategyItem.state = quickSymlinkDefaults.get() ? .on : .off;
        
        quickSymlinkMenu.addItem(pathStrategyItem);
        
        if menuKind.rawValue == 3 {
            return quickSymlinkMenu;
        } else {
            let quickSymLinkMainMenu = NSMenu(title: "");
            let quickSymlinkMenuItem = NSMenuItem(
                title:  NSLocalizedString("SOFT_LINK_ACTIONS_EXTENTION_NAME", comment: ""),
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
    
    @IBAction func onPathStrategyChange(_ sender: NSMenuItem!) {
        sender.state = sender.state == .on ? .off : .on;
        
        switch sender.state {
        case .on:
            self.quickSymlinkDefaults.set(true);
            break;
        case .off:
            self.quickSymlinkDefaults.set(false);
            break;
        default:
            break;
        }
    }
}
