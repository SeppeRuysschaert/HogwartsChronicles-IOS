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
        ScrollView {
            VStack {
                filterOptions()
                characterList()
                    .onAppear {
                        characterViewModel.fetchCharacters()
                    }
            }
        }.padding(.vertical)
    }
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    func filterOptions() -> some View {
        VStack {
            if horizontalSizeClass == .compact {
                VStack {
                    wizardToggle()
                    studentToggle()
                    favoriteToggle()
                    lifePicker()
                }
            } else {
                HStack {
                    wizardToggle()
                    studentToggle()
                    favoriteToggle()
                    lifePicker()
                }
            }
        }
    }

    
    func characterList() -> some View {
        let columns = [
            GridItem(.adaptive(minimum: 300))
        ]
        
        return LazyVGrid(columns: columns, spacing: 16) {
            ForEach(characterViewModel.characters) { character in
                HStack {
                    CharacterView(character: character)
                    
                    Spacer()
                    
                    Image(systemName: characterViewModel.contains(character) ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                        .onTapGesture {
                            characterViewModel.toggleFav(character: character)
                        }
                }
                .padding()
                .frame(minWidth: 300)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(UIColor.systemGray6))
                        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
                )
            }
        }
        .padding(.horizontal)
    }



    func favoriteToggle() -> some View {
        HStack {
            Image(systemName: characterViewModel.showingFavs ? "heart.fill" : "heart")
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundColor(characterViewModel.showingFavs ? .red : .gray)
            
            Toggle(isOn: $characterViewModel.showingFavs) {
                Text("Favorites")
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
            .toggleStyle(SwitchToggleStyle(tint: .blue))
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(Color(UIColor.systemGray6))
                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
        )
        .padding(.horizontal)
    }

    func studentToggle() -> some View {
        HStack {
            Image(systemName: characterViewModel.showOnlyStudents ? "graduationcap" : "graduationcap.fill")
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundColor(characterViewModel.showOnlyStudents ? .blue : .gray)
            
            Toggle(isOn: $characterViewModel.showOnlyStudents) {
                Text("Only Students")
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
            .toggleStyle(SwitchToggleStyle(tint: .blue))
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(Color(UIColor.systemGray6))
                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
        )
        .padding(.horizontal)
    }

    func wizardToggle() -> some View {
        HStack {
            Image(systemName: characterViewModel.showOnlyWizards ? "wand.and.stars" : "wand.and.stars.inverse")
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundColor(characterViewModel.showOnlyWizards ? .purple : .gray)
            
            Toggle(isOn: $characterViewModel.showOnlyWizards) {
                Text("Only Wizards")
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
            .toggleStyle(SwitchToggleStyle(tint: .purple))
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(Color(UIColor.systemGray6))
                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
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
        .padding(.horizontal)
    }
    
}


#Preview {
    CharacterListView(characterViewModel: CharacterViewModel())
}
