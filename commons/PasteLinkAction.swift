//
//  PasteSymlinkAction.swift
//  quick-symlink
//
//  Created by Alexander A. Kropotin on 15/07/2021.
//  Copyright © 2021 Alexander A. Kropotin. All rights reserved.
//

import Foundation
import FinderSync

public class PasteLinkAction: QuickSymlinkAction {
    
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
        
        let pathsFromClipboard = NSPasteboard.general.string(forType: NSPasteboard.PasteboardType.string) ?? "";
        if pathsFromClipboard.isEmpty {
            return;
        }
        
        let paths = pathsFromClipboard.components(separatedBy: ";");
        for path in paths {
            let pathUrl = URL(fileURLWithPath: path);
            let targetPath = self.getTargetPath(pathUrl, to: target);
            
            do {
                try FileManager.default.createSymbolicLink(at: targetPath!, withDestinationURL: URL(fileURLWithPath: path));
            } catch let error as NSError {
                NSLog("FileManager.createSymbolicLink() failed to create file: %@", error.description as NSString);
            }
        }
    }
}
