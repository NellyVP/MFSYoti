//
//  MFSMySuperCacheTests.swift
//  MFSYotiTests
//
//  Created by Nilofar Vahab poor on 05/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

import XCTest

class MFSMySuperCacheTests: XCTestCase {
    var cache: CacheOrganiser = CacheOrganiser()
    var baseMaxAge:Double = 6400
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testThatCacheOrganiserCanBeInitialized() {
        // Given
        var cache: CacheOrganiser? = CacheOrganiser()
        
        // When
        cache = nil
        
        // Then
        XCTAssertNil(cache, "cache should be nil after deinit")
    }

    func testThatCacheOrganiserCanAddImageWithIdentifierAndMaxAge(){
        // Given
        let image = UIImage(named: "Refresh-icon")
        let identifier = "refresh"
        var cachedImage = UIImage()
        
        // When
        cache.add(image: image!, withIdentifier: identifier, maxAge: 6400)
        
        cache.get(imageAtURLString: identifier) { (image) in
            cachedImage = image!
        }
        // Then
        XCTAssertNotNil(cache.imagesCache, "cache.imagesCache should not be nil")
        XCTAssertNotNil(cachedImage, "cached image should not be nil")
    }
    
    func testThatCacheCanFindImageWithIdentifier() {
        // Given
        let image = UIImage(named: "Refresh-icon")
        let identifier = "refresh"
        
        // When
        cache.add(image: image!, withIdentifier: identifier, maxAge: baseMaxAge)
        let cachedImage = cache.findImageWithId(imageID: identifier)
        XCTAssertNotNil(cache.imagesCache, "cache.imagesCache should not be nil")
        XCTAssertNotNil(cachedImage, "cached image should not be nil")

    }
    
    func testThatCacheCanRemoveImageWithIdentifier() {
        // Given
        let image = UIImage(named: "Refresh-icon")
        let identifier = "refresh"
        
        // When
        cache.add(image: image!, withIdentifier: identifier, maxAge: baseMaxAge)
        let cachedImageExists = cache.findImageWithId(imageID: identifier) != nil
        let removedImage = cache.removeImageFromCache(identifier: identifier)
        let checkIfImageExistsInCache = cache.findImageWithId(imageID: identifier) != nil
        
        // Then
        XCTAssertTrue(cachedImageExists, "cached image exists should be true")
        XCTAssertTrue(removedImage, "removed image should be true")
        XCTAssertFalse(checkIfImageExistsInCache, "cached image exists after removal should be false")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
