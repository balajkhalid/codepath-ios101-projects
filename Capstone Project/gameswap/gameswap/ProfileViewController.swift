//
//  ProfileViewController.swift
//  gameswap
//
//  Created by Balaj Khalid on 4/20/24.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var profileNameLabel: UITextField!
    
    @IBOutlet weak var profileEmailLabel: UITextField!
    
    @IBOutlet weak var profilePhoneLabel: UITextField!
    
    @IBOutlet weak var profileUpdateBtn: UIButton!
    
    @IBOutlet weak var profileSignOutBtn: UIButton!
    
    @IBOutlet weak var profileEditBtn: UIButton!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getData()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
    }
    
    func showEmptyAlert() {
        print("showEmptyAlert() called")
        showAlert(title: "Error", message: "Name, Email, Password, Confirm field or Phone cannot be empty. Please enter your name, email, password, confirm password and phone.")
    }

    func showErrorAlert(message: String) {
        showAlert(title: "Error", message: message)
    }

    func showSuccessAlert(message: String) {
        showAlert(title: "Success", message: message)
    }

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
        }
    
    func getData(){
        if let uid = UserDefaults.standard.string(forKey: "uid"){
            
            let db = Firestore.firestore()
            let usersCollection = db.collection("users")

            // Query the users collection for the document with the user's UID
            usersCollection.document(uid).getDocument { (snapshot, error) in
                if let error = error {
                    print("Error getting user document: \(error.localizedDescription)")
                    return
                }

                guard let data = snapshot?.data() else {
                    print("User document does not exist")
                    return
                }

                // Extract fields from the data
                if let profileName = data["name"] as? String {
                    DispatchQueue.main.async {
                        self.profileNameLabel.text = profileName
                    }
                } else {
                    print("Name field not found in user document")
                }

                if let profileEmail = data["email"] as? String {
                    DispatchQueue.main.async {
                        self.profileEmailLabel.text = profileEmail
                    }
                } else {
                    print("Email field not found in user document")
                }

                if let profilePhone = data["phone"] as? String {
                    DispatchQueue.main.async {
                        self.profilePhoneLabel.text = profilePhone
                    }
                } else {
                    print("Phone field not found in user document")
                }
                
                if let profileImageURL = data["imageURL"] as? String {
                    DispatchQueue.main.async {
                        if profileImageURL == "" {
                            self.profileImageView.image = UIImage(systemName: "person.circle.fill")
                        } else{
                            self.loadImage(from: profileImageURL)
                        }
                    }
                } else {
                    print("Image URL not found in user document")
                }
            }
        } else {
            print("Get profile failed.")
        }
    }
    
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.profileImageView.image = image
                }
            }
        }.resume()
    }
    
    @IBAction func profileUpdateActionBtn(_ sender: Any) {
        guard let newName = profileNameLabel.text,
              let newPhone = profilePhoneLabel.text else {
            return
        }
        
        let db = Firestore.firestore()
        if let uid = UserDefaults.standard.string(forKey: "uid"){
            // Update the document in Firestore
            let userData: [String: Any] = [
                "name": newName,
                "phone": newPhone
            ]
            
            db.collection("users").document(uid).updateData(userData){ error in
                if let error = error {
                    print("Error saving user profile: \(error.localizedDescription)")
                    self.showErrorAlert(message: "Error saving user profile.")
                } else {
                    print("User profile updated.")
                    self.showSuccessAlert(message: "User profile updated.")
                }
            }
        } else {
            print("Cannot update user profile.")
        }
    }
    
    @IBAction func profileSignOutActionBtn(_ sender: Any) {
        // Get a reference to UserDefaults
        let defaults = UserDefaults.standard

        // Remove the value for the "username" key
        defaults.removeObject(forKey: "uid")
        
        // Transition to LoginNavigationController
        if let loginNavigationController = storyboard?.instantiateViewController(withIdentifier: "LoginNavigationController") as? UINavigationController {
            UIApplication.shared.windows.first?.rootViewController = loginNavigationController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
    
    
    @IBAction func profileEditActionBtn(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            profileImageView.image = selectedImage
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
        let imagesRef = storageRef.child("user-images/\(UUID().uuidString).jpg")
        
        let uploadTask = imagesRef.putData(imageData, metadata: nil) { (metadata, error) in
            guard let _ = metadata else {
                print("Error uploading image: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            imagesRef.downloadURL { (url, error) in
                if let downloadURL = url {
                    print("Image uploaded to Firebase Storage. URL: \(downloadURL)")
                    // Here you can use the downloadURL or perform further actions
                    let db = Firestore.firestore()
                    if let uid = UserDefaults.standard.string(forKey: "uid"){
                        // Update the document in Firestore
                        let userData: [String: Any] = [
                            "imageURL": downloadURL.absoluteString
                        ]
                        
                        db.collection("users").document(uid).updateData(userData){ error in
                            if let error = error {
                                print("Error saving user profile: \(error.localizedDescription)")
                                self.showErrorAlert(message: "Error saving user profile.")
                            } else {
                                print("User profile updated.")
                                self.showSuccessAlert(message: "User profile updated.")
                            }
                        }
                    } else {
                        print("Cannot update user profile.")
                    }
                    
                } else {
                    print("Error getting download URL: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }

    }
    
}
