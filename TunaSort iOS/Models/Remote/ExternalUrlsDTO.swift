//
//  ExternalUrlsDTO.swift
//  TunaSort iOS
//
//  Created by MAGH on 22/07/24.
//

import Foundation

struct ExternalUrlsDTO: Codable {
    
    enum CodingKeys: String, CodingKey {
        case spotify = "spotify"
    }
    
    let spotify: String?
    
}
