//
//  HousesSelection.swift
//  HogwartsChronicles
//
//  Created by Seppe Ruysschaert on 25/12/2024.
//

import SwiftUI

enum HousesSelection: CaseIterable {
    case Gryffindor
    case Slytherin
    case Hufflepuff
    case Ravenclaw
    
    var url: String {
            switch self {
            case .Gryffindor: return "https://hp-api.onrender.com/api/characters/house/gryffindor"
            case .Slytherin: return "https://hp-api.onrender.com/api/characters/house/slytherin"
            case .Hufflepuff: return "https://hp-api.onrender.com/api/characters/house/hufflepuff"
            case .Ravenclaw: return "https://hp-api.onrender.com/api/characters/house/ravenclaw"
            }
        }
    
    var displayName: String {
            switch self {
            case .Gryffindor: return "Gryffindor"
            case .Slytherin: return "Slytherin"
            case .Hufflepuff: return "Hufflepuff"
            case .Ravenclaw: return "Ravenclaw"
            }
        }
        
    var color: Color {
        switch self {
        case .Gryffindor: return .red
        case .Slytherin: return .green
        case .Hufflepuff: return .yellow
        case .Ravenclaw: return .blue
        }
    }
    
    var iconName: String {
        switch self {
        case .Gryffindor: return "gryffindor"
        case .Slytherin: return "slytherin"
        case .Hufflepuff: return "hufflepuff"
        case .Ravenclaw: return "ravenclaw"
        }
    }
}
