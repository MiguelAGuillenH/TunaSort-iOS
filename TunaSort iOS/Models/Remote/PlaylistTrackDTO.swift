//
//  PlaylistTrackDTO.swift
//  TunaSort iOS
//
//  Created by MAGH on 22/07/24.
//

import Foundation

struct PlaylistTrackDTO: Codable {
    
    let addedAt: String?
    let addedBy: AddedByUserDTO?
    let isLocal: Bool?
    let track: PlaylistItemDTO?
    
    enum CodingKeys: String, CodingKey {
        case addedAt = "added_at"
        case addedBy = "added_by"
        case isLocal = "is_local"
        case track = "track"
    }
    
    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encode(addedAt, forKey: .addedAt)
        try c.encode(addedBy, forKey: .addedBy)
        try c.encode(isLocal, forKey: .isLocal)
        if let track = track as? TrackDTO {
            try c.encode(track, forKey: .track)
        } else if let episode = track as? EpisodeDTO {
            try c.encode(episode, forKey: .track)
        }
    }
    
    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        addedAt = try c.decode(String.self, forKey: .addedAt)
        addedBy = try c.decode(AddedByUserDTO.self, forKey: .addedBy)
        isLocal = try c.decode(Bool.self, forKey: .isLocal)
        if let ttrack = try? c.decode(TrackDTO.self, forKey: .track) {
            track = ttrack
        } else if let episode = try? c.decode(EpisodeDTO.self, forKey: .track) {
            track = episode
        } else {
            track = nil
        }
    }
    
}
