//
//  EndOfGame.swift
//  Game of Life
//
//  Created by Apollo Zhu on 2/20/21.
//  Copyright © 2021 AppDev@UW. All rights reserved.
//

import SwiftUI

let finalURL = URL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ")!


/// The end is just a start of a new journey
struct EndOfGame: View {
    var body: some View {
      Link("One More Thing", destination: finalURL)
    }
}

struct EndOfGame_Previews: PreviewProvider {
    static var previews: some View {
        EndOfGame()
    }
}
