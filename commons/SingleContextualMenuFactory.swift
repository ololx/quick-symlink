//
//  SingleContextualMenu.swift
//  quick-symlink
//
//  Created by Alexander A. Kropotin on 10.02.2022.
//  Copyright © 2022 Alexander A. Kropotin. All rights reserved.
//

import Foundation
import AppKit
import FinderSync

public class SingleContextualMenuFactory: FIFinderSync {
    
    private static var instance: NSMenu = {
        let instance = NSMenu(title: "")
        
        return instance
    }();
    
    public func newInstance() -> NSMenu {
        return SingleContextualMenuFactory.instance;
    }
}
