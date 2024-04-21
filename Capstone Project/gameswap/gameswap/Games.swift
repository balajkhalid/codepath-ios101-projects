//
//  Games.swift
//  gameswap
//
//  Created by Balaj Khalid on 4/20/24.
//

import Foundation
import UIKit

struct Games{
    let title: String
    let image: UIImage
    let price: String
    let description: String
}

let gamesCollection: [Games] = [
    Games(title: "Red Dead Redemption 2",
          image: UIImage(named: "rdr2")!,
          price: "$ 34.99",
          description: "Red Dead Redemption 2 (PS4) available for sale.\nCondition is 10/10.\nPickup Only"),
    Games(title: "Grand Theft Auto V",
          image: UIImage(named: "gtav")!,
          price: "$ 29.99",
          description: "Grand Theft Auto (PS5) available for sale.\nCondition is 9/10.\nPickup Only"),
    Games(title: "Marvel Spiderman 2",
          image: UIImage(named: "spiderman2")!,
          price: "$ 44.99",
          description: "Marvel Spiderman 2 (PS5) available for sale.\nCondition is 10/10.\nPickup Only"),
    Games(title: "The Witcher 3",
          image: UIImage(named: "witcher3")!,
          price: "$ 9.99",
          description: "The Witcher 3: Wild Hunt (PS4) available for sale.\nCondition is 8.5/10.\nPickup Only"),
    Games(title: "FC 24",
          image: UIImage(named: "fc24")!,
          price: "$ 14.99",
          description: "FC 24 (PS5) available for sale.\nCondition is 10/10.\nPickup Only"),
    Games(title: "COD: Mordern Warfare III",
          image: UIImage(named: "mw3")!,
          price: "$ 34.99",
          description: "Mordern Warfare III (PS5) available for sale.\nCondition is 10/10.\nPickup Only")
]
