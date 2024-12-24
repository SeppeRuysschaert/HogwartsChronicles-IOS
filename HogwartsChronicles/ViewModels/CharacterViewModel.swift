//
//  CharacterViewModel.swift
//  HogwartsChronicles
//
//  Created by Seppe Ruysschaert on 23/12/2024.
//

import SwiftUI

class CharacterViewModel: ObservableObject {
    typealias Character = CharacterModel.Character
    
    @Published private var _characters: [Character]?
    @Published var showOnlyWizards = false
    @Published var filterStatus: FilterStatus = .all
    private let apiService = ApiService()
    
    @MainActor
    func fetchCharacters() {
        Task {
            do {
                _characters = try await apiService.fetchCharacters()
            } catch ApiError.invalidURL {
                print("invalid URL")
            } catch ApiError.invalidResponse {
                print("invalid response")
            } catch ApiError.decodingError {
                print("decoding error")
            }
        }
    }
    
    var characters: Array<Character> {
        if var characters = _characters {
            if showOnlyWizards {
                characters = characters.filter({ c in
                    c.wizard == true
                })
            }
            if filterStatus == .alive {
                characters = characters.filter({ c in
                    c.alive == true
                })
            }
            if filterStatus == .dead {
                characters = characters.filter({ c in
                    c.alive == false
                })
            }
            return characters
        }
        return []
    }
    
    enum FilterStatus {
        case all
        case alive
        case dead
    }
}
