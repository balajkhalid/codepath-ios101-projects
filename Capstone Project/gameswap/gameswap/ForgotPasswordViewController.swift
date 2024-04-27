//
//  ForgotPasswordViewController.swift
//  gameswap
//
//  Created by Balaj Khalid on 4/20/24.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var forgotPasswordEmailLabel: UITextField!
    
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showEmptyAlert() {
        print("showEmptyAlert() called")
        showAlert(title: "Error", message: "Email field cannot be empty. Please enter your email.")
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
    
    @IBAction func forgotPasswordActionBtn(_ sender: Any) {
        guard let email = forgotPasswordEmailLabel.text, !email.isEmpty else {
            print("Email provided")
            self.showEmptyAlert()
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                // Show an error message to the user
                print("Error sending reset password email: \(error.localizedDescription)")
                self.showErrorAlert(message: "Error sending reset password email: \(error.localizedDescription)")
            } else {
                // Inform the user that the reset email was sent
                print("Reset password email sent.")
                self.showSuccessAlert(message: "Reset password email sent.")
            }
        }
    }

}
