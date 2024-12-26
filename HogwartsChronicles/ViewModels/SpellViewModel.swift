//
//  SpellViewModel.swift
//  HogwartsChronicles
//
//  Created by Seppe Ruysschaert on 24/12/2024.
//

import SwiftUI

class SpellViewModel : ObservableObject {
    @Published private var _spells: [Spell]?
    @Published var searchText: String = ""
    private let apiService = ApiService<[Spell]>()
    
    @MainActor
    func fetchSpells() {
        Task {
            do {
                _spells = try await apiService.fetch(by: "https://hp-api.onrender.com/api/spells")
            } catch ApiError.invalidURL {
                print("invalid URL")
            } catch ApiError.invalidResponse {
                print("invalid response")
            } catch ApiError.decodingError {
                print("decoding error")
            }
        }
    }
    
    var spells: Array<Spell> {
        if let spells = _spells {
            if searchText.isEmpty {
                return spells
            }
            return spells.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
        return []
    }
}
