//
//  ViewController.swift
//  quick-symlink
//
//  Created by Alexander A. Kropotin on 25.05.21.
//  Copyright © 2021 Alexander A. Kropotin. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var useRelativePath: NSButton!
    
    var quickSymlinkDefaults: QuickSymlinkDefaults! = QuickSymlinkDefaults(key: "relative-path-strategy", defaultValue: true);

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.useRelativePath.state = NSControl.StateValue(rawValue: quickSymlinkDefaults.get() ? 1 : 0);
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    
    @IBAction func onChange(_ sender: NSButton) {
        switch sender.state {
            case .on:
                quickSymlinkDefaults.set(true);
                break;
            case .off:
                quickSymlinkDefaults.set(false);
                break;
            default:
                break;
        }
    }
}

