//
//  CharacterListView.swift
//  HogwartsChronicles
//
//  Created by Seppe Ruysschaert on 23/12/2024.
//

import SwiftUI

struct CharacterListView: View {
    @ObservedObject var characterViewModel: CharacterViewModel
    var body: some View {
        
        List(characterViewModel.characters) { character in
                Text(character.name)
            }
            .onAppear {
                characterViewModel.fetchCharacters()
            }
        }
    }


#Preview {
    CharacterListView(characterViewModel: CharacterViewModel())
}
