//
//  ReplaceWithLinkAction.swift
//  quick-symlink
//
//  Created by Alexander A. Kropotin on 15/07/2021.
//  Copyright © 2021 Alexander A. Kropotin. All rights reserved.
//

import Foundation
import FinderSync

public class ReplaceWithLinkAction: QuickSymlinkAction {
    
    private var finderController: FIFinderSyncController;
    
    public init() {
        self.finderController = FIFinderSyncController.default();
    }
    
    public func execute() {
        //Get selected folder path
        guard let target = self.finderController.targetedURL() else {
            NSLog("FinderSync() failed to obtain targeted URL: %@");
            
            return;
        }
        
        let pasteboard = NSPasteboard.init(name: NSPasteboard.Name.init(rawValue: "qs"));
        let pathsFromClipboard = pasteboard.string(forType: NSPasteboard.PasteboardType.string) ?? "";
        if pathsFromClipboard.isEmpty {
            return;
        }
        pasteboard.clearContents();
        
        let paths = pathsFromClipboard.components(separatedBy: ";");
        for path in paths {
            let pathUrl = URL(fileURLWithPath: path);
            let targetPath = self.getTargetPath(pathUrl, to: target);
            
            do {
                try FileManager.default.moveItem(at: pathUrl, to: targetPath!);
                try FileManager.default.createSymbolicLink(at: pathUrl, withDestinationURL: targetPath!);
            } catch let error as NSError {
                NSLog("FileManager.createSymbolicLink() failed to create file: %@", error.description as NSString);
            }
        }
    }
}
