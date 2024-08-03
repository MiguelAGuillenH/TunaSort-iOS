//
//  SearchViewController.swift
//  TunaSort iOS
//
//  Created by MAGH on 16/07/24.
//

import UIKit
import SDWebImage
import AVFoundation

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AVAudioPlayerDelegate {
    
    //MARK: - UI Variables
    
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var searchTypeSelector: UISegmentedControl!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet var emptyResultsView: UIView!
    @IBOutlet weak var emptyResultsLabel: UILabel!
    
    //MARK: - Parameters
    
    var seedPosition: Int?
    
    //MARK: - Segmented control indexes
    
    let TRACKS_INDEX = 0
    let ARTISTS_INDEX = 1
    let GENRES_INDEX = 2
    
    //MARK: - Audio Player Variables
    
    var audioPlayer: AVAudioPlayer?
    var currentTrackPlaying: Int?
    var currentButtonPlaying: UIButton?
    
    //MARK: - Other variables
    
    var searchResultsManager = SearchResultsManager()
    var newSeed: Seed?
    var timer: Timer?
    var filteredGenres: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        //UI Configuration
        searchText.becomeFirstResponder()
        searchTableView.dataSource = self
        searchTableView.delegate = self
        
        searchTypeSelector.setTitleTextAttributes([.foregroundColor: UIColor(named: "TS_white")!], for: .normal)
        searchTypeSelector.setTitleTextAttributes([.foregroundColor: UIColor(named: "TS_black")!], for: .selected)
        
        updateEmptyView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        stopPreviewPlay()
    }
    
    //MARK: - UI Events
    
    @IBAction func searchTextDidChange(_ sender: UITextField) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
            self.updateUI(true)
        }
    }
    
    @IBAction func searchTypeChanged(_ sender: UISegmentedControl) {
        updateUI(true)
    }
    
    //MARK: - Navigation
    
    func didRequestUnwind() {
        performSegue(withIdentifier: "searchToSeedSelectionSegue", sender: nil)
    }
    
    //MARK: - Table View functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch searchTypeSelector.selectedSegmentIndex {
            case TRACKS_INDEX:
                return searchResultsManager.countTracks()
            case ARTISTS_INDEX:
                return searchResultsManager.countArtists()
            case GENRES_INDEX:
                //return searchResultsManager.countGenres()
                return filteredGenres.count
            default:
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemCell
        switch searchTypeSelector.selectedSegmentIndex {
            case TRACKS_INDEX:
                let track = searchResultsManager.getTrack(at: indexPath.row)
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
            case ARTISTS_INDEX:
                let artist = searchResultsManager.getArtist(at: indexPath.row)
                cell.itemTitle.text = artist.name
                cell.itemSubtitle.text = ""
                cell.itemSubtitle.isHidden = true
            
                if let url = URL(string: artist.images?.first?.url ?? ""	) {
                    cell.itemImage.sd_setImage(with: url)
                } else {
                    cell.itemImage.image = UIImage(named: "ic_artist")
                }
            
                cell.playButton.isHidden = true
            case GENRES_INDEX:
                //let genre = searchResultsManager.getGenre(at: indexPath.row)
                let genre = filteredGenres[indexPath.row]
                cell.itemTitle.text = genre
                cell.itemSubtitle.text = ""
                cell.itemSubtitle.isHidden = true
            
                cell.itemImage.image = UIImage(named: "ic_genre")
            
                cell.playButton.isHidden = true
            default:
                cell.itemTitle.text = ""
                cell.itemSubtitle.text = ""
            
                cell.itemImage.image = UIImage(named: "ic_album")
            
                cell.playButton.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch searchTypeSelector.selectedSegmentIndex {
            case TRACKS_INDEX:
                let track = searchResultsManager.getTrack(at: indexPath.row)
                newSeed = Seed(
                    id: track.id,
                    name: track.name,
                    thumbnail: track.album?.images?.first?.url ?? nil,
                    previewUrl: track.previewUrl,
                    type: .TRACK
                )
            case ARTISTS_INDEX:
                let artist = searchResultsManager.getArtist(at: indexPath.row)
                newSeed = Seed(
                    id: artist.id,
                    name: artist.name,
                    thumbnail: artist.images?.first?.url ?? nil,
                    previewUrl: nil,
                    type: .ARTIST
                )
            case GENRES_INDEX:
                let genre = filteredGenres[indexPath.row]
                newSeed = Seed (
                    id: genre,
                    name: genre,
                    thumbnail: nil,
                    previewUrl: nil,
                    type: .GENRE
                )
            default:
                newSeed = nil
        }
        self.didRequestUnwind()
    }
    
    //MARK: - Audio Player Delegate functions
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        currentButtonPlaying?.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
    //MARK: - Custom functions
    
    func updateUI(_ performSearch: Bool) {
        
        stopPreviewPlay()
        
        let query = searchText.text?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? ""
        
        //If genre is selected
        if searchTypeSelector.selectedSegmentIndex == GENRES_INDEX {
            //If it was already selected, just filter
            if searchResultsManager.countGenres() > 0 {
                self.filterGenres(query)
            //Otherwise, get genre seeds and filter
            } else {
                searchResultsManager.getGenreSeeds() {
                    DispatchQueue.main.async {
                        self.filterGenres(query)
                    }
                }
            }
        //If tracks or artists is selected
        } else {
            //If there is a query, search
            if !(query.isEmpty) {
                if performSearch {
                    switch searchTypeSelector.selectedSegmentIndex {
                        case TRACKS_INDEX:
                            searchResultsManager.search(query: query, type: "track") {
                                DispatchQueue.main.async {
                                    self.searchTableView.reloadData()
                                    self.updateEmptyView()
                                }
                            }
                        case ARTISTS_INDEX:
                            searchResultsManager.search(query: query, type: "artist") {
                                DispatchQueue.main.async {
                                    self.searchTableView.reloadData()
                                    self.updateEmptyView()
                                }
                            }
                        default:
                            break
                    }
                }
            //Otherwise, just clear the view
            } else {
                searchResultsManager.clearAllResults()
                searchTableView.reloadData()
                updateEmptyView()
            }
        }
        
    }
    
    func filterGenres(_ query: String){
        if query.isEmpty {
            filteredGenres = searchResultsManager.getAllGenres()
        } else {
            filteredGenres = searchResultsManager.getAllGenres().filter() { genre in
                return genre.lowercased().contains(query)
            }
        }
        searchTableView.reloadData()
        updateEmptyView()
    }
    
    func updateEmptyView(){
        //If view is empty, show the empty results view
        if searchTableView.numberOfRows(inSection: 0) == 0 {
            emptyResultsView.isHidden = false
            searchTableView.backgroundView = emptyResultsView
            //If track or artist selected, and no query, show "Query required"
            if searchTypeSelector.selectedSegmentIndex != GENRES_INDEX && (searchText.text == nil || searchText.text!.isEmpty) {
                emptyResultsLabel.text = "message.search.query_required".localized
            //Otherwise, show "No results"
            } else {
                emptyResultsLabel.text = "message.search.no_results".localized
            }
        //Otherwise, hide the view
        }else{
            emptyResultsView.isHidden = true
        }
    }
    
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
