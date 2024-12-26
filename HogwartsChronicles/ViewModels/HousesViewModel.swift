//
//  HousesViewModel.swift
//  HogwartsChronicles
//
//  Created by Seppe Ruysschaert on 25/12/2024.
//

import SwiftUI

class HousesViewModel: ObservableObject {
    private let apiService = ApiService<[Character]>()
    @Published var housesSelection: HousesSelection = .Gryffindor
    @Published private var _selectedCharacters: [Character]?
    
    @MainActor
    func fetchCharacters() {
        Task {
            do {
                _selectedCharacters = try await apiService.fetch(by: housesSelection.url)
            } catch ApiError.invalidURL {
                print("invalid URL")
            } catch ApiError.invalidResponse {
                print("invalid response")
            } catch ApiError.decodingError {
                print("decoding error")
            }
        }
    }
    
    var selectedCharacters: Array<Character> {
        if let selectedCharacters = _selectedCharacters {
            return selectedCharacters
        }
        return []
    }
}


