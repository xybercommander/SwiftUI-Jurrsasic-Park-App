//
//  ApexPredator.swift
//  JurassicPark
//
//  Created by Samrat Mukherjee on 23/04/24.
//

import Foundation
import SwiftUI

struct ApexPredator: Decodable, Identifiable {
    let id: Int
    let name: String
    let type: PredatorType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    struct MovieScene: Decodable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
    
    enum PredatorType: String, Decodable {
        case land
        case sea
        case air
        
        var background: Color {
            switch self {
            case .land:
                .brown
            case .sea:
                .teal
            case .air:
                .blue
            }
        }
    }
}
