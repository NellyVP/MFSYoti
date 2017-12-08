//
//  MFSRequestTests.swift
//  MFSYotiTests
//
//  Created by Nilofar Vahab poor on 08/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//
import XCTest

class MFSRequestTests: BaseTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThatMFSRequestCanBeInitializedAndDeinitialized() {
        // Given
        var mfsRequest: MFSRequest? = MFSRequest()
        
        // When
        mfsRequest = nil
        
        // Then
        XCTAssertNil(mfsRequest, "mfsRequest should be nil")
    }
}