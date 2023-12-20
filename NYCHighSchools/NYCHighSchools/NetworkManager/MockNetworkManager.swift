//
//  MockNetworkManager.swift
//  NYCHighSchools
//
//  Created by Rambabu on 20/12/23.
//

import Foundation
class MockNetworkManager: NetworkManager {

    func getSchools<T>(_ params: [String : String]) async throws -> [T] where T : School {
        var decodedResults = [T]()
        if let path = Bundle.main.path(forResource: "NYCSchoolsList", ofType: "json") {
            do {
                let dataResponse = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                decodedResults = try JSONDecoder().decode([T].self, from: dataResponse)
            } catch {
                print("API failed to decode data : \(error)")
                throw ServiceError.failedToDecodeResponse
            }
        }
        return decodedResults
    }
    
    func getSATScores<T>(_ params: [String : String]) async throws -> [T] where T : SATScore {
        var decodedResults = [T]()
        if let path = Bundle.main.path(forResource: "NYCSchoolsDetails", ofType: "json") {
            do {
                let dataResponse = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                decodedResults = try JSONDecoder().decode([T].self, from: dataResponse)
            } catch {
                print("API failed to decode data : \(error)")
                throw ServiceError.failedToDecodeResponse
            }
        }
        return decodedResults
    }

}
