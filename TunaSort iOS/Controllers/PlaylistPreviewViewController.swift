//
//  PlaylistPreviewViewController.swift
//  TunaSort iOS
//
//  Created by MAGH on 16/07/24.
//

import UIKit
import SDWebImage
import AVFoundation

class PlaylistPreviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AVAudioPlayerDelegate {
    
    //MARK: - UI Variables
    
    @IBOutlet weak var playlistTableView: UITableView!
    @IBOutlet weak var playmentIcon: UIImageView!
    @IBOutlet weak var mainView: UIView!
    
    //MARK: - Parameters
    
    var playlistMode: String?
    var seeds: [Seed]?
    
    //MARK: - Audio Player Variables
    
    var audioPlayer: AVAudioPlayer?
    var currentTrackPlaying: Int?
    var currentButtonPlaying: UIButton?
    
    //MARK: - Other variables
    
    var playlistManager = PlaylistManager()
    
    //MARK: - View Controller events

    override func viewDidLoad() {
        super.viewDidLoad()

        //Set up TableView
        playlistTableView.dataSource = self
        playlistTableView.delegate = self
        
        //Set up animation
        playmentIcon.animationImages = Constants.ANIM_PLAYMENT
        playmentIcon.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        switch playlistMode {
            case Constants.MODE_RECOMMENDATIONS:
                //Split seeds
                var seedArtists = ""
                var seedGenres = ""
                var seedTracks = ""
                
                seeds?.forEach() { seed in
                    if seed.id != nil {
                        switch seed.type {
                            case .ARTIST:
                                seedArtists = seedArtists + "," + seed.id!
                            case .GENRE:
                                seedGenres = seedGenres + "," + seed.id!
                            case .TRACK:
                                seedTracks = seedTracks + "," + seed.id!
                        }
                    }
                }
            
                //Get recommendations
                playlistManager.getRecommendations(
                    seedArtists: !(seedArtists.isEmpty) ? String(seedArtists.dropFirst(1)) : nil,
                    seedGenres: !(seedGenres.isEmpty) ? String(seedGenres.dropFirst(1)) : nil,
                    seedTracks: !(seedTracks.isEmpty) ? String(seedTracks.dropFirst(1)) : nil
                ) { error in
                    //DispatchQueue.main.async {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.playmentIcon.stopAnimating()
                        self.playlistTableView.reloadData()
                        self.playmentIcon.isHidden = true
                        if error != nil {
                            self.presentAlertController(title: "Error al obtener playlist.", message: error!, buttonTitle: "OK")
                        }
                        self.mainView.isHidden = false
                    }
                }
            case Constants.MODE_TOP_ITEMS:
                //Get top items
                playlistManager.getTopTracks(timeRange: "long_term") { error in
                    //DispatchQueue.main.async {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.playmentIcon.stopAnimating()
                        self.playlistTableView.reloadData()
                        self.playmentIcon.isHidden = true
                        if error != nil {
                            self.presentAlertController(title: "Error al obtener playlist.", message: error!, buttonTitle: "OK")
                        }
                        self.mainView.isHidden = false
                    }
                }
            default:
                break
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        stopPreviewPlay()
    }
    
    //MARK: - UI Events
    
    @IBAction func savePlaylistTapped(_ sender: UIButton) {
        if playlistManager.countTracks() > 0 {
            stopPreviewPlay()
            playlistManager.createPlaylist(userId: spotifyUserId!, name: "My TunaSort Playlist", description: "Playlist created with TunaSort", isPublic: true, tracks: playlistManager.getAllTracks()) { error in
                DispatchQueue.main.async {
                    if error != nil {
                        self.presentAlertController(title: "Error al obtener playlist.", message: error!, buttonTitle: "OK")
                    } else {
                        let playlist = self.playlistManager.getPlaylist()
                        self.presentAlertController(title: "¡Playlist generada exitosamente!", message: playlist?.externalUrls?.spotify ?? "", buttonTitle: "Dejame ver...") { _ in
                            if let url = URL(string: playlist?.externalUrls?.spotify ?? "") {
                                UIApplication.shared.open(url)
                            }
                        }
                    }
                }
            }
        }
    }
    
    //MARK: - Table View Controller functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlistManager.countTracks()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = playlistTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemCell
        let track = playlistManager.getTrack(at: indexPath.row)
        
        cell.itemTitle.text = track.name
        cell.itemSubtitle.text = track.artists?.first?.name
        cell.itemSubtitle.isHidden = false
    
        if let url = URL(string: track.album?.images?.first?.url ?? "") {
            cell.itemImage.sd_setImage(with: url)
        } else {
            cell.itemImage.image = UIImage(named: "ic_album")
        }
    
        if track.previewUrl != nil && !(track.previewUrl!.isEmpty) {
            cell.playButton.isHidden = false
            cell.playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            cell.playButton.imageView?.contentMode = .scaleAspectFit
            cell.playButton.imageView?.animationImages = Constants.ANIM_LOADING
            cell.onPlayButtonTapped = {
                let button = cell.playButton!
                let trackUrl = track.previewUrl!
                let position = indexPath.row
                
                if self.audioPlayer != nil && self.currentTrackPlaying != nil && self.currentTrackPlaying != position {
                    self.stopPreviewPlay()
                }
                self.currentTrackPlaying = position
                self.currentButtonPlaying = button
                if self.audioPlayer == nil {
                    self.audioPlayerSetup(playButton: button, urlString: trackUrl)
                } else {
                    self.togglePlay(playButton: button)
                }
            }
        } else {
            cell.playButton.isHidden = true
        }
        
        return cell
    }
    
    //MARK: - Audio Player Delegate functions
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        currentButtonPlaying?.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
    //MARK: - Custom functions
    
    func audioPlayerSetup(playButton: UIButton, urlString: String) {
        if let url = URL(string: urlString) {
            playButton.imageView?.startAnimating()
            let request = URLRequest(url: url)
            let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
            let task = session.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    playButton.imageView?.stopAnimating()
                    if error != nil {
                        self.presentAlertController(title: "Error al descargar audio.", message: error!.localizedDescription, buttonTitle: "Ok")
                    } else if data == nil {
                        self.presentAlertController(title: "Error al descargar audio.", message: "No data available.", buttonTitle: "Ok")
                    } else {
                        do {
                            self.audioPlayer = try AVAudioPlayer(data: data!)
                            self.audioPlayer?.delegate = self
                            self.togglePlay(playButton: playButton)
                        } catch {
                            self.presentAlertController(title: "Error al cargar audio.", message: error.localizedDescription, buttonTitle: "Ok")
                        }
                    }
                }
            }
            task.resume()
        } else {
            self.presentAlertController(title: "Error al descargar audio.", message: "El link del recurso no es válido.", buttonTitle: "Ok")
        }
    }
    
    func togglePlay(playButton: UIButton) {
        if audioPlayer!.isPlaying {
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            audioPlayer!.pause()
        } else {
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            audioPlayer!.play()
        }
    }
    
    func stopPreviewPlay() {
        audioPlayer?.stop()
        audioPlayer = nil
        currentButtonPlaying?.setImage(UIImage(systemName: "play.fill"), for: .normal)
        currentTrackPlaying = nil
        currentButtonPlaying = nil
    }

}
