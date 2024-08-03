//
//  ItemCell.swift
//  TunaSort iOS
//
//  Created by MAGH on 22/07/24.
//

import UIKit

class ItemCell: UITableViewCell {
    
    //MARK: - UI Variables
    
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemSubtitle: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    
    var onPlayButtonTapped: (() -> Void)?
    
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        if onPlayButtonTapped != nil {
            onPlayButtonTapped!()
        }
    }
    
}
