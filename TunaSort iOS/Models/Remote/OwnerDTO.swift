//
//  OwnerDTO.swift
//  TunaSort iOS
//
//  Created by MAGH on 22/07/24.
//

import Foundation

struct OwnerDTO: Codable {
    
    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case externalUrls = "external_urls"
        case followers = "followers"
        case href = "href"
        case id = "id"
        case type = "type"
        case uri = "uri"
    }
    
    let displayName: String?
    let externalUrls: ExternalUrlsDTO?
    let followers: FollowersDTO?
    let href: String?
    let id: String?
    let type: String?
    let uri: String?
    
}
