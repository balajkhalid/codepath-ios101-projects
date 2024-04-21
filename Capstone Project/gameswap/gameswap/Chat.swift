//
//  Chat.swift
//  gameswap
//
//  Created by Balaj Khalid on 4/20/24.
//

import Foundation
import UIKit

struct Chat{
    let name: String
    let image: UIImage
    let lastMessage: String
}

let chatMessages: [Chat] = [
    Chat(name: "Juan", image: UIImage(named: "avatar-1")!, lastMessage: "Is this available?"),
    Chat(name: "John", image: UIImage(named: "avatar-4")!, lastMessage: "Is RDR2 available?")
]
