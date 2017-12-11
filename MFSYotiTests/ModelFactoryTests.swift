//
//  ModelFactoryTests.swift
//  MFSYotiTests
//
//  Created by Nilofar Vahab poor on 11/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

import XCTest
@testable import MFSYoti

class ModelFactoryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testThatModelFactoryCanBeInitializedAndDeinitialized() {
        // Given
        var modelFact: ModelFactory? = ModelFactory()
        
        // Then
        XCTAssertNotNil(modelFact, "modelFact should not be nil")
        
        // When
        modelFact = nil
        
        // Then
        XCTAssertNil(modelFact, "modelFact should be nil")
    }
    
    func testThatModelFactoryCanBuildMFSImage() {
        // Given
        let modelFact: ModelFactory? = ModelFactory()
        let urlString = "https://c1.staticflickr.com/6/5615/15570202337_0e64f5046e_k.jpg"
        guard let gitUrl = URL(string:urlString ) else { return }
        let promise = expectation(description: "Download image Request")
        
        //Then
        URLSession.shared.dataTask(with: gitUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                XCTAssertNotNil(data, "data should not be nil")
                XCTAssertNotNil(modelFact, "modelFact should not be nil")

                let image = modelFact?.createImageFrom(urlString: urlString, data: data, response: response as! HTTPURLResponse)
                
                XCTAssertNotNil(image, "image should not be nil")

                promise.fulfill()
            }
            }.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
