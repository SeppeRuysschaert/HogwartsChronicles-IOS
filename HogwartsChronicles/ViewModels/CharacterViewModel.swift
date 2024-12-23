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
        if let characters = _characters {
            return characters
        }
        return []
    }
}
