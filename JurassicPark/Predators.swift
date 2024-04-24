//
//  Predators.swift
//  JurassicPark
//
//  Created by Samrat Mukherjee on 23/04/24.
//

import Foundation

class Predators {
    var apexPredators: [ApexPredator] = []
    
    init() {
        //MARK: Decode all the data in the initializing of an instance of the class
        decodeApexPredatorData()
    }
    
    func decodeApexPredatorData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                apexPredators = try decoder.decode([ApexPredator].self, from: data)
//                print("Predators data:")
//                print(apexPredators)
            } catch {
                print("Error decoding the data: \(error)")
            }
        }
    }
}
