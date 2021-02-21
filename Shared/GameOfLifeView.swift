//
//  GameOfLifeView.swift
//  Game of Life
//
//  Created by Apollo Zhu on 2/20/21.
//  Copyright © 2021 AppDev@UW. All rights reserved.
//

import SwiftUI

/// Some view that kind of looks
struct GameOfLifeView: View {
  /// Available highlight colors for enabled cells
  static let highlight: [Color] = [
      .accentColor, .blue, .green, .orange, .pink, .purple, .red, .yellow
  ]

  /// How much to shift the toggled cell by
  public let shift: Int

  /// The side length of the grid
  public let size: Int

  /// Layout for the grid view, all should have equal sizes
  private let columns: [GridItem]

  /// Keep track of all the cell states
  @State
  private var cells: [[Bool]]

  /// Keep track of the random colors so it's less random
  @State
  private var colors: [[Color]]

  /// Keep track to see if the cells has been edited
  @State
  private var isEdited = false

  @EnvironmentObject var stageManager: GameStageManager

  /// Initializes an evil game of life that's actually not game of life.
  /// - Parameters:
  ///   - size: side length of the grid
  ///   - shift: how many cells away does the selection action actually toggles.
  init(size: Int = 10, shift: Int = 1) {
    self.size = size
    self.shift = shift
    self.columns = Array(repeating: GridItem(.flexible()), count: size)
    self._cells = State(initialValue: [[Bool]](
      repeating: [Bool](repeating: false, count: size),
      count: size
    ))
    self._colors = State(initialValue: [[Color]](
      repeating: [Color](repeating: .primary, count: size),
      count: size
    ))
  }

  /// This is a size by size grid of toggles
  var grid: some View {
    GeometryReader { geo in
      LazyVGrid(columns: columns, spacing: 8) {
        ForEach(cells.indices) { rowIndex in
          ForEach(cells[rowIndex].indices) { columnIndex in
            Button {
              toggle(row: rowIndex, column: columnIndex)
            } label: {
              RoundedRectangle(cornerRadius: 5)
                .foregroundColor(colors[rowIndex][columnIndex])
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .buttonStyle(PlainButtonStyle())
            .help("Life is like a box of chocolate")
            .animation(.easeOut)
          }
        }
      }
      .frame(width: min(geo.size.width, geo.size.height),
             height: min(geo.size.width, geo.size.height))
    }
  }

  /// This is the actual start button
  var startButton: some View {
    Button(action: startGame, label: {
      Label("Start", systemImage: "play.fill")
    })
    .buttonStyle(PlainButtonStyle())
    .disabled(!isEdited)
    .help("This is a feature, not a bug")
  }

  /// The start button floats on top at bottom right corner
  var startButtonLayer: some View {
    HStack {
      Spacer()
      VStack {
        Spacer()
        Group {
          if isEdited {
            startButton
              .foregroundColor(.white)
              .background(RoundedRectangle(cornerRadius: 10)
                            .inset(by: -10)
                            .foregroundColor(.accentColor))
          } else {
            startButton
          }
        }
        .offset(x: -10, y: -10)
      }
    }
  }

  /// This is the main layout
  var body: some View {
    ZStack {
      grid
      startButtonLayer
    }
    .padding()
  }

  /// Toggles the state of a specified cell (but apply shifting to the coordinates)
  /// - Parameters:
  ///   - row: row index of a cell
  ///   - column: column index of a cell
  func toggle(row: Int, column: Int) {
    isEdited = true
    let shifted = (row * size + column + shift) % (size * size)
    let shiftedRow = shifted / size
    let shiftedColumn = shifted % size
    cells[shiftedRow][shiftedColumn].toggle()
    colors[shiftedRow][shiftedColumn]
      = cells[shiftedRow][shiftedColumn]
      ? Self.highlight.randomElement()!
      : .primary
    #if canImport(UIKit)
    generateRandomDelayedHapticFeedback()
    #endif
  }

  /// To make things more confusing, generate a random haptic feedback after delay.
  #if canImport(UIKit)
  func generateRandomDelayedHapticFeedback() {
    let options: [UINotificationFeedbackGenerator.FeedbackType]
      = [.error, .success, .warning]
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      UINotificationFeedbackGenerator()
        .notificationOccurred(options.randomElement()!)
    }
  }
  #endif

  /// Moving on to the next stage
  func startGame() {
    stageManager.advance(from: .gameOfLife)
  }
}

struct GameOfLifeView_Previews: PreviewProvider {
  static var previews: some View {
    GameOfLifeView()
  }
}
