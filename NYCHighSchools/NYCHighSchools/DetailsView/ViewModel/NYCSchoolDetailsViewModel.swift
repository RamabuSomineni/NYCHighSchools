//
//  NYCSchoolDetailsViewModel.swift
//  NYCHighSchools
//
//  Created by Rambabu on 20/12/23.
//

import Foundation
/**
 A schools list view model protocol defining required methods to render school info.
 */
protocol SchoolDetailsViewModel {
    func fetchSchooolSATScores(_ school: School) async
}
/**
 A NYC school details view model implementing school details view model protocol.
 This prototype fetches SAT scores of a school.
 */
class NYCSchoolDetailsViewModel: SchoolDetailsViewModel {
    private var serviceManager: NYCNetworkManager
    var dataLoadingState = ServiceLoadingState.none
    var scores = [NYCSATScore]()
    
    // MARK: - Initializing Network Manager
    init(_ serviceManger: NYCNetworkManager = NYCNetworkManager(NYCSATScoreEndPoint())) {
        self.serviceManager = serviceManger
    }
    // MARK: - Network Methods
    
    func fetchSchooolSATScores(_ school: School) async {
        
        do {
            // Get SAT scores for the given school.
            let fetchedScores : [NYCSATScore] = try await serviceManager.getSATScores(["dbn": school.id])
            
            scores = fetchedScores
            dataLoadingState = fetchedScores.isEmpty ? .noDataFound : .loaded
        } catch {
            dataLoadingState = .failedToLoad
        }
    }
}
