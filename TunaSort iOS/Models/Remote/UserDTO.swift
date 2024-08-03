//
//  UserDTO.swift
//  TunaSort iOS
//
//  Created by MAGH on 22/07/24.
//

import Foundation

struct UserDTO: Codable {
    
    enum CodingKeys: String, CodingKey {
        case country = "country"
        case displayName = "display_name"
        //case email = "email"
        case explicitContent = "explicit_content"
        case externalUrls = "external_urls"
        case followers = "followers"
        case href = "href"
        case id = "id"
        case images = "images"
        case product = "product"
        case type = "type"
        case uri = "uri"
    }
    
    let country: String?
    let displayName: String?
    //let email: String?
    let explicitContent: ExplicitContentDTO?
    let externalUrls: ExternalUrlsDTO?
    let followers: FollowersDTO?
    let href: String?
    let id: String?
    let images: [ImageDTO]?
    let product: String?
    let type: String?
    let uri: String?
    
}
