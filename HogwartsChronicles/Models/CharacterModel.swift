//
//  Character.swift
//  HogwartsChronicles
//
//  Created by Seppe Ruysschaert on 23/12/2024.
//

import Foundation

struct CharacterModel: Decodable {
    struct Character : Decodable, Identifiable{
        let id: String
        let name: String
        let gender: String
        let house: String
        let actor: String
        let wizard: Bool
        let alive: Bool
        let image: String
    }
}
