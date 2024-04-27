//
//  LoginViewController.swift
//  gameswap
//
//  Created by Balaj Khalid on 4/20/24.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var loginEmailTextField: UITextField!
    
    @IBOutlet weak var loginPasswordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func showEmptyAlert() {
        print("showEmptyAlert() called")
        showAlert(title: "Error", message: "Email or Password field cannot be empty. Please enter your email and password.")
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
    
    
    @IBAction func loginButtonAction(_ sender: Any) {
        
        guard let email = loginEmailTextField.text, !email.isEmpty,
              let pass = loginPasswordTextField.text, !pass.isEmpty else {
            print("Email or Password not provided")
            self.showEmptyAlert()
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: pass) { authResult, error in
            if let error =  error {
                print("Incorrect Email or Password")
                self.showErrorAlert(message: "Incorrect Email or Password")
            } else {
                // write to disk
                let defaults = UserDefaults.standard
                guard let uid = authResult?.user.uid else { return }
                defaults.set(uid, forKey: "uid")
                print("User Login Successfully!")
                // post login
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                
                // This is to get the SceneDelegate object from your view controller
                // then call the change root view controller function to change to main tab bar
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
            }
        }
    }

}
