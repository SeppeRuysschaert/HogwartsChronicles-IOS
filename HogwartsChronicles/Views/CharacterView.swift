//
//  Character.swift
//  HogwartsChronicles
//
//  Created by Seppe Ruysschaert on 24/12/2024.
//

import SwiftUI

struct CharacterView: View {
    let character: Character
    var body: some View {
        HStack {
            characterImage(
                image: character.image,
                name: character.name
            )
            
            VStack {
                Text(character.name)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                badges()
            }
            .padding(.leading, 10)
        }
        .padding(.vertical, 8)
    }
    
    func badges() -> some View {
        VStack {
            HStack {
                if !character.house.isEmpty {
                    HouseBadge(house: character.house)
                }
                if character.wizard {
                    WizardBadge()
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                AliveBadge(isAlive: character.alive)
                if character.hogwartsStudent {
                    StudentBadge()
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    func characterImage(image: String, name: String) -> some View {
        AsyncImage(url: URL(string: image)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 100)
                .clipped()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 5)
                )
                .cornerRadius(8)
        } placeholder: {
            placeholderView(name: name)
        }
    }
    
    func placeholderView(name: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 60, height: 100)
            
            Text(initials(from: name))
                .font(.title2)
                .foregroundColor(.white)
                .bold()
        }
    }
    
    func initials(from name: String) -> String {
        let words = name.split(separator: " ")
        let firstLetters = words.compactMap { $0.first }.prefix(2)
        return String(firstLetters).uppercased()
    }
    
}

