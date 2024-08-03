//
//  CreatePlaylistRequest.swift
//  TunaSort iOS
//
//  Created by MAGH on 29/07/24.
//

import Foundation

struct CreatePlaylistRequest: Codable {
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case description = "description"
        case isPublic = "public"
        case collaborative = "collaborative"
    }
    
    var name: String
    var description: String
    var isPublic: Bool
    var collaborative: Bool = false
    
}
