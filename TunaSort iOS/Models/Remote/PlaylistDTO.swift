//
//  PlaylistDTO.swift
//  TunaSort iOS
//
//  Created by MAGH on 22/07/24.
//

import Foundation

struct PlaylistDTO: Codable {
    
    enum CodingKeys: String, CodingKey {
        case collaborative = "collaborative"
        case description = "description"
        case externalUrls = "external_urls"
        case followers = "followers"
        case href = "href"
        case id = "id"
        case images = "images"
        case name = "name"
        case owner = "owner"
        case isPublic = "public"
        case snapshotId = "snapshot_id"
        case tracks = "tracks"
        case type = "type"
        case uri = "uri"
    }
    
    let collaborative: Bool?
    let description: String?
    let externalUrls: ExternalUrlsDTO?
    let followers: FollowersDTO?
    let href: String?
    let id: String?
    let images: [ImageDTO]?
    let name: String?
    let owner: OwnerDTO?
    let isPublic: Bool?
    let snapshotId: String?
    let tracks: PlaylistTracksDTO?
    let type: String?
    let uri: String?
    
}
