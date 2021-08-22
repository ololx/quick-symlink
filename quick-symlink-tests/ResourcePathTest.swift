//
//  ResourcePathTest.swift
//  quick-symlink-tests
//
//  Created by Alexander A. Kropotin on 22/08/2021.
//  Copyright © 2021 Alexander A. Kropotin. All rights reserved.
//

import XCTest

class ResourcePathTest: XCTestCase {
    
    func test_toURL_methodExecution_returnedURLIsEqualToInitialURL() {
        let uri: URL = URL.init(string: "/a/b/c/d")!;
        let path: Path = ResourcePath.of(url: uri);
        
        XCTAssert(path.toUrl() == uri, "The Path URL is not equal to URL");
    }
    
    func test_relativize_whenCurrentDirectoryIsNestedToOtherDirectory_thenReturnPathStartingFromOtherDirectory() {
        let currentUri: URL = URL.init(string: "/a/b/c/d")!;
        let otherUri: URL = URL.init(string: "/a/b")!;
        
        let relativePath: Path = ResourcePath.of(url: currentUri)
            .relativize(to: ResourcePath.of(url: otherUri));
        
        XCTAssert(relativePath.toUriString() == "./c/d", "The relative path is wrong");
    }
    
    func test_relativize_whenOtherDirectoryIsNestedToCurrentDirectory_thenReturnPathWithOnlyJumpsAboveOtherDirectory() {
        let currentUri: URL = URL.init(string: "/a/b")!;
        let otherUri: URL = URL.init(string: "/a/b/c/d")!;
        
        let relativePath: Path = ResourcePath.of(url: currentUri)
            .relativize(to: ResourcePath.of(url: otherUri));
        
        XCTAssert(relativePath.toUriString() == "./../..", "The relative path is wrong");
    }
    
    func test_relativize_whenCurrentDirectoryAndOtherDirectoryAreNestedToGeneralDirectoryy_thenReturnPathWithJumpsAboveOtherDirectoryAndPartOfCurrentDirectory() {
        let currentUri: URL = URL.init(string: "/a/b/c1/d1")!;
        let otherUri: URL = URL.init(string: "/a/b/c2/d2")!;
        
        let relativePath: Path = ResourcePath.of(url: currentUri)
            .relativize(to: ResourcePath.of(url: otherUri));
        
        XCTAssert(relativePath.toUriString() == "./../../c1/d1", "The relative path is wrong");
    }
}
