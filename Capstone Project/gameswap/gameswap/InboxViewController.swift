//
//  InboxViewController.swift
//  gameswap
//
//  Created by Balaj Khalid on 4/20/24.
//

import UIKit

class InboxViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = inboxTableView.dequeueReusableCell(withIdentifier: "InboxTableViewCell", for: indexPath) as! InboxTableViewCell
        
        cell.setup(with: chatMessages[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    

    @IBOutlet weak var inboxTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        inboxTableView.dataSource = self
        inboxTableView.delegate = self
    }

}
