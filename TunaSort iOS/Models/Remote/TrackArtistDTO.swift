//
//  TrackArtistDTO.swift
//  TunaSort iOS
//
//  Created by MAGH on 22/07/24.
//

import Foundation

struct TrackArtistDTO: Codable {
    
    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case followers = "followers"
        case genres = "genres"
        case href = "href"
        case id = "id"
        case images = "images"
        case name = "name"
        case popularity = "popularity"
        case type = "type"
        case uri = "uri"
    }
    
    let externalUrls: ExternalUrlsDTO?
    let followers: FollowersDTO?
    let genres: [String]?
    let href: String?
    let id: String?
    let images: [ImageDTO]?
    let name: String?
    let popularity: Int?
    let type: String?
    let uri: String?
    
}
