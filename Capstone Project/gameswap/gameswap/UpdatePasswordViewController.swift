//
//  UpdatePasswordViewController.swift
//  gameswap
//
//  Created by Balaj Khalid on 4/27/24.
//

import UIKit
import FirebaseAuth

class UpdatePasswordViewController: UIViewController {
    
    @IBOutlet weak var upCurrentPasswordLabel: UITextField!
    
    @IBOutlet weak var upNewPasswordLabel: UITextField!
    
    @IBOutlet weak var upConfirmNewPassword: UITextField!
    
    @IBOutlet weak var upUpdatePasswordBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showEmptyAlert() {
        print("showEmptyAlert() called")
        showAlert(title: "Error", message: "Current Password, New Password and Current New Password field cannot be empty. Please enter your Current Password, New Password and Current New Password.")
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
    
    
    @IBAction func upUpdatePasswordActionBtn(_ sender: Any) {
        guard let currentPassword = upCurrentPasswordLabel.text, !currentPassword.isEmpty,
              let newPassword = upNewPasswordLabel.text, !newPassword.isEmpty,
              let confirmPassword = upConfirmNewPassword.text, !confirmPassword.isEmpty else {
            print("Current Password, New Password and Current New Password not provided")
            self.showEmptyAlert()
            return
                }
        // Check if new password and confirm password match
            guard newPassword == confirmPassword else {
                // Display error message
                showAlert(title: "Error", message: "New password and confirm password do not match.")
                return
            }
        
        // Reauthenticate the user
            let user = Auth.auth().currentUser
            let credential = EmailAuthProvider.credential(withEmail: user?.email ?? "", password: currentPassword)

            user?.reauthenticate(with: credential) { [weak self] authResult, error in
                guard let strongSelf = self else { return }

                if let error = error {
                    // Handle reauthentication error
                    strongSelf.showAlert(title: "Error", message: error.localizedDescription)
                    return
                }

                // Update password
                user?.updatePassword(to: newPassword) { error in
                    if let error = error {
                        // Handle password update error
                        strongSelf.showAlert(title: "Error", message: error.localizedDescription)
                    } else {
                        // Password updated successfully
                        strongSelf.showSuccessAlert(message: "Password updated successfully.")
                        // Optionally, sign out the user or perform other actions
                    }
                }
            }
        
    }
    

}
