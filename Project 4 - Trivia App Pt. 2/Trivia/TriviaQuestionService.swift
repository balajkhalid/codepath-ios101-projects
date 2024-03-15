//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Balaj Khalid on 3/14/24.
//

import Foundation

class TriviaQuestionService {
  static func fetchQuestion(noOfQuestions: Int,
//                            category: Int,
//                            Difficulty: String,
                            completion: (([TriviaQuestion]) -> Void)? = nil) {
      let parameters = "amount=\(noOfQuestions)"
      let url = URL(string: "https://opentdb.com/api.php?\(parameters)")!
      // create a data task and pass in the URL
          let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // this closure is fired when the response is received
            guard error == nil else {
              assertionFailure("Error: \(error!.localizedDescription)")
              return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
              assertionFailure("Invalid response")
              return
            }
            guard let data = data, httpResponse.statusCode == 200 else {
              assertionFailure("Invalid response status code: \(httpResponse.statusCode)")
              return
            }
            // at this point, `data` contains the data received from the response
              let question = parse(data: data)
              // this response will be used to change the UI, so it must happen on the main thread
                    DispatchQueue.main.async {
                      completion?(question) // call the completion closure and pass in the question data model
                    }
          }
          task.resume() // resume the task and fire the request
  }
    private static func parse(data: Data) -> [TriviaQuestion] {
        // transform the data we received into a dictionary [String: Any]
        let jsonDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//        print(jsonDictionary)
        let results = jsonDictionary["results"] as! [NSDictionary]
        print(results)
        var triviaQuestions = [TriviaQuestion]()
        results.forEach {element in
            // type
            let type = element["type"] as! String
            // category
            let category = element["category"] as! String
            // question
            let question = element["question"] as! String
            // correctAnswer
            let correctAnswer = element["correct_answer"] as! String
            // incorrectAnswers
            let incorrectAnswers = element["incorrect_answers"] as! [String]
            
            triviaQuestions.append(TriviaQuestion(type: type,
                                                  category: category,
                                                  question: question,
                                                  correctAnswer: correctAnswer,
                                                  incorrectAnswers: incorrectAnswers))
        }
//        print(triviaQuestions)
        return triviaQuestions
      }
}
