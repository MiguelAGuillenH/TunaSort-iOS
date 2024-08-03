//
//  ExplicitContentDTO.swift
//  TunaSort iOS
//
//  Created by MAGH on 22/07/24.
//

import Foundation

struct ExplicitContentDTO: Codable {
    
    enum CodingKeys: String, CodingKey {
        case filterEnabled = "filter_enabled"
        case filterLocked = "filter_locked"
    }
    
    let filterEnabled: Bool?
    let filterLocked: Bool?
    
}
