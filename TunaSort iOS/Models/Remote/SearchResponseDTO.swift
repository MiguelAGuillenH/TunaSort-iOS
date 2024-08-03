//
//  SearchResponseDTO.swift
//  TunaSort iOS
//
//  Created by MAGH on 22/07/24.
//

import Foundation

struct SearchResponseDTO: Codable {
    
    enum CodingKeys: String, CodingKey {
        case albums = "albums"
        case artists = "artists"
        case tracks = "tracks"
    }
    
    let albums: SearchAlbumsDTO?
    let artists: SearchArtistsDTO?
    let tracks: SearchTracksDTO?
    
}
