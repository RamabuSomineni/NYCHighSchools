//
//  NYCSATScoresModelTests.swift
//  NYCHighSchoolsTests
//
//  Created by Rambabu on 20/12/23.
//

import XCTest
@testable import NYCHighSchools

final class NYCSATScoresModelTests: XCTestCase {

    var score: SATScore!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        score = NYCSATScore(school_name: "Brooklyn School for Music & Theatre", num_of_sat_test_takers: "48", dbn: "17K548", sat_critical_reading_avg_score: "385", sat_math_avg_score: "393", sat_writing_avg_score: "373")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testNYCSATScore() throws{
        XCTAssertEqual(score.id, "17K548")
        XCTAssertEqual(score.schoolName, "Brooklyn School for Music & Theatre")
        XCTAssertEqual(score.studentsCount, "48")
        XCTAssertEqual(score.readingScore, "385")
        XCTAssertEqual(score.mathScore, "393")
        XCTAssertEqual(score.writingScore, "373")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

