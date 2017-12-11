//
//  MFSMySuperCacheTests.swift
//  MFSYotiTests
//
//  Created by Nilofar Vahab poor on 05/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//
import XCTest
@testable import MFSYoti



class MFSMySuperCacheTests: BaseTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    func testThatCacheOrganiserCanAddImage(){
        // Given
        let image = createMFSImageFromUIImage()
        var cachedImage = UIImage()
        

        // When
        CacheOrganiser.sharedCache.addImageToCache(image: image)
        CacheOrganiser.sharedCache.get(imageAtURLString: imageIdentifier) { (image) in
            cachedImage = image!

        }
        // Then
        XCTAssertNotNil(CacheOrganiser.sharedCache.imagesCache, "cache.imagesCache should not be nil")
        XCTAssertNotNil(cachedImage, "cached image should not be nil")
    }
    
    func testThatCacheCanFindImageWithIdentifier() {
        //Given
        let image = createMFSImageFromUIImage()

        // When
        CacheOrganiser.sharedCache.addImageToCache(image: image)
        let cachedImage = CacheOrganiser.sharedCache.findImageFromCache(urlString: image.imageID!)
        
        // Then
        XCTAssertNotNil(CacheOrganiser.sharedCache.imagesCache, "cache.imagesCache should not be nil")
        XCTAssertNotNil(cachedImage, "cached image should not be nil")

    }
    
    func testThatCacheCanRemoveImageWithIdentifier() {
        //Given
        let image = createMFSImageFromUIImage()
        
        //When
        CacheOrganiser.sharedCache.addImageToCache(image: image)
        
        let cachedImageExists = CacheOrganiser.sharedCache.findImageFromCache(urlString: image.imageID!) != nil

        CacheOrganiser.sharedCache.removeImageFromCache(image: image)

        let checkIfImageExistsInCache = CacheOrganiser.sharedCache.findImageFromCache(urlString: image.imageID!) != nil

        // Then
        XCTAssertTrue(cachedImageExists, "cached image exists should be true")
        XCTAssertFalse(checkIfImageExistsInCache, "cached image exists after removal should be false")
    }

    func testThatImageNeedsRedownload() {
        //Given
        baseMaxAge = -6400
        let image = createMFSImageFromUIImage()
        
        //When
        CacheOrganiser.sharedCache.addImageToCache(image: image)
        let cachedImageExists = CacheOrganiser.sharedCache.findImageFromCache(urlString: image.imageID!) != nil
        let checkIfImageNeedsDownload = CacheOrganiser.sharedCache.checkIfImageNeedsRedownload(image: image)
       
        // Then
        XCTAssertTrue(cachedImageExists, "cached image exists should be true")
        XCTAssertTrue(checkIfImageNeedsDownload, "cached image needs download should be true")
    }
    
    func testThatAccessingImageUpdatesAccessCount() {
        //Given
        let image = createMFSImageFromUIImage()
        
        //When
        CacheOrganiser.sharedCache.addImageToCache(image: image)
        
        let cachedImage = CacheOrganiser.sharedCache.findImageFromCache(urlString: image.imageID!)
        CacheOrganiser.sharedCache.updateImageAccessInfo(image: cachedImage!)
        
        let accessCount = cachedImage?.accessCount
        let lastAccessDate = cachedImage?.lastAccessTime
        
        // Then
        XCTAssertNotNil(CacheOrganiser.sharedCache.imagesCache, "cache.imagesCache should not be nil")
        XCTAssertNotNil(cachedImage, "cachedImage should not be nil")

        XCTAssertEqual(accessCount, 2, "Wrong access count")
        XCTAssertNotNil(lastAccessDate, "cachedImage should not be nil")
    }

    func testThatThatCacheDisacrdOverMaxLimit() {
        //Given
        CacheOrganiser.sharedCache.kMaxNumberOfItems = 1
        let image = createMFSImageFromUIImage()
        
        //When
        CacheOrganiser.sharedCache.addImageToCache(image: image)
        CacheOrganiser.sharedCache.checkTodiscardOverCacheLimit()
        
        // Then
        XCTAssertTrue(CacheOrganiser.sharedCache.imagesCache.count == 0, "cache.imagesCache should be nil")

    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

}
