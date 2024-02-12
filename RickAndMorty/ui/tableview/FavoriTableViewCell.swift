//
//  FavoriTableViewCell.swift
//  RickAndMorty
//
//  Created by salih söğüt on 2.02.2024.
//

import UIKit

class FavoriTableViewCell: UITableViewCell {

    @IBOutlet weak var favoriCellLabel: UILabel!
    @IBOutlet weak var FavoriBackView: UIView!
    @IBOutlet weak var favoriCellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
