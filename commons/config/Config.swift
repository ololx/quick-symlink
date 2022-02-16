//
//  Defaults.swift
//  quick-symlink
//
//  Created by Alexander A. Kropotin on 10.02.2022.
//  Copyright © 2022 Alexander A. Kropotin. All rights reserved.
//

import Foundation

public enum Config {
    
    static var relativePath: Bool {
        get {
            return pathTypeStrategyDefaults.get();
            
        }
        set {
            pathTypeStrategyDefaults.set(newValue);
            
        }
    }
    
    private static var pathTypeStrategyDefaults = QuickSymlinkDefaults(key: "relative-path-strategy", defaultValue: false);
}
