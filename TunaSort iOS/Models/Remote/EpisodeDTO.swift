//
//  EpisodeDTO.swift
//  TunaSort iOS
//
//  Created by MAGH on 22/07/24.
//

import Foundation

struct EpisodeDTO: PlaylistItemDTO & Codable {
    
    enum CodingKeys: String, CodingKey {
        case audioPreviewUrl = "audio_preview_url"
        case description = "description"
        case htmlDescription = "html_description"
        case durationMs = "duration_ms"
        case externalUrls = "external_urls"
        case href = "href"
        case id = "id"
        case images = "images"
        case isExternallyHosted = "is_externally_hosted"
        case isPlayable = "is_playable"
        //case language = "language"
        case languages = "languages"
        case name = "name"
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case resumePoint = "resume_point"
        case type = "type"
        case uri = "uri"
        case restrictions = "restrictions"
        case show = "show"
    }
    
    let audioPreviewUrl: String?
    let description: String?
    let htmlDescription: String?
    let durationMs: Int?
    let externalUrls: ExternalUrlsDTO?
    let href: String?
    let id: String?
    let images: [ImageDTO]?
    let isExternallyHosted: Bool?
    let isPlayable: Bool?
    //let language: String?
    let languages: [String]?
    let name: String?
    let releaseDate: String?
    let releaseDatePrecision: String?
    let resumePoint: ResumePointDTO?
    let type: String?
    let uri: String?
    let restrictions: RestrictionsDTO?
    let show: ShowDTO?
    
}
