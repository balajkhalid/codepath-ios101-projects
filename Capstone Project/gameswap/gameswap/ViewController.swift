//
//  ViewController.swift
//  gameswap
//
//  Created by Balaj Khalid on 4/15/24.
//

import UIKit

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165, height: 295)
    }
}

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(gamesCollection[indexPath.row].title)
    }
}

class ViewController: UIViewController, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gamesCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCollectionViewCell", for: indexPath) as! GameCollectionViewCell
        
        cell.setup(with: gamesCollection[indexPath.row])
        
        return cell
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first else { return }

        let selectedGame = gamesCollection[selectedIndexPath.row]

        guard let detailViewController = segue.destination as? GameDetailViewController else { return }

        detailViewController.game = selectedGame
    }
}

