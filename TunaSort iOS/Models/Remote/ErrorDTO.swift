//
//  ErrorDTO.swift
//  TunaSort iOS
//
//  Created by MAGH on 27/07/24.
//

import Foundation

struct ErrorDTO: Codable {
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
    }

    let status: Int?
    let message: String?
    
}
