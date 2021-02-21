//
//  Widget2.swift
//  Widget2
//
//  Created by Xinyi Xiang on 2/21/21.
//  Copyright © 2021 AppDev@UW. All rights reserved.
//

import WidgetKit
import SwiftUI
import Intents

let quotes = [
  "Starting over is harder than starting up",
  "Swift never flies around and deserts you",
  "OwO"
]

struct Provider: TimelineProvider {
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(date: Date(), isSmall: context.family == .systemSmall)
  }

  func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
    let entry = SimpleEntry(date: Date(), isSmall: context.family == .systemSmall)
    completion(entry)
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
    var entries: [SimpleEntry] = []

    // Generate a timeline consisting of five entries an hour apart, starting from the current date.
    let currentDate = Date()
    for offset in 1 ..< 5 {
      let entryDate = Calendar.current.date(byAdding: .minute, value: offset, to: currentDate)!
      let entry = SimpleEntry(date: entryDate, isSmall: context.family == .systemSmall)
      entries.append(entry)
    }

    let timeline = Timeline(entries: entries, policy: .atEnd)
    completion(timeline)
  }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
  let isSmall: Bool
}

let formatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .short
  return formatter
}()

struct Widget2EntryView : View {
  var entry: Provider.Entry

  // TODO: not working, not sure why
  @AppStorage(GameStage.key, store: GameStage.userDefaults)
  var levelValue: GameStage = GameStage.current

  var body: some View {
    HStack{
      Spacer()
      VStack{
        Spacer()
        Text(quotes.randomElement()!)
          .fontWeight(.bold)
          .foregroundColor(.white)
        Spacer()
        if !entry.isSmall {
          Text("Quotes for life on \(formatter.string(from: entry.date))")
            .foregroundColor(.green)
            .font(Font.system(.footnote))
        }
      }
      Spacer()
    }
    .padding()
    .background(
      LinearGradient(
        gradient: Gradient(colors: [
          Color(red: 3 / 255, green: 3 / 255, blue: 3 / 255),
          Color(red: 114 / 255, green: 114 / 255, blue: 131 / 255),
        ]),
        startPoint: .top, endPoint: .bottom
      )
    )
  }
}

@main
struct Widget2: Widget {
  let kind: String = "app.uwdev.Game-of-Life.iOS.Widget.quotes"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      Widget2EntryView(entry: entry)
    }
    .configurationDisplayName("Game of Life Widget")
    .description("Some wholesome quotes for you to stay in the game")
  }
}

struct Widget2_Previews: PreviewProvider {
  static var previews: some View {
    Widget2EntryView(entry: SimpleEntry(date: Date(), isSmall: true), levelValue: .gameOfLife)
      .previewContext(WidgetPreviewContext(family: .systemSmall))
    Widget2EntryView(entry: SimpleEntry(date: Date(), isSmall: false), levelValue: .end)
      .previewContext(WidgetPreviewContext(family: .systemMedium))
    Widget2EntryView(entry: SimpleEntry(date: Date(), isSmall: false))
      .previewContext(WidgetPreviewContext(family: .systemLarge))
  }
}
