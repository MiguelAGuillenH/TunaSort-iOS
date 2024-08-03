//
//  AddItemsToPlaylistRequest.swift
//  TunaSort iOS
//
//  Created by MAGH on 29/07/24.
//

import Foundation

struct AddItemsToPlaylistRequest: Codable {
    
    enum CodingKeys: String, CodingKey {
        case uris = "uris"
        case position = "position"
    }
    
    var uris: [String]
    var position: Int? = nil
    
}
