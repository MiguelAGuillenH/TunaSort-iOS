//
//  ImageDTO.swift
//  TunaSort iOS
//
//  Created by MAGH on 22/07/24.
//

import Foundation

struct ImageDTO: Codable {
    
    enum CodingKeys: String, CodingKey {
        case height = "height"
        case url = "url"
        case width = "width"
    }
    
    let height: Int?
    let url: String?
    let width: Int?
    
}
