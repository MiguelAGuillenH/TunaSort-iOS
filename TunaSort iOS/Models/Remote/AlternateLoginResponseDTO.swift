//
//  AlternateLoginResponseDTO.swift
//  TunaSort iOS
//
//  Created by MAGH on 29/07/24.
//

import Foundation

struct AlternateLoginResponseDTO: Codable {
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
    }

    let accessToken: String?
    let tokenType: String?
    let expiresIn: Int?
    
}

