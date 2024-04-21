//
//  InboxTableViewCell.swift
//  gameswap
//
//  Created by Balaj Khalid on 4/20/24.
//

import UIKit

class InboxTableViewCell: UITableViewCell {
    
    @IBOutlet weak var inboxImageView: UIImageView!
    @IBOutlet weak var inboxNameLabel: UILabel!
    @IBOutlet weak var inboxMessageLabel: UILabel!
    
    func setup(with chat: Chat){
        inboxNameLabel.text = chat.name
        inboxImageView.image = chat.image
        inboxMessageLabel.text = chat.lastMessage
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
