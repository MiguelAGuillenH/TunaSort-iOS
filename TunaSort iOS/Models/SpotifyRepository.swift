//
//  SpotifyRepository.swift
//  TunaSort iOS
//
//  Created by MAGH on 22/07/24.
//

import Foundation

class SpotifyRepository {
    
    //MARK: - Singleton configuration
    
    private init() {}
    
    static var shared: SpotifyRepository = {
        let instance = SpotifyRepository()
        return instance
    }()
    
    //MARK: - API calls
    
    func alternateLogin(completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        let urlString = "https://accounts.spotify.com/api/token?grant_type=client_credentials"
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let strBearer = Data("\(Constants.SPOTIFY_CLIENT_ID):\(Constants.SPOTIFY_CLIENT_SECRET)".utf8).base64EncodedString()
        request.setValue("Basic \(strBearer)", forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
        let task = session.dataTask(with: request, completionHandler: completion)
        task.resume()
        
    }
    
    //https://api.spotify.com/v1/me
    func getCurrentUserProfile(completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        let urlString = Constants.SPOTIFY_BASE_URL + "me"
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let strBearer = spotifyToken!
        request.setValue("Bearer \(strBearer)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
        let task = session.dataTask(with: request, completionHandler: completion)
        task.resume()
        
    }
    
    //https://api.spotify.com/v1/recommendations?seed_artists=4NHQUGzhtTLFvgF5SZesLK&seed_genres=classical%2Ccountry&seed_tracks=0c6xIDDpzE81m2q797ordA
    func getRecommendations(seedArtists: String?, seedGenres: String?, seedTracks: String?, limit: Int = Constants.DEFAULT_RECOMMENDATIONS_LIMIT, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        let urlString = Constants.SPOTIFY_BASE_URL + "recommendations"
        var url = URL(string: urlString)
        url!.append(queryItems: [
            URLQueryItem(name: "seed_artists", value: seedArtists),
            URLQueryItem(name: "seed_genres", value: seedGenres),
            URLQueryItem(name: "seed_tracks", value: seedTracks),
            URLQueryItem(name: "limit", value: String(limit))
        ])
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let strBearer = spotifyToken!
        request.setValue("Bearer \(strBearer)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
        let task = session.dataTask(with: request, completionHandler: completion)
        task.resume()
        
    }
    
    //https://api.spotify.com/v1/me/top/tracks?time_range=long_term
    func getTopTracks(timeRange: String, limit: Int = Constants.DEFAULT_TOP_ITEMS_LIMIT, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        let urlString = Constants.SPOTIFY_BASE_URL + "me/top/tracks"
        var url = URL(string: urlString)
        url!.append(queryItems: [
            URLQueryItem(name: "time_range", value: timeRange),
            URLQueryItem(name: "limit", value: String(limit))
        ])
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let strBearer = spotifyToken!
        request.setValue("Bearer \(strBearer)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
        let task = session.dataTask(with: request, completionHandler: completion)
        task.resume()
        
    }
    
    //https://api.spotify.com/v1/search?q=Miles%2520Davis&type=album&limit=20&offset=0
    func search(query: String, type: String, limit: Int = Constants.DEFAULT_SEARCH_LIMIT, offset: Int = Constants.DEFAULT_OFFSET, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        let urlString = Constants.SPOTIFY_BASE_URL + "search"
        var url = URL(string: urlString)
        url!.append(queryItems: [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "type", value: type),
            URLQueryItem(name: "limit", value: String(limit)),
            URLQueryItem(name: "offset", value: String(offset))
        ])
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let strBearer = spotifyToken!
        request.setValue("Bearer \(strBearer)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
        let task = session.dataTask(with: request, completionHandler: completion)
        task.resume()
        
    }
    
    //https://api.spotify.com/v1/recommendations/available-genre-seeds
    func getGenreSeeds(completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        let urlString = Constants.SPOTIFY_BASE_URL + "recommendations/available-genre-seeds"
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let strBearer = spotifyToken!
        request.setValue("Bearer \(strBearer)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
        let task = session.dataTask(with: request, completionHandler: completion)
        task.resume()
        
    }
    
    //https://api.spotify.com/v1/users/smedjan/playlists
    func createPlaylist(userId: String, requestData: Data, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        let urlString = Constants.SPOTIFY_BASE_URL + "users/" + userId + "/playlists"
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let strBearer = spotifyToken!
        request.setValue("Bearer \(strBearer)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = requestData
        
        let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
        let task = session.dataTask(with: request, completionHandler: completion)
        task.resume()
        
    }
    
    //https://api.spotify.com/v1/playlists/3cEYpjA9oz9GiPac4AsH4n/tracks
    func addItemsToPlaylist(playlistId: String, requestData: Data, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        let urlString = Constants.SPOTIFY_BASE_URL + "playlists/" + playlistId + "/tracks"
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let strBearer = spotifyToken!
        request.setValue("Bearer \(strBearer)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = requestData
        
        let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
        let task = session.dataTask(with: request, completionHandler: completion)
        task.resume()
        
    }
    
}




