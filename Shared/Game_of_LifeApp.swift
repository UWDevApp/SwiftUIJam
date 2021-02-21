//
//  Game_of_LifeApp.swift
//  Shared
//
//  Created by Apollo Zhu on 2/19/21.
//  Copyright © 2021 AppDev@UW. All rights reserved.
//

import SwiftUI

@main
struct Game_of_LifeApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(GameStageManager())
    }
  }
}
