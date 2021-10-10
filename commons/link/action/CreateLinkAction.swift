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
    
    private var fileLinkManager: FileLinkManager;
    
    public init(fileLinkManager: FileLinkManager!) {
        self.finderController = FIFinderSyncController.default();
        self.fileLinkManager = fileLinkManager;
    }
    
    public func execute() {
        //Get all selected path
        guard var target = self.finderController.selectedItemURLs() else {
            NSLog("FinderSync() failed to obtain targeted URLs: %@");
            
            return;
        }
        
        if (target.isEmpty) {
            target.append(self.finderController.targetedURL()!);
        }
        
        for path in target {
            let targetPath = self.fileLinkManager.getTargetPath(path, to: path == self.finderController.targetedURL()! ? path :  path.deletingLastPathComponent());
            self.fileLinkManager.linkWith(of: path, with: targetPath);
        }
    }
}
