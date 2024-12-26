//
//  Database.swift
//  HogwartsChronicles
//
//  Created by Seppe Ruysschaert on 26/12/2024.
//

import Foundation

final class Database {
    private let FAV_KEY = "fav_key"
    
    func save(characters: Set<String>) {
        let array = Array(characters)
        UserDefaults.standard.set(array, forKey: FAV_KEY)
        print("Saved characters: \(array)")
    }
    
    func load() -> Set<String> {
        let array = UserDefaults.standard.array(forKey: FAV_KEY) as? [String] ?? [String]()
        print("Loaded characters: \(array)")
        return Set(array)
    }
}
