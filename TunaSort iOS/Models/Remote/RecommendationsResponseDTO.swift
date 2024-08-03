//
//  RecommendationsResponseDTO.swift
//  TunaSort iOS
//
//  Created by MAGH on 22/07/24.
//

import Foundation

struct RecommendationsResponseDTO: Codable {
    
    enum CodingKeys: String, CodingKey {
        case seeds = "seeds"
        case tracks = "tracks"
    }
    
    let seeds: [SeedDTO]?
    let tracks: [TrackDTO]?
    
}
