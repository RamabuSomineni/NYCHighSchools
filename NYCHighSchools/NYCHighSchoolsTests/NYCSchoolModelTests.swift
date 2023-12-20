//
//  NYCSchoolModelTests.swift
//  NYCHighSchoolsTests
//
//  Created by Rambabu on 20/12/23.
//

import XCTest
@testable import NYCHighSchools

final class NYCSchoolModelTests: XCTestCase {

    var school: School!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        school = NYCSchool(school_name: "Brooklyn School for Music & Theatre", dbn: "17K548", city: "Brooklyn", zip: "11225", location: "883 Classon Avenue, Brooklyn NY 11225 (40.669805, -73.960689)")
    }
    
    func testNYCSchool() throws {
        XCTAssertEqual(school.id, "17K548")
        XCTAssertEqual(school.name, "Brooklyn School for Music & Theatre")
        XCTAssertEqual(school.city, "Brooklyn")
        XCTAssertEqual(school.zip, "11225")
        XCTAssertEqual(school.address, "883 Classon Avenue, Brooklyn NY 11225 ")
        XCTAssertEqual(school.coordinates, ["latitude":"40.669805","longitude":"-73.960689"])
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }


}

