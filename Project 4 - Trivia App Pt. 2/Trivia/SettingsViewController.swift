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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
               
        let settingsDictionary = SettingsManager.shared.settingsDictionary
        
        numQuestionsStepper.minimumValue = 5
        numQuestionsStepper.maximumValue = 50
        
        // Set initial value
        numQuestionsStepper.value = 5
        
        numQuestionsStepper.addTarget(self, action: #selector(numQuestionsStepper(_:)), for: .valueChanged)
                
        // Update label to display initial value
        numQuestionsLabel.text = "\(Int(numQuestionsStepper.value))"
        
        let difficultyMenu = UIMenu(title: "", children: [
                    UIAction(title: "Any", handler: { action in
                        // Handle Option 1
                        SettingsManager.shared.set(difficulty: "default")
                        self.difficulty.setTitle("Any", for: .normal)
                    }),
                    UIAction(title: "Easy", handler: { action in
                        // Handle Option 2
                        SettingsManager.shared.set(difficulty: "easy")
                        self.difficulty.setTitle("Easy", for: .normal)
                    }),
                    UIAction(title: "Medium", handler: { action in
                        // Handle Option 3
                        SettingsManager.shared.set(difficulty: "medium")
                        self.difficulty.setTitle("Medium", for: .normal)
                    }),
                    UIAction(title: "Hard", handler: { action in
                        // Handle Option 3
                        SettingsManager.shared.set(difficulty: "hard")
                        self.difficulty.setTitle("Hard", for: .normal)
                    })
                ])
        
        difficulty.menu = difficultyMenu
        difficulty.showsMenuAsPrimaryAction = true
        self.view.addSubview(difficulty)
        
        let categoryMenu = UIMenu(title: "", children: [
            UIAction(title: "Any", handler: { action in
                // Handle Option 1
                SettingsManager.shared.set(category: "default")
                self.category.setTitle("Any", for: .normal)
            }),
            UIAction(title: "General Knowledge", handler: { action in
                // Handle Option 2
                SettingsManager.shared.set(category: "9")
                self.category.setTitle("General Knowledge", for: .normal)
            }),
            UIAction(title: "Entertainment: Books", handler: { action in
                // Handle Option 3
                SettingsManager.shared.set(category: "10")
                self.category.setTitle("Entertainment: Books", for: .normal)
            }),
            UIAction(title: "Entertainment: Film", handler: { action in
                // Handle Option 4
                SettingsManager.shared.set(category: "11")
                self.category.setTitle("Entertainment: Film", for: .normal)
            }),
            // Add more categories following the same pattern
            UIAction(title: "Entertainment: Music", handler: { action in
                SettingsManager.shared.set(category: "12")
                self.category.setTitle("Entertainment: Music", for: .normal)
            }),
            UIAction(title: "Entertainment: Musicals & Theatres", handler: { action in
                SettingsManager.shared.set(category: "13")
                self.category.setTitle("Entertainment: Musicals & Theatres", for: .normal)
            }),
            UIAction(title: "Entertainment: Television", handler: { action in
                SettingsManager.shared.set(category: "14")
                self.category.setTitle("Entertainment: Television", for: .normal)
            }),
            UIAction(title: "Entertainment: Video Games", handler: { action in
                SettingsManager.shared.set(category: "15")
                self.category.setTitle("Entertainment: Video Games", for: .normal)
            }),
            UIAction(title: "Entertainment: Board Games", handler: { action in
                SettingsManager.shared.set(category: "16")
                self.category.setTitle("Entertainment: Board Games", for: .normal)
            }),
            UIAction(title: "Science & Nature", handler: { action in
                SettingsManager.shared.set(category: "17")
                self.category.setTitle("Science & Nature", for: .normal)
            }),
            UIAction(title: "Science: Computers", handler: { action in
                SettingsManager.shared.set(category: "18")
                self.category.setTitle("Science: Computers", for: .normal)
            }),
            UIAction(title: "Science: Mathematics", handler: { action in
                SettingsManager.shared.set(category: "19")
                self.category.setTitle("Science: Mathematics", for: .normal)
            }),
            UIAction(title: "Mythology", handler: { action in
                SettingsManager.shared.set(category: "20")
                self.category.setTitle("Mythology", for: .normal)
            }),
            UIAction(title: "Sports", handler: { action in
                SettingsManager.shared.set(category: "21")
                self.category.setTitle("Sports", for: .normal)
            }),
            UIAction(title: "Geography", handler: { action in
                SettingsManager.shared.set(category: "22")
                self.category.setTitle("Geography", for: .normal)
            }),
            UIAction(title: "History", handler: { action in
                SettingsManager.shared.set(category: "23")
                self.category.setTitle("History", for: .normal)
            }),
            UIAction(title: "Politics", handler: { action in
                SettingsManager.shared.set(category: "24")
                self.category.setTitle("Politics", for: .normal)
            }),
            UIAction(title: "Art", handler: { action in
                SettingsManager.shared.set(category: "25")
                self.category.setTitle("Art", for: .normal)
            }),
            UIAction(title: "Celebrities", handler: { action in
                SettingsManager.shared.set(category: "26")
                self.category.setTitle("Celebrities", for: .normal)
            }),
            UIAction(title: "Animals", handler: { action in
                SettingsManager.shared.set(category: "27")
                self.category.setTitle("Animals", for: .normal)
            }),
            UIAction(title: "Vehicles", handler: { action in
                SettingsManager.shared.set(category: "28")
                self.category.setTitle("Vehicles", for: .normal)
            }),
            UIAction(title: "Entertainment: Comics", handler: { action in
                SettingsManager.shared.set(category: "29")
                self.category.setTitle("Entertainment: Comics", for: .normal)
            }),
            UIAction(title: "Science: Gadgets", handler: { action in
                SettingsManager.shared.set(category: "30")
                self.category.setTitle("Science: Gadgets", for: .normal)
            }),
            UIAction(title: "Entertainment: Japanese Anime & Manga", handler: { action in
                SettingsManager.shared.set(category: "31")
                self.category.setTitle("Entertainment: Japanese Anime & Manga", for: .normal)
            }),
            UIAction(title: "Entertainment: Cartoon & Animations", handler: { action in
                SettingsManager.shared.set(category: "32")
                self.category.setTitle("Entertainment: Cartoon & Animations", for: .normal)
            })
        ])

        category.menu = categoryMenu
        category.showsMenuAsPrimaryAction = true
        self.view.addSubview(category)
    }
    
    @objc func numQuestionsStepper(_ sender: UIStepper) {
            // Update label to display current value of the stepper
        numQuestionsLabel.text = "\(Int(sender.value))"
        SettingsManager.shared.set(numQuestions: Int(sender.value))
        didChangeSettings = true
        }
    
    @IBAction func categoryBtnAction(_ sender: Any) {
        didChangeSettings = true
    }
    
    
    @IBAction func difficultyBtnAction(_ sender: Any) {
        didChangeSettings = true
    }
    
    @objc private func didTapBackButton() {
      if didChangeSettings {
        delegate?.didChangeSettings(with: SettingsManager.shared.settingsDictionary)
      }
      navigationController?.popViewController(animated: true)
    }
    
}
