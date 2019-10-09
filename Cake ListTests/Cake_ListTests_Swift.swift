//
//  Cake_ListTests_Swift.swift
//  Cake ListTests
//
//  Created by Helen Clemson on 08/10/2019.
//  Copyright © 2019 Stewart Hart. All rights reserved.
//

import XCTest

class Cake_ListTests_Swift: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
    
    func testCreateCake() {
        let jsonCake = ["title":"Jam sponge",
                        "desc":"Simple cake with raspberry jam", "image":"https://images.immediate.co.uk/production/volatile/sites/2/2017/10/Sparrow-069-3a111e3.jpg?quality=45&crop=18px,3277px,4445px,1889px&resize=1880,808"]
        let cake = Cake(json: jsonCake)
        
        // Example of not nil test
        XCTAssertNotNil(cake)
        
        // Example of equals test
        XCTAssertEqual(cake?.title, "Jam sponge")
        XCTAssertEqual(cake?.desc, "Simple cake with raspberry jam")
    }
    
    func testCreateCakeNoImage() {
        let jsonCake = ["title":"Jam sponge",
                        "desc":"Simple cake with raspberry jam"]
        let cake = Cake(json: jsonCake)
        
        // Cake should not be created as missing image
        XCTAssertNil(cake)
    }


}
