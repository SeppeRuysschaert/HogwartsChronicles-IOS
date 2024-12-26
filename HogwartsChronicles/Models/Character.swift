//
//  Character.swift
//  HogwartsChronicles
//
//  Created by Seppe Ruysschaert on 23/12/2024.
//

import Foundation

struct Character: Codable, Identifiable {
        let id: String
        let name: String
        let hogwartsStudent: Bool
        let house: String
        let actor: String
        let wizard: Bool
        let alive: Bool
        let image: String
}
