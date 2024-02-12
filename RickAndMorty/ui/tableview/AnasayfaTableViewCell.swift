//
//  TableViewCell.swift
//  RickAndMorty
//
//  Created by salih söğüt on 27.01.2024.
//

import UIKit

class AnasayfaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var characterSituationLabel: UILabel!
    @IBOutlet weak var characterGenderLabel: UILabel!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var characterCreatedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        rightView.layer.cornerRadius = 15
        backView.layer.cornerRadius = 15
        characterImage.layer.cornerRadius = 15
        
     
        
    }

}
