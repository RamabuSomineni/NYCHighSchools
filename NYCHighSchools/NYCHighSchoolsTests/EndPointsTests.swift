//
//  EndPointsTests.swift
//  NYCHighSchoolsTests
//
//  Created by Rambabu on 20/12/23.
//

import XCTest
@testable import NYCHighSchools

final class EndPointsTests: XCTestCase {
    var schoolsEndPoint: EndPoint!
    var satScoreEndPoint: EndPoint!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        schoolsEndPoint = NYCSchoolEndPoint()
        satScoreEndPoint = NYCSATScoreEndPoint()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        schoolsEndPoint = nil
        satScoreEndPoint = nil
    }
    
    func testNYCSchoolEndPointDefaultValues() throws {
        XCTAssertEqual(schoolsEndPoint.header, ["Content-Type": "application/json"])
        XCTAssertEqual(schoolsEndPoint.path, "/s3k6-pzi2.json")
        XCTAssertEqual(schoolsEndPoint.scheme, "https")
        XCTAssertEqual(schoolsEndPoint.host, "data.cityofnewyork.us/resource")
        XCTAssertEqual(schoolsEndPoint.method, .get)
    }
    
    func testNYCSchoolEndPointGetURLString() throws {
        let urlString = schoolsEndPoint.getURLString()
        XCTAssertEqual(urlString, "https://data.cityofnewyork.us/resource/s3k6-pzi2.json")
    }
    
    func testNYCSATScoreEndPointDefaultValues() throws {
        // Then
        XCTAssertEqual(satScoreEndPoint.header, ["Content-Type": "application/json"])
        XCTAssertEqual(satScoreEndPoint.path, "/f9bf-2cp4.json?")
        XCTAssertEqual(satScoreEndPoint.scheme, "https")
        XCTAssertEqual(satScoreEndPoint.host, "data.cityofnewyork.us/resource")
        XCTAssertEqual(satScoreEndPoint.method, .get)
    }
    
    func testNYCSATScoreEndPointGetURLString() throws {
        // When
        let urlString = satScoreEndPoint.getURLString()
        
        // Then
        XCTAssertEqual(urlString, "https://data.cityofnewyork.us/resource/f9bf-2cp4.json?")
    }
}


