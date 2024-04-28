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
}

enum PredatorType: String, Decodable, CaseIterable, Identifiable {
    case all
    case land
    case sea
    case air
    
    //MARK: Always to give a struct ID when using Identifiable protocol
    var id: PredatorType {
        self
    }
    
    var background: Color {
        switch self {
        case .land:
            .brown
        case .sea:
            .teal
        case .air:
            .blue
        case .all:
            .black
        }
    }
    
    var icon: String {
        switch self {
        case .all:
            "square.stack.3d.up.fill"
        case .land:
            "leaf.fill"
        case .sea:
            "wind"
        case .air:
            "drop.fill"
        }
    }
}
