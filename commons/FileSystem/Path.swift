//
//  Path.swift
//  quick-symlink
//
//  Created by Alexander A. Kropotin on 22/08/2021.
//  Copyright © 2021 Alexander A. Kropotin. All rights reserved.
//

import Foundation

public protocol Path {
    
    func relativize(to other: Path!) -> Path!;
    
    func getPathFragments() -> [String]!;
    
    func toUrl() -> URL?;
    
    func toUriString() -> String?;
}
