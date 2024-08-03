//
//  ModeSelectionViewController.swift
//  TunaSort iOS
//
//  Created by DISMOV on 16/07/24.
//

import UIKit

class ModeSelectionViewController: UIViewController {
    
    //MARK: - Mode selection variables
    
    var currentModeSelection: String?
    
    //MARK: - View Controller Events

    override func viewDidLoad() {
        super.viewDidLoad()

        //Remove Login from Navigation controller
        guard let navigationController = self.navigationController else { return }
        var navigationArray = navigationController.viewControllers // To get all UIViewController stack as Array
        navigationArray.remove(at: navigationArray.count - 2) // To remove previous UIViewController
        self.navigationController?.viewControllers = navigationArray
    }
    
    //MARK: - UI Events
    
    @IBAction func recommendationsButtonTapped(_ sender: UIButton) {
        currentModeSelection = Constants.MODE_RECOMMENDATIONS
        self.performSegue(withIdentifier: "modeSelectionToSeedSelectionSegue", sender: self)
    }
    
    @IBAction func topItemsTapped(_ sender: UIButton) {
        currentModeSelection = Constants.MODE_TOP_ITEMS
        self.performSegue(withIdentifier: "modeSelectionToPlaylistPreviewSegue", sender: self)
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "modeSelectionToSeedSelectionSegue":
                let destination = segue.destination as! SeedSelectionViewController
                destination.playlistMode = currentModeSelection
            case "modeSelectionToPlaylistPreviewSegue":
                let destination = segue.destination as! PlaylistPreviewViewController
                destination.playlistMode = currentModeSelection
            default:
                break
        }
    }
    
    @IBAction func playlistPreviewUnwind(_ segue: UIStoryboardSegue) {
        
    }
    
}
