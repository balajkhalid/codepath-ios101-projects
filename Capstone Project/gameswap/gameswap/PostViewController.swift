//
//  PostViewController.swift
//  gameswap
//
//  Created by Balaj Khalid on 4/20/24.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage

class PostViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var postTitleLabel: UITextField!
    
    @IBOutlet weak var postDescriptionLabel: UITextView!
    
    @IBOutlet weak var postPriceLabel: UITextField!
    
    @IBOutlet weak var postBtn: UIButton!
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var postUploadBtn: UIButton!
    
    var uploadedImageURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func showEmptyAlert() {
        print("showEmptyAlert() called")
        showAlert(title: "Error", message: "Title, Description, Price fields or Photo cannot be empty. Please enter video game's title, description, price and a photo.")
    }
    
    func showErrorAlert(message: String) {
        showAlert(title: "Error", message: message)
    }
    
    func showSuccessAlert(message: String) {
        showAlert(title: "Success", message: message)
        postTitleLabel.text = ""
        postDescriptionLabel.text = ""
        postPriceLabel.text = ""
        postImageView.image = UIImage(systemName: "photo.artframe")
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    @IBAction func postActionBtn(_ sender: Any) {
        
        guard let title = postTitleLabel.text, !title.isEmpty,
              let description = postDescriptionLabel.text, !description.isEmpty,
              let price = postPriceLabel.text, !price.isEmpty,
              let imageURL = uploadedImageURL, !imageURL.isEmpty else {
            print("Title, Description, Price, Photo is Empty")
            self.showEmptyAlert()
            return
        }
        
        let db = Firestore.firestore()
        let gamesRef = db.collection("games")
        
        let gameData: [String: Any] = [
            "title": title,
            "imageURL": imageURL,
            "price": price,
            "description": description
        ]
        
        gamesRef.addDocument(data: gameData) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                    self.showErrorAlert(message: "Post upload error. Please try again later!")
                } else {
                    self.showSuccessAlert(message: "Game has been posted successfully!")
                }
            }
    }
    
    @IBAction func postUploadActionBtn(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            postImageView.image = selectedImage
            // Handle the selected image, e.g., upload it to a server
            uploadImageToFirebaseStorage(image: selectedImage)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func uploadImageToFirebaseStorage(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            print("Failed to convert image to data.")
            return
        }
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imagesRef = storageRef.child("images/\(UUID().uuidString).jpg")
        
        let uploadTask = imagesRef.putData(imageData, metadata: nil) { (metadata, error) in
            guard let _ = metadata else {
                print("Error uploading image: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            imagesRef.downloadURL { (url, error) in
                if let downloadURL = url {
                    print("Image uploaded to Firebase Storage. URL: \(downloadURL)")
                    // Here you can use the downloadURL or perform further actions
                    self.uploadedImageURL = downloadURL.absoluteString
                } else {
                    print("Error getting download URL: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }
        
        uploadTask.observe(.progress) { snapshot in
            // Handle progress if needed
        }
        
        uploadTask.observe(.success) { snapshot in
            // Handle successful upload if needed
        }
        
        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error as NSError? {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
