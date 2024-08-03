//
//  PlaylistManager.swift
//  TunaSort iOS
//
//  Created by MAGH on 25/07/24.
//

import Foundation

class PlaylistManager {
    
    private var tracks: [TrackDTO] = []
    private var playlist: PlaylistDTO?
    
    func countTracks() -> Int{
        return tracks.count
    }
    
    func getTrack(at index : Int) -> TrackDTO {
        return tracks[index]
    }
    
    func getAllTracks() -> [TrackDTO] {
        return tracks
    }
    
    func getPlaylist() -> PlaylistDTO? {
        return playlist
    }
    
    func getRecommendations(seedArtists: String?, seedGenres: String?, seedTracks: String?, completion: @escaping (String?) -> Void) {
        SpotifyRepository.shared.getRecommendations(seedArtists: seedArtists, seedGenres: seedGenres, seedTracks: seedTracks) { data, response, error in
            
            //Check error
            if error != nil {
                completion(error!.localizedDescription)
                return
            }
            
            // Check response
            let httpResponse = response as! HTTPURLResponse
            if httpResponse.statusCode != 200 {
                do {
                    let errorResponse = try JSONDecoder().decode(ErrorResponseDTO.self, from: data!)
                    var errorString: String?
                    if errorResponse.error?.status != nil {
                        errorString = "Status \(errorResponse.error!.status!). "
                    }
                    if errorResponse.error?.message != nil && !(errorResponse.error!.message!.isEmpty) {
                        errorString = "\(errorString ?? "")\(errorResponse.error!.message!)"
                    } else {
                        errorString = "\(errorString ?? "")Unknown API error."
                    }
                    completion(errorString)
                    return
                } catch {
                    completion(error.localizedDescription)
                    return
                }
            }
            
            // Check  data
            if data == nil {
                completion("No data received")
                return
            }
            
            //Parse data
            do {
                let recommendationsResponse = try JSONDecoder().decode(RecommendationsResponseDTO.self, from: data!)
                self.tracks = recommendationsResponse.tracks ?? []
            } catch {
                completion(error.localizedDescription)
                return
            }
            
            completion(nil)
            return
            
        }
    }
    
    func getTopTracks(timeRange: String, completion: @escaping (String?) -> Void) {
        SpotifyRepository.shared.getTopTracks(timeRange: timeRange) { data, response, error in
            
            //Check error
            if error != nil {
                completion(error!.localizedDescription)
                return
            }
            
            // Check response
            let httpResponse = response as! HTTPURLResponse
            if httpResponse.statusCode != 200 {
                do {
                    let errorResponse = try JSONDecoder().decode(ErrorResponseDTO.self, from: data!)
                    var errorString: String?
                    if errorResponse.error?.status != nil {
                        errorString = "Status \(errorResponse.error!.status!). "
                    }
                    if errorResponse.error?.message != nil && !(errorResponse.error!.message!.isEmpty) {
                        errorString = "\(errorString ?? "")\(errorResponse.error!.message!)"
                    } else {
                        errorString = "\(errorString ?? "")Unknown API error."
                    }
                    completion(errorString)
                    return
                } catch {
                    completion(error.localizedDescription)
                    return
                }
            }
            
            // Check  data
            if data == nil {
                completion("No data received")
                return
            }
            
            //Parse data
            do {
                let topTracksResponse = try JSONDecoder().decode(TopTracksResponseDTO.self, from: data!)
                self.tracks = topTracksResponse.items ?? []
            } catch {
                completion(error.localizedDescription)
                return
            }
            
            completion(nil)
            return
            
        }
    }
    
    func createPlaylist(userId: String, name: String, description: String, isPublic: Bool, tracks: [TrackDTO], completion: @escaping (String?) -> Void) {
        do {
            //Create request data
            let createPlaylistRequest = CreatePlaylistRequest(name: name, description: description, isPublic: isPublic)
            let requestData = try JSONEncoder().encode(createPlaylistRequest)
            
            SpotifyRepository.shared.createPlaylist(userId: spotifyUserId!, requestData: requestData) { data, response, error in
                
                //Check error
                if error != nil {
                    completion(error!.localizedDescription)
                    return
                }
                
                // Check response
                let httpResponse = response as! HTTPURLResponse
                if httpResponse.statusCode != 201 {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponseDTO.self, from: data!)
                        var errorString: String?
                        if errorResponse.error?.status != nil {
                            errorString = "Status \(errorResponse.error!.status!). "
                        }
                        if errorResponse.error?.message != nil && !(errorResponse.error!.message!.isEmpty) {
                            errorString = "\(errorString ?? "")\(errorResponse.error!.message!)"
                        } else {
                            errorString = "\(errorString ?? "")Unknown API error."
                        }
                        completion(errorString)
                        return
                    } catch {
                        completion(error.localizedDescription)
                        return
                    }
                }
                
                // Check  data
                if data == nil {
                    completion("No data received")
                    return
                }
                
                //Parse data
                do {
                    let playlist = try JSONDecoder().decode(PlaylistDTO.self, from: data!)
                    print("PLAYLIST ID = \(playlist.id ?? "NULL")")
                    self.addItemsToPlaylist(playlist: playlist, tracks: tracks, completion: completion)
                    return
                } catch {
                    completion(error.localizedDescription)
                    return
                }
                
            }
        }catch let error {
            completion(error.localizedDescription)
            return
        }
    }
    
    func addItemsToPlaylist(playlist: PlaylistDTO, tracks: [TrackDTO], completion: @escaping (String?) -> Void) {
        do {
            //Create request data
            let addItemsToPlaylistRequest = AddItemsToPlaylistRequest(uris: tracks.map({track in track.uri!}))
            let requestData = try JSONEncoder().encode(addItemsToPlaylistRequest)
            
            SpotifyRepository.shared.addItemsToPlaylist(playlistId: playlist.id!, requestData: requestData) { data, response, error in
                
                //Check error
                if error != nil {
                    completion(error!.localizedDescription)
                    return
                }
                
                // Check response
                let httpResponse = response as! HTTPURLResponse
                if httpResponse.statusCode != 201 {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponseDTO.self, from: data!)
                        var errorString: String?
                        if errorResponse.error?.status != nil {
                            errorString = "Status \(errorResponse.error!.status!). "
                        }
                        if errorResponse.error?.message != nil && !(errorResponse.error!.message!.isEmpty) {
                            errorString = "\(errorString ?? "")\(errorResponse.error!.message!)"
                        } else {
                            errorString = "\(errorString ?? "")Unknown API error."
                        }
                        completion(errorString)
                        return
                    } catch {
                        completion(error.localizedDescription)
                        return
                    }
                }
                
                // Check  data
                if data == nil {
                    completion("No data received")
                    return
                }
                
                //Parse data
                self.playlist = playlist
                
                completion(nil)
                return
                
            }
        }catch let error {
            completion(error.localizedDescription)
            return
        }
    }
    
}
