//
//  SettingsViewController.swift
//  Trivia
//
//  Created by Balaj Khalid on 3/15/24.
//

import UIKit

protocol SettingsViewControllerDelegate: NSObject {
  func didChangeSettings(with settings: [String: Any])
}

class SettingsViewController: UIViewController {
    
    weak var delegate: SettingsViewControllerDelegate?
    var didChangeSettings = false
    
    @IBOutlet weak var numQuestionsStepper: UIStepper!
    @IBOutlet weak var numQuestionsLabel: UILabel!
    
    @IBOutlet weak var category: UIButton!
    
    @IBOutlet weak var difficulty: UIButton!
    
    @IBOutlet weak var backButton: UINavigationItem!
    
    
    @IBAction func numQuestionsStepper(_ sender: Any) {
    }
    
    @IBAction func category(_ sender: Any) {
    }
    
    
    @IBAction func difficulty(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let settingsDictionary = SettingsManager.shared.settingsDictionary
        let numQuestions = settingsDictionary["numQuestions"] as! Int
        numQuestionsStepper.value = Double(numQuestions)
        numQuestionsLabel.text = "\(numQuestions)"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
