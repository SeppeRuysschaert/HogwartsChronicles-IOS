//
//  SpellsView.swift
//  HogwartsChronicles
//
//  Created by Seppe Ruysschaert on 24/12/2024.
//

import SwiftUI

struct SpellsView: View {
    @ObservedObject var spellViewModel: SpellViewModel
    
    var body: some View {
        VStack {
            searchBar()
            spellsList().onAppear {
                spellViewModel.fetchSpells()
            }
        }
    }
    
    func spellsList() -> some View {
        List(spellViewModel.spells) { spell in
            VStack(alignment: .leading, spacing: 5) {
                Text(spell.name)
                    .font(.headline)
                    .foregroundColor(.blue)
                Text(spell.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 8)
        }
    }
    
    func searchBar() -> some View {
         HStack {
             TextField("Search spells...", text: $spellViewModel.searchText)
                 .padding(7)
                 .padding(.horizontal, 25)
                 .background(Color(.systemGray6))
                 .cornerRadius(8)
                 .overlay(
                     HStack {
                         Image(systemName: "magnifyingglass")
                             .foregroundColor(.gray)
                             .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                             .padding(.leading, 8)
                         
                         if !spellViewModel.searchText.isEmpty {
                             Button(action: {
                                 spellViewModel.searchText = ""
                             }) {
                                 Image(systemName: "xmark.circle.fill")
                                     .foregroundColor(.gray)
                                     .padding(.trailing, 8)
                             }
                         }
                     }
                 )
         }
         .padding(.horizontal)
     }
}



#Preview {
    SpellsView(spellViewModel: SpellViewModel())
}
