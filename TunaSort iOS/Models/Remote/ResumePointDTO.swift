//
//  ResumePointDTO.swift
//  TunaSort iOS
//
//  Created by MAGH on 22/07/24.
//

import Foundation

struct ResumePointDTO: Codable {
    
    enum CodingKeys: String, CodingKey {
        case fullyPlayed = "fully_played"
        case resumePositionMs = "resume_position_ms"
    }
    
    let fullyPlayed: Bool?
    let resumePositionMs: Int?
    
}
