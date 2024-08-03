//
//  SearchResultsManager.swift
//  TunaSort iOS
//
//  Created by MAGH on 18/07/24.
//

import Foundation

class SearchResultsManager {
    
    private var tracks: [TrackDTO] = []
    private var artists: [TrackArtistDTO] = []
    private var genres: [String] = []
    
    func countTracks() -> Int{
        return tracks.count
    }
    
    func getTrack(at index : Int) -> TrackDTO {
        return tracks[index]
    }
    
    func countArtists() -> Int{
        return artists.count
    }
    
    func getArtist(at index : Int) -> TrackArtistDTO {
        return artists[index]
    }
    
    func countGenres() -> Int{
        return genres.count
    }
    
    func getGenre(at index : Int) -> String {
        return genres[index]
    }
    
    func getAllGenres() -> [String] {
        return genres
    }
    
    func clearAllResults() {
        tracks = []
        artists = []
        genres = []
    }
    
    func search(query: String, type: String, completion: @escaping () -> Void) {
        SpotifyRepository.shared.search(query: query, type: type) { data, response, error in
            //DispatchQueue.main.async {
                if (error == nil) {
                    do {
                        let searchResponse = try JSONDecoder().decode(SearchResponseDTO.self, from: data!)
                        if type == "track" {
                            self.tracks = searchResponse.tracks?.items ?? []
                            self.artists = []
                            self.genres = []
                        } else {
                            self.tracks = []
                            self.artists = searchResponse.artists?.items ?? []
                            self.genres = []
                        }
                        
                    } catch {
                        print("Error al realizar búsqueda: \(error.localizedDescription)")
                        //self.presentAlertController(title: "Error al realizar bùsqueda", message: error.localizedDescription, buttonTitle: "Continuar")
                    }
                } else {
                    print("Error al realizar búsqueda: \(error!.localizedDescription)")
                    //self.presentAlertController(title: "Error al realizar bùsqueda", message: error!.localizedDescription, buttonTitle: "Continuar")
                }
                completion()
            //}
        }
    }
    
    func getGenreSeeds(completion: @escaping () -> Void) {
        SpotifyRepository.shared.getGenreSeeds() { data, response, error in
            //DispatchQueue.main.async {
                if (error == nil) {
                    do {
                        let searchResponse = try JSONDecoder().decode(GenreSeedsResponseDTO.self, from: data!)
                        self.tracks = []
                        self.artists = []
                        self.genres = searchResponse.genres ?? []
                        
                    } catch {
                        print("Error al realizar búsqueda: \(error.localizedDescription)")
                        //self.presentAlertController(title: "Error al realizar bùsqueda", message: error.localizedDescription, buttonTitle: "Continuar")
                    }
                } else {
                    print("Error al realizar búsqueda: \(error!.localizedDescription)")
                    //self.presentAlertController(title: "Error al realizar bùsqueda", message: error!.localizedDescription, buttonTitle: "Continuar")
                }
                completion()
            //}
        }
    }
    
}


