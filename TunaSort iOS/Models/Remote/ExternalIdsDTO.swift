//
//  ExternalIdsDTO.swift
//  TunaSort iOS
//
//  Created by MAGH on 22/07/24.
//

import Foundation

struct ExternalIdsDTO: Codable {
    
    enum CodingKeys: String, CodingKey {
        case ean = "ean"
        case isrc = "isrc"
        case upc = "upc"
    }
    
    let ean: String?
    let isrc: String?
    let upc: String?
    
}
