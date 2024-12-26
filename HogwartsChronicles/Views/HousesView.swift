//
//  StudentListView.swift
//  HogwartsChronicles
//
//  Created by Seppe Ruysschaert on 24/12/2024.
//

import SwiftUI

struct HousesView: View {
    @ObservedObject var housesViewModel: HousesViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                housesPicker()
                characterList()
                    .onAppear {
                        housesViewModel.fetchCharacters()
                    }
            }
        }.padding(.vertical)
    }
    
    func characterList() -> some View {
        let columns = [
            GridItem(.adaptive(minimum: 300))
        ]
        
        return LazyVGrid(columns: columns, spacing: 16) {
            ForEach(housesViewModel.selectedCharacters) { character in
                
                CharacterView(character: character)
                
                
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
    
    func housesPicker() -> some View {
        let allHouses = HousesSelection.allCases
        
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        return LazyVGrid(columns: columns, spacing: 12) {
            ForEach(allHouses, id: \.self) { house in
                houseButton(for: house)
            }
        }
        .padding(.horizontal)
    }
    
    private func houseButton(for house: HousesSelection) -> some View {
        Button(action: {
            withAnimation {
                housesViewModel.housesSelection = house
                housesViewModel.fetchCharacters()
            }
        }) {
            VStack(spacing: 6) {
                Image(house.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                Text(house.displayName)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
            .padding(8)
            .frame(maxWidth: .infinity, minHeight: 60)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(housesViewModel.housesSelection == house
                          ? house.color
                          : Color.gray.opacity(0.3))
            )
            .shadow(radius: housesViewModel.housesSelection == house ? 4 : 1)
        }
    }
    
}

#Preview {
    HousesView(housesViewModel: HousesViewModel())
}
