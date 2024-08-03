//
//  AlbumDTO.swift
//  TunaSort iOS
//
//  Created by MAGH on 22/07/24.
//

import Foundation

struct AlbumDTO: Codable {
    
    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case artists = "artists"
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case href = "href"
        case id = "id"
        case images = "images"
        case name = "name"
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        //case restrictions = "restrictions"
        case totalTracks = "total_tracks"
        case type = "type"
        case uri = "uri"
    }
    
    let albumType: String?
    let artists: [AlbumArtistDTO]?
    let availableMarkets: [String]?
    let externalUrls: ExternalUrlsDTO?
    let href: String?
    let id: String?
    let images: [ImageDTO]?
    let name: String?
    let releaseDate: String?
    let releaseDatePrecision: String?
    //let restrictions: RestrictionsDTO?
    let totalTracks: Int?
    let type: String?
    let uri: String?
    
}
