//
//  GameStage.swift
//  Game of Life
//
//  Created by Xinyi Xiang on 2/21/21.
//  Copyright © 2021 AppDev@UW. All rights reserved.
//

import Foundation

enum GameStage: Int {
  case gameOfLife, end
}

extension GameStage {
  static let key = "levelData"
  
  static let userDefaults = UserDefaults(suiteName: "app.uwdev.Game-of-Life")!

  static var current: GameStage {
    GameStage(rawValue: GameStage.userDefaults.integer(forKey: key))!
  }
}
