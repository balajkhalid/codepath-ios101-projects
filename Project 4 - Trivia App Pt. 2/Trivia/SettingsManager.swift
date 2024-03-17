//
//  SettingsManager.swift
//  Trivia
//
//  Created by Balaj Khalid on 3/15/24.
//

import Foundation

class SettingsManager {

  var numQuestions = 5
  var difficulty = "default"
  var category = "default"
    
   var settingsDictionary: [String: Any] {
      return ["numQuestions": numQuestions,
              "difficulty": difficulty,
              "category": category]
    }
  
  static let shared = SettingsManager()
    
  func set(numQuestions: Int) {
    self.numQuestions = numQuestions
  }
  
  func set(difficulty: String) {
      self.difficulty = difficulty
  }
    
  func set(category: String) {
    self.category = category
  }
}
