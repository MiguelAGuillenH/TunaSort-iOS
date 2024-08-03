//
//  AlbumArtistDTO.swift
//  TunaSort iOS
//
//  Created by MAGH on 22/07/24.
//

import Foundation

struct AlbumArtistDTO: Codable {
    
    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href = "href"
        case id = "id"
        case name = "name"
        case type = "type"
        case uri = "uri"
    }
    
    let externalUrls: ExternalUrlsDTO?
    let href: String?
    let id: String?
    let name: String?
    let type: String?
    let uri: String?
    
}
