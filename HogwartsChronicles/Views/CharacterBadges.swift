//
//  CharacterBadges.swift
//  HogwartsChronicles
//
//  Created by Seppe Ruysschaert on 24/12/2024.
//

import SwiftUI

struct HouseBadge: View {
    let house: String
    
    var body: some View {
        Text(house)
            .font(.subheadline)
            .bold()
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(houseColor(house))
            .cornerRadius(8)
            .foregroundColor(.white)
    }
    
    private func houseColor(_ house: String) -> Color {
        switch house {
        case "Gryffindor": return .red.opacity(0.8)
        case "Slytherin": return .green.opacity(0.8)
        case "Ravenclaw": return .blue.opacity(0.8)
        case "Hufflepuff": return .yellow.opacity(0.8)
        default: return .gray
        }
    }
}

struct WizardBadge: View {
    var body: some View {
        Text("Wizard 🧙‍♂️")
            .font(.subheadline)
            .bold()
            .padding(.vertical, 4)
            .padding(.horizontal, 7)
            .background(Color.purple.opacity(0.7))
            .cornerRadius(8)
            .foregroundColor(.white)
    }
}

struct AliveBadge: View {
    let isAlive: Bool
    
    var body: some View {
        Text(isAlive ? "Alive" : "Dead")
            .font(.subheadline)
            .bold()
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(isAlive ? Color.green.opacity(0.7) : Color.red.opacity(0.7))
            .cornerRadius(8)
            .foregroundColor(.white)
    }
}

struct StudentBadge: View {
    var body: some View {
        Text("Student 🎓")
            .font(.subheadline)
            .bold()
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(Color.blue.opacity(0.7))
            .cornerRadius(8)
            .foregroundColor(.white)
    }
}

