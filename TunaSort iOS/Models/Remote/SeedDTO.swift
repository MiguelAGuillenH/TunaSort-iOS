//
//  SeedDTO.swift
//  TunaSort iOS
//
//  Created by MAGH on 22/07/24.
//

import Foundation

struct SeedDTO: Codable {
    
    enum CodingKeys: String, CodingKey {
        case afterFilteringSize = "afterFilteringSize"
        case afterRelinkingSize = "afterRelinkingSize"
        case href = "href"
        case id = "id"
        case initialPoolSize = "initialPoolSize"
        case type = "type"
    }
    
    let afterFilteringSize: Int?
    let afterRelinkingSize: Int?
    let href: String?
    let id: String?
    let initialPoolSize: Int?
    let type: String?
    
}
