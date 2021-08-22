//
//  ResourcePath.swift
//  quick-symlink
//
//  Created by Alexander A. Kropotin on 22/08/2021.
//  Copyright © 2021 Alexander A. Kropotin. All rights reserved.
//

import Foundation

public class ResourcePath: Path {
    
    public static func of(url: URL!) -> Path! {
        return ResourcePath.of(fragments: url.pathComponents)
    }
    
    public static func of(fragments: [String]!) -> Path! {
        return ResourcePath.init(of: fragments);
    }
    
    private var uriFragments: [String]!;
    
    public init(of fragments: [String]) {
        self.uriFragments = fragments;
    }
    
    public func getPathFragments() -> [String]! {
        return self.uriFragments;
    }
    
    public func relativize(to other: Path!) -> Path! {
        var pathFragments = self.uriFragments;
        var targetPathFragments = other.getPathFragments();
        
        var destinationPath = URL.init(string: "./")!;
        for targetPathFragment in targetPathFragments! {
            if (!(pathFragments?.contains(targetPathFragment))!) {
                break;
            }
            
            pathFragments?.remove(at: 0);
            targetPathFragments?.remove(at: 0);
        }
        
        for _ in targetPathFragments! {
            destinationPath.appendPathComponent("../");
        }
        
        for pathFragment in pathFragments! {
            destinationPath.appendPathComponent(pathFragment);
        }
        
        //pathFragments!.append(contentsOf: targetPathFragments!);
        
        return ResourcePath.of(url: destinationPath);
    }
    
    public func toUrl() -> URL? {
        if self.uriFragments.count == 0 {
            return nil;
        }
        
        var uri = URL.init(string: self.uriFragments.first!)!;
        for fragment in self.uriFragments.dropFirst().dropLast() {
            uri.appendPathComponent(fragment);
            uri.appendPathComponent("/");
        }
        uri.appendPathComponent(self.uriFragments.last!);
        
        return uri;
    }
    
    public func toUriString() -> String? {
        if self.uriFragments.count == 0 {
            return nil;
        }
        
        return self.toUrl()!.absoluteString;
    }
    
    
}
