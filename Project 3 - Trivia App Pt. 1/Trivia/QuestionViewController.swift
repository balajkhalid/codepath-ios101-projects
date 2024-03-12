//
//  QuestionViewController.swift
//  Trivia
//
//  Created by Balaj Khalid on 3/11/24.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionNo: UILabel!
    
    @IBOutlet weak var questionType: UILabel!
    
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var ans1: UIButton!
    @IBOutlet weak var ans2: UIButton!
    @IBOutlet weak var ans3: UIButton!
    @IBOutlet weak var ans4: UIButton!
    
    
    @IBAction func answerSelected(_ sender: UIButton) {
        
        guard let answer = sender.titleLabel?.text else { return }

        let correctAnswer = questions[currentQuestionIndex].correctAnswer
        if answer == correctAnswer {
            score += 1
        }
        
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            updateUI()
        } else {
            // Show a completion message and score, then reset the quiz
            let alert = UIAlertController(title: "Quiz Finished", message: "Your score is \(score) out of \(questions.count).", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { _ in
                self.restartQuiz()
            }))
            present(alert, animated: true)
        }
    }

    func restartQuiz() {
        score = 0
        currentQuestionIndex = 0
        updateUI()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    var questions: [Question] = [
        Question(questionType: "Mathematics", questionText: "What is 2+2?", answers: ["3", "4", "5", "6"], correctAnswer: "4"),
        Question(questionType: "Geography", questionText: "What is the capital of France?", answers: ["London", "Berlin", "Paris", "Rome"], correctAnswer: "Paris"),
        Question(questionType: "General Knowledge", questionText: "Which is NOT a primary color?", answers: ["Red", "Green", "Blue", "Yellow"], correctAnswer: "Green")
    ]
    var currentQuestionIndex: Int = 0
    var score: Int = 0
    
    func updateUI(){
        let currentQuestion = questions[currentQuestionIndex]
        questionNo.text = "Question \(currentQuestionIndex + 1) of \(questions.count)"
        questionType.text = currentQuestion.questionType
        questionText.text = currentQuestion.questionText
        ans1.setTitle(currentQuestion.answers[0], for: .normal)
        ans2.setTitle(currentQuestion.answers[1], for: .normal)
        ans3.setTitle(currentQuestion.answers[2], for: .normal)
        ans4.setTitle(currentQuestion.answers[3], for: .normal)
    }

    
    
}
