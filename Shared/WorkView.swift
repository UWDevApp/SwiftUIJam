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
  @State var trollNumFieldVal: String = "69"
  
  @Environment(\.horizontalSizeClass) var hSizeClass
  @Environment(\.verticalSizeClass) var vSizeClass
  
  let letters: String = "abcdefghijklmnopqrstuvwxyz"
  
  func trollWithText() {
    trollText = trollText.map { char in
      switch char {
      case "X": return "x"
      case "x": return "X"
      case "C": return "c"
      case "c": return "C"
      default: return "\(char)"
      }
    }.joined()
  }

  func trollWithNumPad() {
    trollNumFieldVal = String((Int(trollNumFieldVal) ?? 69) + Int.random(in: 1...4))
  }

  func trollWithSlider() {
    self.trollSliderVal = 100 - trollSliderVal
    UIScreen.main.brightness = CGFloat(self.trollSliderVal / 100)
  }
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
        //If we want to do something fancy to this I guess we can???
        Text("Not that kind of programming")
          .font(.title)

        Text("You're assigned 3 tasks for today's work")
          .font(.headline)
          .padding(.bottom)

        // troll functionc called when editing is done

        Text("What's the IDE for editing Swift & SwiftUI")
        HStack {
          TextField(
            "It starts with an X and ends with a o",
            text: $trollText,
            onEditingChanged: { _ in trollWithText() }
          )

          Image(systemName: trollText == "Xcode" ? "checkmark.seal" : "xmark.octagon")
        }
        .foregroundColor(trollText == "Xcode" ? .green : .red)


        Text("We want brightness level at 69%")
        // A trolling slider that does exactly opposite thing
        HStack {
          Slider(value: Binding(get: {
            self.trollSliderVal
          }, set: { (newVal) in
            self.trollSliderVal = newVal
            trollWithSlider()
          }), in: 0...100, step: 0.5, onEditingChanged: { _ in
            trollWithSlider()
          })
          .accentColor(trollSliderVal == 69 ? .green : .red)

          Image(systemName: trollSliderVal == 69 ? "checkmark.seal" : "xmark.octagon")
            .foregroundColor(trollSliderVal == 69 ? .green : .red)
        }

        //  another textfield that only appears in landscape mode so u have to use a fcking numpad in landscape

        if vSizeClass != .regular
            || (vSizeClass == .regular && hSizeClass == .regular) /*iPad*/ {
          HStack {
            Text("What's the secret sauce?")
            Group {
              TextField(
                "The answer to life, the universe, and everything",
                text: $trollNumFieldVal,
                onEditingChanged: { _ in trollWithNumPad() },
                onCommit: { trollWithNumPad() }
              )
              .keyboardType(.numberPad)

              Image(systemName: trollNumFieldVal == "42" ? "checkmark.seal" : "xmark.octagon")
            }
            .foregroundColor(trollNumFieldVal == "42" ? .green : .red)
          }
        }

        HStack {
          Spacer()
          // do we want more?
          if trollNumFieldVal == "42" && trollText == "Xocde" && trollSliderVal == 69 {
            Button("Next", action: {
              // TODO
            })
          }
        }
        Spacer()
      }
      .padding()
    }
  }
}

struct WorkView_Previews: PreviewProvider {
  static var previews: some View {
    WorkView()
  }
}
