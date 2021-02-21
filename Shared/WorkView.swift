//
//  WorkView.swift
//  Game of Life
//
//  Created by Lucas Wang on 2021-02-20.
//  Copyright © 2021 AppDev@UW. All rights reserved.
//

import SwiftUI

struct WorkView: View {
  @State var trollText: String = ""
  @State var trollSliderVal: Double = 0
  @State var trollNumFieldVal: String = ""
  
  @Environment(\.horizontalSizeClass) var hSizeClass
  @Environment(\.verticalSizeClass) var vSizeClass
  
  let letters: String = "abcdefghijklmnopqrstuvwxyz"
  
  func trollWithText() {
    for c in trollText {
      if c != "z" {
        // do something fcked
      }
    }
  }
  
  func trollWithSlider() {
    
  }
  
  
  func trollWithNumPad() {
    trollNumFieldVal = String(Int(trollNumFieldVal) ?? 0 + 69)
    //then do something, perhapes if they get the code right they can proceed?
  }
  
    var body: some View {
      VStack {
        //If we want to do something fancy to this I guess we can???
        Text("Not that kind of programming")
          .font(.title)
        // troll functionc called when editing is done
        TextField(
          "Let's get started here!",
          text: $trollText,
          onEditingChanged: { _ in trollWithText()}
        )
        // troll function called when value changes (or is it when it's done?)
        Slider(value: Binding(get: {
          self.trollSliderVal
        }, set: { (newVal) in
          self.trollSliderVal = newVal
          self.trollWithSlider()
        }))
        
        //  another textfield that only appears in landscape mode so u have to use a fcking numpad in landscape
        if hSizeClass != .compact && vSizeClass != .regular {
          TextField(
            "What's the secret code?",
            text: $trollNumFieldVal,
            onEditingChanged: { _ in trollWithNumPad()}
          )
            .keyboardType(.numberPad)
        }
        
        // do we want more?
      }
    }
}

struct WorkView_Previews: PreviewProvider {
    static var previews: some View {
        WorkView()
    }
}
