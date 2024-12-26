//
//  SpellModel.swift
//  HogwartsChronicles
//
//  Created by Seppe Ruysschaert on 24/12/2024.
//

import Foundation

struct Spell: Decodable, Identifiable {
    let id: String
    let name: String
    let description: String
}
