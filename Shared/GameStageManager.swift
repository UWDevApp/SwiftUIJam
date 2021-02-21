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

  func advance(from oldStage: GameStage) {
    switch oldStage {
    case .gameOfLife:
      stage = .work
    case .end:
      break
    case .work:
      stage = .end
    case .insta:
      stage = .end
    }
    GameStage.userDefaults.set(stage.rawValue, forKey: GameStage.key)
    GameStage.userDefaults.synchronize()
    WidgetCenter.shared.reloadAllTimelines()
  }
}
