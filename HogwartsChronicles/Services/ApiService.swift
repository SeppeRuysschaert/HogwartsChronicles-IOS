//
//  ApiService.swift
//  HogwartsChronicles
//
//  Created by Seppe Ruysschaert on 23/12/2024.
//

import Foundation

class ApiService {
    private let baseURL = "https://hp-api.onrender.com/api"
    
    typealias Character = CharacterModel.Character
    
    func fetchCharacters() async throws -> [Character] {
        guard let url = URL(string: "\(baseURL)/characters") else {
            throw ApiError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw ApiError.invalidResponse
        }
        
        do {
            return try JSONDecoder().decode([Character].self, from: data)
        } catch {
            throw ApiError.decodingError
        }
    }
    
}

enum ApiError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
}
