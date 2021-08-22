//
//  CreateLinkAction.swift
//  quick-symlink
//
//  Created by Alexander A. Kropotin on 02/08/2021.
//  Copyright © 2021 Alexander A. Kropotin. All rights reserved.
//

import Foundation
import FinderSync

public class CreateLinkAction: QuickSymlinkAction {
    
    private var finderController: FIFinderSyncController;
    
    public init() {
        self.finderController = FIFinderSyncController.default();
    }
    
    public func execute() {
        //Get all selected path
        guard let target = self.finderController.selectedItemURLs() else {
            NSLog("FinderSync() failed to obtain targeted URLs: %@");
            
            return;
        }
        
        for path in target {
            let targetPath = self.getTargetPath(path, to: path.deletingLastPathComponent());
            
            do {
                try FileManager.default.createSymbolicLink(at: targetPath!, withDestinationURL: ResourcePath.of(url: path).relativize(to: ResourcePath.of(url: targetPath?.deletingLastPathComponent())).toUrl()!);
            } catch let error as NSError {
                NSLog("FileManager.createSymbolicLink() failed to create file: %@", error.description as NSString);
            }
        }
    }
}

