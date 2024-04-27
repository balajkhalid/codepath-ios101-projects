//
//  ViewController.swift
//  gameswap
//
//  Created by Balaj Khalid on 4/15/24.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165, height: 295)
    }
}

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(gamesArray[indexPath.row].title)
    }
}

class ViewController: UIViewController, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gamesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCollectionViewCell", for: indexPath) as! GameCollectionViewCell
        
        cell.setup(with: gamesArray[indexPath.item])
        
        return cell
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var gamesArray: [Games] = []
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        self.fetchGamesFromFirestore()
        
        refreshControl.tintColor = .gray
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to Refresh")
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
    }
    
    @objc func refreshData(_ sender: Any) {
        gamesArray = []
        self.fetchGamesFromFirestore()
        // After refreshing is complete, end the refreshing animation
        refreshControl.endRefreshing()
    }


    
    func fetchGamesFromFirestore() {
        print("Fetching games...")
        let db = Firestore.firestore()
        let gamesRef = db.collection("games")

        gamesRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                // Handle error condition here
            } else {
                print("Working...")
                for document in querySnapshot!.documents {
                    let data = document.data()
                    if let title = data["title"] as? String,
                       let imageURLString = data["imageURL"] as? String,
                       let price = data["price"] as? String,
                       let description = data["description"] as? String,
                       let imageURL = URL(string: imageURLString) {
                        
                        // Fetch image from Firebase Storage
                        let storageRef = Storage.storage().reference(forURL: imageURLString)
                        storageRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
                            if let error = error {
                                print("Error downloading image: \(error.localizedDescription)")
                            } else if let imageData = data,
                                      let image = UIImage(data: imageData) {
                                
                                let game = Games(title: title, image: image, price: price, description: description)
                                self.gamesArray.append(game)
                                
                                // Update UI or perform other operations here, inside the closure
                                DispatchQueue.main.async {
                                    // Print titles after populating the array
                                    for game in self.gamesArray {
                                        print(game.title)
                                    }
                                    self.collectionView.reloadData()
                                    // Update UI elements or call other functions here
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first else { return }

        let selectedGame = gamesArray[selectedIndexPath.row]

        guard let detailViewController = segue.destination as? GameDetailViewController else { return }

        detailViewController.game = selectedGame
    }
}

