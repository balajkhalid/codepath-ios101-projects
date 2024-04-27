//
//  SignUpViewController.swift
//  gameswap
//
//  Created by Balaj Khalid on 4/20/24.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var signUpEmailLabel: UITextField!
    
    @IBOutlet weak var signUpPasswordLabel: UITextField!
    
    @IBOutlet weak var signUpConfirmPasswordLabel: UITextField!
    
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var signUpLoginBtn: UIButton!
    
    @IBOutlet weak var signUpNameLabel: UITextField!
    
    @IBOutlet weak var signUpPhoneLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    @IBAction func signUpBtnAction(_ sender: Any) {
        guard let name = signUpNameLabel.text, !name.isEmpty,
              let email = signUpEmailLabel.text, !email.isEmpty,
              let pass = signUpPasswordLabel.text, !pass.isEmpty,
              let confirmPass = signUpConfirmPasswordLabel.text, !confirmPass.isEmpty,
              let phone = signUpPhoneLabel.text, !phone.isEmpty else {
            print("Name, Email, Password, Confirm Password or Phone not provided")
            self.showEmptyAlert()
            return
        }
        
        if pass == confirmPass {
            
            Auth.auth().createUser(withEmail: email, password: pass) { authResult, error in
                if let error = error {
                    self.showErrorAlert(message: "Error with creating an account.")
                } else {
                    // write to disk
                    let defaults = UserDefaults.standard
                    
                    
                    print("User Signed Up Successfully")
                    
                    guard let uid = authResult?.user.uid else { return }
                    defaults.set(uid, forKey: "uid")
                    self.createUserProfile(uid: uid, name: name, email: email, phone: phone)
//                    self.showSuccessAlert(message: "Account was created successfully!")
                    // post login
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                    
                    // This is to get the SceneDelegate object from your view controller
                    // then call the change root view controller function to change to main tab bar
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
                }
            }
        } else{
            print("Passwords do not match!")
            self.showErrorAlert(message: "Password and Confirm Password do not match!")
        }
    }
    
    func createUserProfile(uid: String, name: String, email: String, phone: String) {
        
        let db = Firestore.firestore()
        
        let userData: [String: Any] = [
            "email": email,
            "name": name,
            "phone": phone,
            "imageURL": "",
        ]
        
        db.collection("users").document(uid).setData(userData){ error in
            if let error = error {
                print("Error saving user profile: \(error.localizedDescription)")
            } else {
                print("User profile created")
            }
        }
    }
    
    @IBAction func signUpLoginActionBtn(_ sender: Any) {
        // Transition to LoginNavigationController
        if let loginNavigationController = storyboard?.instantiateViewController(withIdentifier: "LoginNavigationController") as? UINavigationController {
            UIApplication.shared.windows.first?.rootViewController = loginNavigationController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
}
