//
//  skyPERTests.swift
//  skyPERTests
//
//  Created by Andrei Panishev on 25.11.2022.
//

import XCTest
@testable import skyPER

final class skyPERTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNomogram() throws {
        let ng = PolyNomogramPart(fileName: "elevation")
        XCTAssertTrue(37300...37400 ~= ng.execute(34, 4500)!)
        XCTAssertTrue(30900...31100 ~= ng.execute(28, 10500)!)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
