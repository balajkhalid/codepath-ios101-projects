//
//  TriviaQuestion.swift
//  Trivia
//
//  Created by Mari Batilando on 4/6/23.
//

import Foundation

struct TriviaAPIResponse: Decodable {
  let results: TriviaQuestion

  private enum CodingKeys: String, CodingKey {
    case results = "results"
  }
}

struct TriviaQuestion: Decodable {
  let type: String
  let category: String
  let question: String
  let correctAnswer: String
  let incorrectAnswers: [String]
    
    private enum CodingKeys: String, CodingKey {
    case type = "type"
    case category = "category"
    case question = "question"
    case correctAnswer = "correctAnswer"
    case incorrectAnswers = "incorrectAnswers"
  }
}
