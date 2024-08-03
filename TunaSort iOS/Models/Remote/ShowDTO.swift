//
//  ShowDTO.swift
//  TunaSort iOS
//
//  Created by MAGH on 22/07/24.
//

import Foundation

struct ShowDTO: Codable {
    
    enum CodingKeys: String, CodingKey {
        case availableMarkets = "available_markets"
        case copyrights = "copyrights"
        case description = "description"
        case explicit = "explicit"
        case externalUrls = "external_urls"
        case href = "href"
        case htmlDescription = "html_description"
        case id = "id"
        case images = "images"
        case isExternallyHosted = "is_externally_hosted"
        case languages = "languages"
        case mediaType = "media_type"
        case name = "name"
        case publisher = "publisher"
        case totalEpisodes = "total_episodes"
        case type = "type"
        case uri = "uri"
    }
    
    let availableMarkets: [String]?
    let copyrights: [CopyrightDTO]?
    let description: String?
    let explicit: Bool?
    let externalUrls: ExternalUrlsDTO?
    let href: String?
    let htmlDescription: String?
    let id: String?
    let images: [ImageDTO]?
    let isExternallyHosted: Bool?
    let languages: [String]?
    let mediaType: String?
    let name: String?
    let publisher: String?
    let totalEpisodes: Int?
    let type: String?
    let uri: String?
    
}
