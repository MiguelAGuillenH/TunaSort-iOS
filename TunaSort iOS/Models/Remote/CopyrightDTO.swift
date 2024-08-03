//
//  CopyrightDTO.swift
//  TunaSort iOS
//
//  Created by MAGH on 22/07/24.
//

import Foundation

struct CopyrightDTO: Codable {
    
    enum CodingKeys: String, CodingKey {
        case text = "text"
        case type = "type"
    }
    
    let text: String?
    let type: String?
    
}
