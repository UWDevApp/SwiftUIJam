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
  /// How much to shift the toggled cell by
  public let shift: Int

  /// The side length of the grid
  public let size: Int

  /// Layout for the grid view, all should have equal sizes
  private let columns: [GridItem]

  /// Keep track of all the cell states
  @State
  private var cells: [[Bool]]

  /// Keep track to see if the cells has been edited
  @State
  private var isEdited = false

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
                .foregroundColor(colorForCell(row: rowIndex,
                                              column: columnIndex))
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
          }
        }
      }
      .frame(width: min(geo.size.width, geo.size.height),
             height: min(geo.size.width, geo.size.height))
    }
  }

  /// This is the main view
  var body: some View {
    VStack {
      grid

      Button(action: startGame, label: {
        Label("Start", systemImage: "play.fill")
      })
      .disabled(!isEdited)

    }
    .padding()
  }

  /// Returns the color of a cell to render in.
  /// - Parameters:
  ///   - row: row index of a cell
  ///   - column: column index of a cell
  /// - Returns: the color to use for the given cell in
  func colorForCell(row: Int, column: Int) -> Color {
    return cells[row][column] ? .accentColor : .primary
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
  }

  /// Moving on to the next stage
  func startGame() {
    // TODO: Next stage
  }
}

struct GameOfLifeView_Previews: PreviewProvider {
  static var previews: some View {
    GameOfLifeView()
  }
}
