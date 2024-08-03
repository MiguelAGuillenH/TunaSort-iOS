//
//  TrackDTO.swift
//  TunaSort iOS
//
//  Created by MAGH on 22/07/24.
//

import Foundation

struct TrackDTO: PlaylistItemDTO & Codable {
    
    enum CodingKeys: String, CodingKey {
        case album = "album"
        case artists = "artists"
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMs = "duration_ms"
        case explicit = "explicit"
        case externalIds = "external_ids"
        case externalUrls = "external_urls"
        case href = "href"
        case id = "id"
        case isLocal = "is_local"
        case isPlayable = "is_playable"
        //case linkedFrom = "linked_from"
        case name = "name"
        case popularity = "popularity"
        case previewUrl = "preview_url"
        case restrictions = "restrictions"
        case trackNumber = "track_number"
        case type = "type"
        case uri = "uri"
    }
    
    let album: AlbumDTO?
    let artists: [TrackArtistDTO]?
    let availableMarkets: [String]?
    let discNumber: Int?
    let durationMs: Int?
    let explicit: Bool?
    let externalIds: ExternalIdsDTO?
    let externalUrls: ExternalUrlsDTO?
    let href: String?
    let id: String?
    let isLocal: Bool?
    let isPlayable: Bool?
    //let linkedFrom: TrackDTO?
    let name: String?
    let popularity: Int?
    let previewUrl: String?
    let restrictions: RestrictionsDTO?
    let trackNumber: Int?
    let type: String?
    let uri: String?
    
}
