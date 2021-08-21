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
            
            
            var pathFragments = path.pathComponents;
            var targetPathFragments = targetPath?.deletingLastPathComponent().pathComponents;
            
            var destinationPath = URL.init(string: "./")!;
        
            for targetPathFragment in targetPathFragments! {
                if (!pathFragments.contains(targetPathFragment)) {
                    break;
                }
                
                pathFragments.remove(at: 0);
                targetPathFragments?.remove(at: 0);
            }
            
            for _ in targetPathFragments! {
                destinationPath.appendPathComponent("../");
            }
            
            for pathFragment in pathFragments {
                destinationPath.appendPathComponent(pathFragment);
            }
            
            do {
                try FileManager.default.createSymbolicLink(at: targetPath!, withDestinationURL: destinationPath);
            } catch let error as NSError {
                NSLog("FileManager.createSymbolicLink() failed to create file: %@", error.description as NSString);
            }
        }
    }
}

