//
//  StylistService.swift
//  PIO
//
//  Created by Mason Osby on 10/6/26.
//
import Foundation

struct OutfitSuggestions: Codable {
    let images: [String]
    let outfitDescription: String
    
    enum CodingKeys: String, CodingKey{
        case images
        case outfitDescription = "outfit_description"
    }
}

final class StylistService{
    
    func generateOutfit() async throws -> OutfitSuggestions{
        guard let url = URL(string: "http://127.0.0.1:5000/api/outfits/generate"
        ) else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
                request.httpMethod = "POST"
                
        let (data, response) = try await URLSession.shared.data(for: request)
                
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
                
        return try JSONDecoder().decode(
            OutfitSuggestions.self,
            from: data
        )
    }
}

