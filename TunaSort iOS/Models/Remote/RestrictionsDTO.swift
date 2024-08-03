//
//  RestrictionsDTO.swift
//  TunaSort iOS
//
//  Created by DISMOV on 22/07/24.
//

import Foundation

struct RestrictionsDTO: Codable {
    
    enum CodingKeys: String, CodingKey {
        case reason = "reason"
    }
    
    let reason: String?
    
}
