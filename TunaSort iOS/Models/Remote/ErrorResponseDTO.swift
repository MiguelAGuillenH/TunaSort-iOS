//
//  ErrorResponseDTO.swift
//  TunaSort iOS
//
//  Created by MAGH on 27/07/24.
//

import Foundation

struct ErrorResponseDTO: Codable {
    
    enum CodingKeys: String, CodingKey {
        case error = "error"
    }

    let error: ErrorDTO?
    
}
