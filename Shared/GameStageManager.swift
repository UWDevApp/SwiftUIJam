//
//  GameStageManager.swift
//  Game of Life
//
//  Created by Apollo Zhu on 2/20/21.
//  Copyright © 2021 AppDev@UW. All rights reserved.
//

import Foundation
import SwiftUI
import WidgetKit


class GameStageManager: ObservableObject {
  @Published var stage: GameStage = .gameOfLife

  func advance(from stage: GameStage) {
    switch stage {
    case .gameOfLife:
      self.stage = .end
    case .end:
      break
    }
    // let userDefaults = UserDefaults(suiteName: "group.com.YourCompany.YourApp")
    UserDefaults(suiteName:"group.sharedLevel")!.set(stage.rawValue, forKey: "levelData")
    WidgetCenter.shared.reloadAllTimelines()
  }
}
