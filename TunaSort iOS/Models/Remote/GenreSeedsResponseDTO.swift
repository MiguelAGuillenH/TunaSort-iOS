//
//  GenreSeedsResponseDTO.swift
//  TunaSort iOS
//
//  Created by MAGH on 22/07/24.
//

import Foundation

struct GenreSeedsResponseDTO: Codable {
    
    enum CodingKeys: String, CodingKey {
        case genres = "genres"
    }
    
    let genres: [String]?
    
}
