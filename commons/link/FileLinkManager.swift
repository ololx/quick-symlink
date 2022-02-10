//
//  FileManagerAdapter.swift
//  quick-symlink
//
//  Created by Alexander A. Kropotin on 01/09/2021.
//  Copyright © 2021 Alexander A. Kropotin. All rights reserved.
//

import Foundation
import FinderSync

public protocol FileLinkManager {
    
    func linkWith(of: URL!, with: URL!);
    
    func replaceWith(of: URL!, with: URL!);
}

public extension FileLinkManager {
    
    func getDestinationPath(of: URL!, with: URL!) -> URL! {
        var destinationPath: Path = ResourcePath.of(url: of);
        if (QuickSymlinkDefaults(key: "relative-path-strategy", defaultValue: true).get()) {
            destinationPath = destinationPath.relativize(to: ResourcePath.of(url: with?.deletingLastPathComponent()));
        }
        
        return destinationPath.toUrl();
    }
    
    func getTargetPath(_ from: URL!, to: URL!) -> URL! {
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

public class SoftLinkManager: FileLinkManager {
    
    public func linkWith(of: URL!, with: URL!) {
        do {
            NSLog("asdasdasd");
            try FileManager.default.createSymbolicLink(at: with!, withDestinationURL: self.getDestinationPath(of: of, with: with));
        } catch let error as NSError {
            NSLog("FileManager.createSymbolicLink() failed to create file: %@", error.description as NSString);
        }
    }
    
    public func replaceWith(of: URL!, with: URL!) {
        do {
            //FIXME: Add checking for existance of file & resolving this case with symply pastle link
            try FileManager.default.moveItem(at: of, to: with);
            try FileManager.default.createSymbolicLink(at: of, withDestinationURL: self.getDestinationPath(of: with, with: of));
        } catch let error as NSError {
            NSLog("FileManager.createSymbolicLink() failed to create file: %@", error.description as NSString);
        }
    }
}

public class HardLinkManager: FileLinkManager {
    
    public func linkWith(of: URL!, with: URL!) {
        do {
            try FileManager.default.linkItem(at: of, to: with);
        } catch let error as NSError {
            NSLog("FileManager.createSymbolicLink() failed to create file: %@", error.description as NSString);
        }
    }
    
    public func replaceWith(of: URL!, with: URL!) {
        do {
            try FileManager.default.moveItem(at: of, to: with);
            try FileManager.default.linkItem(at: with, to: of);
        } catch let error as NSError {
            NSLog("FileManager.createSymbolicLink() failed to create file: %@", error.description as NSString);
        }
    }
}
