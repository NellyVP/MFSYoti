//
//  BaseTestCase.swift
//  MFSYotiTests
//
//  Created by Nilofar Vahab poor on 08/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//
import XCTest
@testable import MFSYoti

class BaseTestCase: XCTestCase {
    let lookupUIImage = UIImage(named: "Yoti")
    var baseMaxAge:Double = 6400
    let imageIdentifier = "Yoti"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func createMFSImageFromUIImage() -> MFSImage {
        let data = UIImagePNGRepresentation(lookupUIImage!)! as NSData
        let mfsImg   = MFSImage(imgID: String().md5(imageIdentifier), imgURL: imageIdentifier, imgData: data, preAccessTime: Date() as NSDate, numberOfRetrieval: 1, cachePeriod: baseMaxAge)
        return mfsImg
        
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
