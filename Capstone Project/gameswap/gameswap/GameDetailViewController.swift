//
//  GameDetailViewController.swift
//  gameswap
//
//  Created by Balaj Khalid on 4/20/24.
//

import UIKit

class GameDetailViewController: UIViewController {

    @IBOutlet weak var gameDetailImageView: UIImageView!
    @IBOutlet weak var gameDetailTitleLabel: UILabel!
    @IBOutlet weak var gameDetailDescription: UILabel!
    @IBOutlet weak var gameDetailPrice: UILabel!
    
    @IBOutlet weak var chatButton: UIButton!
    
    var game: Games!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        gameDetailTitleLabel.text = game.title
        gameDetailImageView.image = game.image
        gameDetailDescription.text = game.description
        gameDetailPrice.text = game.price
        
        gameDetailTitleLabel.layer.cornerRadius = 10 // Adjust the corner radius as needed
        gameDetailTitleLabel.clipsToBounds = true
        
        gameDetailDescription.layer.cornerRadius = 10 // Adjust the corner radius as needed
        gameDetailDescription.clipsToBounds = true
        
        gameDetailPrice.layer.cornerRadius = 10 // Adjust the corner radius as needed
        gameDetailPrice.clipsToBounds = true
        
        // Assuming btn is your UIButton
        chatButton.backgroundColor = UIColor(red: 0, green: 0.8, blue: 0, alpha: 1) // Change color
        chatButton.tintColor = UIColor(red: 0, green: 0.8, blue: 0, alpha: 1)
        chatButton.layer.cornerRadius = 10
        chatButton.setNeedsDisplay() // Trigger UI update

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
