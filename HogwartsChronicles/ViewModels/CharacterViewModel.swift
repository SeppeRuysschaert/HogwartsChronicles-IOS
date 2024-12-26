//
//  CharacterViewModel.swift
//  HogwartsChronicles
//
//  Created by Seppe Ruysschaert on 23/12/2024.
//

import SwiftUI

class CharacterViewModel: ObservableObject {

    @Published private var _characters: [Character]?
    @Published private var savedCharacters: Set<String> = []
    @Published var showOnlyWizards = false
    @Published var filterStatus: FilterStatus = .all
    @Published var showOnlyStudents: Bool = false
    @Published var showingFavs = false
    
    private let apiService = ApiService<[Character]>()
    private var db = Database()
    
    init() {
        self.savedCharacters = db.load()
    }
    
    @MainActor
    func fetchCharacters() {
        Task {
            do {
                _characters = try await apiService.fetch(by: "https://hp-api.onrender.com/api/characters")
            } catch ApiError.invalidURL {
                print("invalid URL")
            } catch ApiError.invalidResponse {
                print("invalid response")
            } catch ApiError.decodingError {
                print("decoding error")
            }
        }
    }
    
    func sortFavs() {
        withAnimation() {
            showingFavs.toggle()
        }
    }
    
    func contains(_ character: Character) -> Bool {
        savedCharacters.contains(character.id)
    }
    
    func toggleFav(character: Character) {
        if contains(character) {
            savedCharacters.remove(character.id)
        } else {
            savedCharacters.insert(character.id)
        }
        db.save(characters: savedCharacters)
    }
    
    var characters: Array<Character> {
        if var characters = _characters {
            if showOnlyWizards {
                characters = characters.filter({ c in
                    c.wizard == true
                })
            }
            if showOnlyStudents {
                characters = characters.filter({ c in
                    c.hogwartsStudent == true
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
            if showingFavs {
                characters = characters.filter { savedCharacters.contains($0.id) }
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
