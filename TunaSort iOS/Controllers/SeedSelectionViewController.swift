//
//  SeedSelectionViewController.swift
//  TunaSort iOS
//
//  Created by MAGH on 16/07/24.
//

import UIKit

class SeedSelectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //MARK: - UI Variables
    
    @IBOutlet weak var seedCollectionView: UICollectionView!

    //MARK: - Parameters
    
    var playlistMode: String?
    
    //MARK: - Other variables
    
    var seedManager = SeedManager()
    var seedPosition: Int?
    
    //MARK: - View Controller events

    override func viewDidLoad() {
        super.viewDidLoad()

        //Set up CollectionView
        seedCollectionView.dataSource = self
        seedCollectionView.delegate = self
    }
    
    //MARK: - UI Events
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        if seedManager.countSeeds() > 0 {
            self.performSegue(withIdentifier: "seedSelectionToPlaylistPreviewSegue", sender: self)
        } else {
            self.presentAlertController(title: "Error de validación.", message: "Se requiere al menos una semilla para generar la playlist.", buttonTitle: "Entendido")
        }
    }
    
    //MARK: - Collection View functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = seedManager.countSeeds()
        return count + ((count < Constants.MAX_SEED_LIST_SIZE) ? 1 : 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = seedCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SeedCell
        
        if indexPath.row < seedManager.countSeeds() {
            let seed = seedManager.getSeed(at: indexPath.row)
            cell.seedName.text = seed.name
            cell.seedType.text = seed.type.rawValue.localized
            
            if let url = URL(string: seed.thumbnail ?? "") {
                cell.seedImage.sd_setImage(with: url)
            } else {
                switch seed.type {
                    case .TRACK:
                        cell.seedImage.image = UIImage(named: "ic_album")
                    case .ARTIST:
                        cell.seedImage.image = UIImage(named: "ic_artist")
                    case .GENRE:
                        cell.seedImage.image = UIImage(named: "ic_genre")
                }
            }
        } else {
            cell.seedName.text = "Add seed..."
            cell.seedType.text = ""
            cell.seedImage.image = UIImage(named: "ic_add")
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < seedManager.countSeeds() {
            //Show seed detail alert
            let alert = SeedDetailViewController()
            alert.seed = seedManager.getSeed(at: indexPath.row)
            alert.onSeedEdit = {
                self.seedPosition = indexPath.row
                self.performSegue(withIdentifier: "seedSelectionToSearchSegue", sender: self)
            }
            alert.onSeedDelete = {
                self.seedManager.deleteSeed(at: indexPath.row)
                self.seedCollectionView.reloadData()
            }
            self.present(alert, animated: true)
        } else {
            seedPosition = nil
            self.performSegue(withIdentifier: "seedSelectionToSearchSegue", sender: self)
        }
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "seedSelectionToSearchSegue":
                let destination = segue.destination as! SearchViewController
                destination.seedPosition = seedPosition
            case "seedSelectionToPlaylistPreviewSegue":
                let destination = segue.destination as! PlaylistPreviewViewController
                destination.playlistMode = playlistMode
                destination.seeds = seedManager.getSeeds()
            default:
                break
        }
    }
    
    @IBAction func seedSelectedUnwind(_ segue: UIStoryboardSegue) {
        let source = segue.source as! SearchViewController
        let newSeed = source.newSeed
        let seedPosition = source.seedPosition
        
        //Create/update seed
        if newSeed != nil {
            if seedPosition == nil {
                seedManager.createSeed(newSeed!)
            } else {
                seedManager.updateSeed(at: seedPosition!, newSeed!)
            }
        }
        
        //Reload collection view
        seedCollectionView.reloadData()
    }
    
}
