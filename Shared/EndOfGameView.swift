//
//  EndOfGameView.swift
//  Game of Life
//
//  Created by Apollo Zhu on 2/20/21.
//  Copyright © 2021 AppDev@UW. All rights reserved.
//

import SwiftUI

/// Never gonna give you up
let finalURL = URL(string: "https://www.youtube.com/watch?v=2ocykBzWDiM")!


/// The end is just a start of a new journey
struct EndOfGameView: View {
  @Environment(\.openURL) var openURL

  var body: some View {
    ZStack {
      LinearGradient(
        gradient: Gradient(colors: [
          Color(red: 3 / 255, green: 3 / 255, blue: 3 / 255),
          Color(red: 114 / 255, green: 114 / 255, blue: 131 / 255),
        ]),
        startPoint: .top, endPoint: .bottom
      )

      Label("One more thing...", systemImage: "link")
        .font(Font.largeTitle.weight(.bold))
        .foregroundColor(.white)
    }
    .edgesIgnoringSafeArea(.all)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .help("But wait, there is one last thing")
    .onTapGesture {
      openURL(finalURL)
    }
  }
}

struct EndOfGameView_Previews: PreviewProvider {
  static var previews: some View {
    EndOfGameView()
  }
}
