//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Balaj Khalid on 3/14/24.
//

import Foundation

extension String {
    func decodeHTML() -> String {
        var decodedString: String = self
        
        if let encodedData = self.data(using: .utf8) {
            let attributedOptions: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]
            
            if let attributedString = try? NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil) {
                decodedString = attributedString.string
            }
        }
        
        return decodedString
    }
}


class TriviaQuestionService {
  static func fetchQuestion(numQuestions: Int,
                            category: String,
                            difficulty: String,
                            completion: (([TriviaQuestion]) -> Void)? = nil) {
      
      let parameters = params(numQuestions: numQuestions, category: category, difficulty: difficulty)
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
    private static func params(numQuestions: Int, category: String, difficulty: String) -> String {
        
        var parameters = "amount=\(numQuestions)"
        
        if category != "default" {
            parameters = parameters + "&category=\(category)"
        }
        if difficulty != "default"{
            parameters = parameters + "&difficulty=\(difficulty)"
        }
        
        return parameters
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
            let type = (element["type"] as! String).decodeHTML()
            // category
            let category = (element["category"] as! String).decodeHTML()
            // question
            let question = (element["question"] as! String).decodeHTML()
            // correctAnswer
            let correctAnswer = (element["correct_answer"] as! String).decodeHTML()
            // incorrectAnswers
            let incorrectAnswersRaw = element["incorrect_answers"] as! [String]
            let incorrectAnswers = incorrectAnswersRaw.map { $0.decodeHTML() }
            
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
