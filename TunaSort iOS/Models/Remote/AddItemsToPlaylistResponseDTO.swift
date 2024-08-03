//
//  AddItemsToPlaylistResponseDTO.swift
//  TunaSort iOS
//
//  Created by MAGH on 22/07/24.
//

import Foundation

struct AddItemsToPlaylistResponseDTO: Codable {
    
    enum CodingKeys: String, CodingKey {
        case snapshotId = "snapshot_id"
    }
    
    let snapshotId: String?
    
}
