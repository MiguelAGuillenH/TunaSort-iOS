//
//  Constants.swift
//  TunaSort iOS
//
//  Created by MAGH on 16/07/24.
//

import Foundation

struct Constants {
    
    static let SPOTIFY_BASE_URL = "https://api.spotify.com/v1/"
    static let SPOTIFY_CLIENT_ID = "0f96c4a3dec64233944acfe496ce54b3"
    static let SPOTIFY_CLIENT_SECRET = "3d05df5c10bb4eda8f5656a7caedc428"
    static let SPOTIFY_REDIRECT_URL = URL(string: "com.magh.TunaSort-iOS://callback")!
    
    static let SCOPES: SPTScope = [
        .playlistModifyPrivate,
        .playlistModifyPublic,
        .userReadPrivate,
        .userTopRead
    ]
    
    static let MODE_TOP_ITEMS = "TopItems"
    static let MODE_RECOMMENDATIONS = "Recommendations"
    
    static let MAX_SEED_LIST_SIZE = 5
    static let DEFAULT_SEARCH_LIMIT = 20
    static let DEFAULT_RECOMMENDATIONS_LIMIT = 50
    static let DEFAULT_TOP_ITEMS_LIMIT = 50
    static let DEFAULT_OFFSET = 0
    
    static var ANIM_PLAYMENT: [UIImage] {
        var array: [UIImage] = []
        for i in 0...72 {
            array.append(UIImage(named: "frame" + String(format: "%02d", i))!)
        }
        return array
    }
    
    static var ANIM_LOADING: [UIImage] {
        var array: [UIImage] = []
        for i in 0...11 {
            array.append(UIImage(named: "loading" + String(format: "%02d", i) + "_w24")!)
        }
        return array
    }
    
}
