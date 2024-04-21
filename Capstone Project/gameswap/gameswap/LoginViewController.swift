//
//  LoginViewController.swift
//  gameswap
//
//  Created by Balaj Khalid on 4/20/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var loginEmailTextField: UITextField!
    
    @IBOutlet weak var loginPasswordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginButtonAction(_ sender: Any) {
        
        if loginEmailTextField.text == "balaj@gameswap.com" && loginPasswordTextField.text == "bkm1998" {
            // write to disk
            
            // post login
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
            
            // This is to get the SceneDelegate object from your view controller
            // then call the change root view controller function to change to main tab bar
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        }
        else{
            print("Incorrect Email or Password")
        }
    }
    
}
