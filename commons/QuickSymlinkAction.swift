//
//  QuickSymlinkAction.swift
//  quick-symlink
//
//  Created by Alexander A. Kropotin on 15/07/2021.
//  Copyright © 2021 Alexander A. Kropotin. All rights reserved.
//

import Foundation

public protocol QuickSymlinkAction {
    
    func execute();
}

internal extension QuickSymlinkAction {
    
    internal func getTargetPath(_ from: URL!, to: URL!) -> URL! {
        let originSourceName = from.absoluteURL.deletingPathExtension().lastPathComponent;
        let fileType = from.absoluteURL.pathExtension;
        
        var fileExtention = fileType;
        if !fileType.isEmpty {
            fileExtention = ".\(fileType)"
        }
        
        var fileName = "\(originSourceName)\(fileExtention)";
        var counter = 1
        var targetPath = to;
        targetPath = targetPath?.appendingPathComponent(fileName);
        
        while FileManager.default.fileExists(atPath: (targetPath?.path)!) {
            fileName = "\(originSourceName)-\(counter)\(fileExtention)";
            counter += 1;
            targetPath = to.appendingPathComponent(fileName);
        }
    
        return targetPath!;
    }
}
