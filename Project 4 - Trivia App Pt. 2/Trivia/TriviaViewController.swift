//
//  ViewController.swift
//  Trivia
//
//  Created by Mari Batilando on 4/6/23.
//

import UIKit

class TriviaViewController: UIViewController, SettingsViewControllerDelegate {
    
  
  @IBOutlet weak var currentQuestionNumberLabel: UILabel!
  @IBOutlet weak var questionContainerView: UIView!
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var answerButton0: UIButton!
  @IBOutlet weak var answerButton1: UIButton!
  @IBOutlet weak var answerButton2: UIButton!
  @IBOutlet weak var answerButton3: UIButton!
    
  @IBOutlet weak var settingsGear: UIImageView!
  
  private var questions = [TriviaQuestion]()
  private var currQuestionIndex = 0
  private var numCorrectQuestions = 0
  private var settings = SettingsManager()
    
  override func viewDidLoad() {
    super.viewDidLoad()
    addGradient()
    questionContainerView.layer.cornerRadius = 8.0
      TriviaQuestionService.fetchQuestion(numQuestions: settings.numQuestions,
                                          category: settings.category,
                                          difficulty: settings.difficulty) {question in
          self.questions = question
          self.updateQuestion(withQuestionIndex: 0)
          
          // category and difficulty
      }
      
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageClicked))
    settingsGear.addGestureRecognizer(tapGesture)
    settingsGear.isUserInteractionEnabled = true
      
  }
    
    @objc func imageClicked() {
        transitionToSettingsViewController()
    }
    
    func didChangeSettings(with settings: [String : Any]) {
//        print(settings)
        TriviaQuestionService.fetchQuestion(numQuestions: settings["numQuestions"] as! Int,
                                            category: settings["category"] as! String,
                                            difficulty: settings["difficulty"] as! String){question in
            self.questions = question
            self.currQuestionIndex = 0
            self.numCorrectQuestions = 0
            self.updateQuestion(withQuestionIndex: 0)
            
            // category and difficulty
        }
    }
        
        // Function to transition to secondViewController
    func transitionToSettingsViewController() {
        guard let secondVC = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else {
                    return
                }
        secondVC.delegate = self
        navigationController?.pushViewController(secondVC, animated: true)
    }

  
  private func updateQuestion(withQuestionIndex questionIndex: Int) {
    currentQuestionNumberLabel.text = "Question: \(questionIndex + 1)/\(questions.count)"
    let question = questions[questionIndex]
    questionLabel.text = question.question
    categoryLabel.text = question.category
    let answers = ([question.correctAnswer] + question.incorrectAnswers).shuffled()
    if answers.count > 0 {
      answerButton0.setTitle(answers[0], for: .normal)
    }
    if answers.count > 1 {
      answerButton1.setTitle(answers[1], for: .normal)
      answerButton1.isHidden = false
    }
    if question.type == "multiple" {
        if answers.count > 2 {
          answerButton2.setTitle(answers[2], for: .normal)
          answerButton2.isHidden = false
        }
        if answers.count > 3 {
          answerButton3.setTitle(answers[3], for: .normal)
          answerButton3.isHidden = false
        }
    } else {
        answerButton2.isHidden = true
        answerButton3.isHidden = true
    }
    
  }
  
  private func updateToNextQuestion(answer: String) {
    var correctAns = false
    if isCorrectAnswer(answer) {
      numCorrectQuestions += 1
      correctAns = true
    }
    currQuestionIndex += 1
    guard currQuestionIndex < questions.count else {
      showFinalScore()
      return
    }
    questionScoreUpdate(correctAns)
//    updateQuestion(withQuestionIndex: currQuestionIndex)
  }
    
  private func questionScoreUpdate(_ correctAns : Bool){
      var stringToDisplay: String
      if (correctAns) {
          stringToDisplay = "Your answer was correct!"
      } else {
          stringToDisplay = "Your answer was incorrect!"
      }
      let alertController = UIAlertController(title: stringToDisplay,
                                              message: "",
                                              preferredStyle: .alert)
      let nextQuestionAction = UIAlertAction(title: "Next Question", style: .default) { [unowned self] _ in
        updateQuestion(withQuestionIndex: currQuestionIndex)
      }
      alertController.addAction(nextQuestionAction)
      present(alertController, animated: true, completion: nil)
  }
  
  private func isCorrectAnswer(_ answer: String) -> Bool {
    return answer == questions[currQuestionIndex].correctAnswer
  }
  
  private func showFinalScore() {
    let alertController = UIAlertController(title: "Game over!",
                                            message: "Final score: \(numCorrectQuestions)/\(questions.count)",
                                            preferredStyle: .alert)
    let resetAction = UIAlertAction(title: "Restart", style: .default) { [unowned self] _ in
      currQuestionIndex = 0
      numCorrectQuestions = 0
      TriviaQuestionService.fetchQuestion(numQuestions: settings.numQuestions,
                                          category: settings.category,
                                          difficulty: settings.difficulty) {question in
        self.questions = question
      }
      updateQuestion(withQuestionIndex: currQuestionIndex)
    }
    alertController.addAction(resetAction)
    present(alertController, animated: true, completion: nil)
  }
  
  private func addGradient() {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = view.bounds
    gradientLayer.colors = [UIColor(red: 0.54, green: 0.88, blue: 0.99, alpha: 1.00).cgColor,
                            UIColor(red: 0.51, green: 0.81, blue: 0.97, alpha: 1.00).cgColor]
    gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
    gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
    view.layer.insertSublayer(gradientLayer, at: 0)
  }
  
  @IBAction func didTapAnswerButton0(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton1(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton2(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton3(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
    
}

