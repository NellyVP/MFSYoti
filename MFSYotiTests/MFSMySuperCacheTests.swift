//
//  MFSMySuperCacheTests.swift
//  MFSYotiTests
//
//  Created by Nilofar Vahab poor on 05/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

import XCTest
class MFSMySuperCacheTests: BaseTestCase {
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

    func testThatCacheOrganiserCanAddImage(){
        // Given
        let image = createMFSImageFromUIImage()
        var cachedImage = UIImage()
        // When
        cache.addImageToCache(image: image)
        cache.get(imageAtURLString: imageIdentifier) { (image) in
            cachedImage = image!

        }
        // Then
        XCTAssertNotNil(cache.imagesCache, "cache.imagesCache should not be nil")
        XCTAssertNotNil(cachedImage, "cached image should not be nil")
    }
    
    func testThatCacheCanFindImageWithIdentifier() {
        //Given
        let image = createMFSImageFromUIImage()

        // When
        cache.addImageToCache(image: image)
        let cachedImage = cache.findImageFromCache(urlString: image.imageID!)
        
        // Then
        XCTAssertNotNil(cache.imagesCache, "cache.imagesCache should not be nil")
        XCTAssertNotNil(cachedImage, "cached image should not be nil")

    }
    
    func testThatCacheCanRemoveImageWithIdentifier() {
        //Given
        let image = createMFSImageFromUIImage()
        
        //When
        cache.addImageToCache(image: image)
        
        let cachedImageExists = cache.findImageFromCache(urlString: image.imageID!) != nil

        cache.removeImageFromCache(image: image)

        let checkIfImageExistsInCache = cache.findImageFromCache(urlString: image.imageID!) != nil

        // Then
        XCTAssertTrue(cachedImageExists, "cached image exists should be true")
        XCTAssertFalse(checkIfImageExistsInCache, "cached image exists after removal should be false")
    }

    func testThatImageNeedsRedownload() {
        //Given
        baseMaxAge = -6400
        let image = createMFSImageFromUIImage()
        
        //When
        cache.addImageToCache(image: image)
        let cachedImageExists = cache.findImageFromCache(urlString: image.imageID!) != nil
        let checkIfImageNeedsDownload = cache.checkIfImageNeedsRedownload(image: image)
       
        // Then
        XCTAssertTrue(cachedImageExists, "cached image exists should be true")
        XCTAssertTrue(checkIfImageNeedsDownload, "cached image needs download should be true")
    }
    
    func testThatAccessingImageUpdatesAccessCount() {
        //Given
        let image = createMFSImageFromUIImage()
        
        //When
        cache.addImageToCache(image: image)
        
        let cachedImage = cache.findImageFromCache(urlString: image.imageID!)
        cache.updateImageAccessInfo(image: cachedImage!)
        
        let accessCount = cachedImage?.accessCount
        let lastAccessDate = cachedImage?.lastAccessTime
        
        // Then
        XCTAssertNotNil(cache.imagesCache, "cache.imagesCache should not be nil")
        XCTAssertNotNil(cachedImage, "cachedImage should not be nil")

        XCTAssertEqual(accessCount, 2, "Wrong access count")
        XCTAssertNotNil(lastAccessDate, "cachedImage should not be nil")
    }

    func testThatThatCacheDisacrdOverMaxLimit() {
        //Given
        cache.kMaxNumberOfItems = 1
        let image = createMFSImageFromUIImage()
        
        //When
        cache.addImageToCache(image: image)
        cache.checkTodiscardOverCacheLimit()
        
        // Then
        XCTAssertTrue(cache.imagesCache.count == 0, "cache.imagesCache should be nil")

    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

}
