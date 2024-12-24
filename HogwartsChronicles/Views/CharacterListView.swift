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
        VStack {
            filterOptions()
            characterList()
                .onAppear {
                    characterViewModel.fetchCharacters()
                }
        }
    }
    
    func filterOptions() -> some View {
        VStack {
            wizardToggle()
            lifePicker()
        }
    }
    
    func characterList()  -> some View {
        List(characterViewModel.characters) { character in
            CharacterView(character: character)
        }
    }
    
    func wizardToggle() -> some View {
        HStack {
            Image(systemName: characterViewModel.showOnlyWizards ? "wand.and.stars" : "wand.and.stars.inverse")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(characterViewModel.showOnlyWizards ? .purple : .gray)
            
            Toggle(isOn: $characterViewModel.showOnlyWizards) {
                Text("Only Wizards")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            .toggleStyle(SwitchToggleStyle(tint: .purple))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(UIColor.systemGray6))
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
        .padding(.horizontal)
    }
    
    func lifePicker() -> some View {
        Picker("Filter by Status", selection: $characterViewModel.filterStatus) {
            Text("All").tag(CharacterViewModel.FilterStatus.all)
            Text("Alive").tag(CharacterViewModel.FilterStatus.alive)
            Text("Dead").tag(CharacterViewModel.FilterStatus.dead)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
    
}


#Preview {
    CharacterListView(characterViewModel: CharacterViewModel())
}
