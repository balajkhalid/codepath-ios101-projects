//
//  GameCollectionViewCell.swift
//  gameswap
//
//  Created by Balaj Khalid on 4/20/24.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func setup(with game: Games){
        titleLabel.text = game.title
        gameImageView.image = game.image
        priceLabel.text = game.price
    }
}
