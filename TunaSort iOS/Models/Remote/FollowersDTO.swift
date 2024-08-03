//
//  FollowersDTO.swift
//  TunaSort iOS
//
//  Created by MAGH on 22/07/24.
//

import Foundation

struct FollowersDTO: Codable {
    
    enum CodingKeys: String, CodingKey {
        case href = "href"
        case total = "total"
    }
    
    let href: String?
    let total: Int?
    
}
