//
//  TabView.swift
//  HogwartsChronicles
//
//  Created by Seppe Ruysschaert on 24/12/2024.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            CharacterListView(characterViewModel: CharacterViewModel())
                .tabItem {
                    Label("All Characters", systemImage: "person.3.fill")
                }
            
            SpellsView(spellViewModel: SpellViewModel())
                .tabItem {
                    Label("Spells", systemImage: "wand.and.stars")
                }
            
            HousesView(housesViewModel: HousesViewModel())
                .tabItem {
                    Label("Houses", systemImage: "house.fill")
                }
        }
    }
}

