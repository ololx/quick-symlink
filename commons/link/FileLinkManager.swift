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
    
    public func getTargetPath(_ from: URL!, to: URL!) -> URL! {
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
            try FileManager.default.createSymbolicLink(at: with!, withDestinationURL: ResourcePath.of(url: of).relativize(to: ResourcePath.of(url: with?.deletingLastPathComponent())).toUrl()!);
        } catch let error as NSError {
            NSLog("FileManager.createSymbolicLink() failed to create file: %@", error.description as NSString);
        }
    }
    
    public func replaceWith(of: URL!, with: URL!) {
        do {
            //FIXME: Add checking for existance of file & resolving this case with symply pastle link
            try FileManager.default.moveItem(at: of, to: with);
            try FileManager.default.createSymbolicLink(at: of, withDestinationURL: ResourcePath.of(url: with).relativize(to: ResourcePath.of(url: of.deletingLastPathComponent())).toUrl()!);
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
