//
//  SearchArtistsDTO.swift
//  TunaSort iOS
//
//  Created by MAGH on 22/07/24.
//

import Foundation

struct SearchArtistsDTO: Codable {
    
    enum CodingKeys: String, CodingKey {
        case href = "href"
        case items = "items"
        case limit = "limit"
        case next = "next"
        case offset = "offset"
        case previous = "previous"
        case total = "total"
    }
    
    let href: String?
    let items: [TrackArtistDTO]?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int?
    
}
