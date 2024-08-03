//
//  SeedDetailViewController.swift
//  TunaSort iOS
//
//  Created by DISMOV on 25/07/24.
//

import UIKit
import AVFoundation

class SeedDetailViewController: UIViewController, AVAudioPlayerDelegate {
    
    static let controllerIdentifier = String(describing: SeedDetailViewController.self)
    
    //MARK: - UI Variables
    
    @IBOutlet weak var seedTitle: UILabel!
    @IBOutlet weak var seedSubtitle: UILabel!
    @IBOutlet weak var seedImage: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    
    //MARK: - Parameters
    
    var seed: Seed?
    var onSeedEdit: (() -> Void)?
    var onSeedDelete: (() -> Void)?
    
    //MARK: - Other variables
    
    var audioPlayer: AVAudioPlayer?
    
    //MARK: - View Controller events
    
    init() {
        super.init(nibName: SeedDetailViewController.controllerIdentifier, bundle: Bundle(for: SeedDetailViewController.self))
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if seed != nil {
            seedTitle.text = seed!.name
            seedSubtitle.text = seed!.type.rawValue.localized
            
            if let url = URL(string: seed!.thumbnail ?? "") {
                seedImage.sd_setImage(with: url)
            } else {
                switch seed!.type {
                    case .TRACK:
                        seedImage.image = UIImage(named: "ic_album")
                    case .ARTIST:
                        seedImage.image = UIImage(named: "ic_artist")
                    case .GENRE:
                        seedImage.image = UIImage(named: "ic_genre")
                }
            }
            
            if seed!.previewUrl != nil && !(seed!.previewUrl!.isEmpty) {
                playButton.isHidden = false
                playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                playButton.imageView?.contentMode = .scaleAspectFit
                playButton.imageView?.animationImages = Constants.ANIM_LOADING
            } else {
                playButton.isHidden = true
            }
        } else {
            seedTitle.text = ""
            seedSubtitle.text = ""
            playButton.isHidden = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        audioPlayer?.stop()
        audioPlayer = nil
    }
    
    //MARK: - UI Events
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        if audioPlayer == nil {
            audioPlayerSetup(urlString: seed!.previewUrl!)
        } else {
            togglePlay()
        }
    }
    
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
        if onSeedEdit != nil {
            onSeedEdit!()
            
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        let controller = UIAlertController(title: "Confirmación", message: "¿Realmente desea eliminer la semilla?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Aceptar", style: .default) { _ in
            self.dismiss(animated: true)
            if self.onSeedDelete != nil {
                self.onSeedDelete!()
            }
        }
        yesAction.setValue(UIColor(named: "TS_green"), forKey: "titleTextColor")
        let noAction = UIAlertAction(title: "Cancelar", style: .default) { _ in
            self.dismiss(animated: true)
        }
        noAction.setValue(UIColor(named: "TS_green"), forKey: "titleTextColor")
        controller.addAction(yesAction)
        controller.addAction(noAction)
        self.present(controller, animated: true)
    }
    
    @IBAction func outsideTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    //MARK: - Audio Player Delegate functions
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
    //MARK: - Custom functions
    
    func audioPlayerSetup(urlString: String) {
        if let url = URL(string: urlString) {
            playButton.imageView?.startAnimating()
            let request = URLRequest(url: url)
            let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
            let task = session.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    self.playButton.imageView?.stopAnimating()
                    if error != nil {
                        self.presentAlertController(title: "Error al descargar audio.", message: error!.localizedDescription, buttonTitle: "Ok")
                    } else if data == nil {
                        self.presentAlertController(title: "Error al descargar audio.", message: "No data available.", buttonTitle: "Ok")
                    } else {
                        do {
                            self.audioPlayer = try AVAudioPlayer(data: data!)
                            self.audioPlayer?.delegate = self
                            self.togglePlay()
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
    
    func togglePlay() {
        if audioPlayer!.isPlaying {
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            audioPlayer!.pause()
        } else {
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            audioPlayer!.play()
        }
    }
    
}
