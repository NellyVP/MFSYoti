//
//  MFSControllerTests.swift
//  MFSYotiTests
//
//  Created by Nilofar Vahab poor on 08/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//
import XCTest
@testable import MFSYoti

class MFSControllerTests: BaseTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThatMFSControllerCanBeInitializedAndDeinitialized() {
        // Given
        var mfsController: MFSController? = MFSController()
        
        // When
        mfsController = nil
        
        // Then
        XCTAssertNil(mfsController, "mfsRequest should be nil")
    }
    
    func testDownloadingImageFromLink() {
        guard let gitUrl = URL(string: "https://c1.staticflickr.com/6/5615/15570202337_0e64f5046e_k.jpg") else { return }
        let promise = expectation(description: "Download image Request")
        URLSession.shared.dataTask(with: gitUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                XCTAssertNotNil(data, "data should not be nil")
                promise.fulfill()
                }
            }.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }

}
