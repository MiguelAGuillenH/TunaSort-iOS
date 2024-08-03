//
//  AddedByUser.swift
//  TunaSort iOS
//
//  Created by MAGH on 18/07/24.
//

import Foundation

struct AddedByUserDTO: Codable {
    
    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case followers = "followers"
        case href = "href"
        case id = "id"
        case type = "type"
        case uri = "uri"
    }

    let externalUrls: ExternalUrlsDTO?
    let followers: FollowersDTO?
    let href: String?
    let id: String?
    let type: String?
    let uri: String?
    
}
