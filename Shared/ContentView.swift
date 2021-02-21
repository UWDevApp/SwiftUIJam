//
//  ContentView.swift
//  Shared
//
//  Created by Apollo Zhu on 2/19/21.
//  Copyright © 2021 AppDev@UW. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var stageManager: GameStageManager

  var body: some View {
    Group {
      switch stageManager.stage {
      case .gameOfLife:
        GameOfLifeView()
      case .end:
        EndOfGameView()
          .transition(.move(edge: .bottom))
      case .work:
        WorkView()
          .transition(.slide)
      case .insta:
        InstaView()
          .transition(.scale)
      }
    }
    .animation(.spring())
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

extension View {
  func centered() -> some View {
    VStack {
      Spacer()
      HStack {
        Spacer()
        self
        Spacer()
      }
      Spacer()
    }
  }
}
