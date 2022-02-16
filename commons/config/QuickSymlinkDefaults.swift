//
//  PathTypeDefaults.swift
//  quick-symlink
//
//  Created by Alexander A. Kropotin on 17/09/2021.
//  Copyright © 2021 Alexander A. Kropotin. All rights reserved.
//

import Foundation

public struct QuickSymlinkDefaults<T> {
    
    var key: String
    
    var defaultValue: T
}

public extension QuickSymlinkDefaults {
    
    func get() -> T {
        guard let valueUntyped = UserDefaults.init(suiteName: "io.github.ololx.QuickSymlink")?.object(forKey: self.key) else {
            return self.defaultValue;
        }
        
        guard let value = valueUntyped as? T else {
            return self.defaultValue;
        }
        
        return value;
    }
    
    func set(_ value: T) {
        UserDefaults.init(suiteName: "io.github.ololx.QuickSymlink")?.set(value, forKey: self.key);
    }
}
