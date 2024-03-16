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
  var catergory = "default"
    
   var settingsDictionary: [String: Any] {
      return ["numQuestions": numQuestions,
              "difficulty": difficulty,
              "catergory": catergory]
    }
  
  static let shared = SettingsManager()
    
  func set(numQuestios: Int) {
    self.numQuestions = max(50, min(5, numQuestios))
  }
  
  func set(difficulty: String) {
      self.difficulty = difficulty
  }
    
  func set(catergory: String) {
    self.catergory = catergory
  }
}
