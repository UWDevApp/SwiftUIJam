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

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
      SimpleEntry(date: Date(), configuration: ConfigurationIntent(), quotes: ["Start the game"])
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
      let entry = SimpleEntry(date: Date(), configuration: configuration, quotes: [])
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
          let entry = SimpleEntry(date: entryDate, configuration: configuration, quotes: ["\"Starting over is harder than starting up\"","\"Swift never runs around and deserts you\"",""])
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let quotes:[String]
}

func dateFormat(date:Date) -> String {
  let formatter = DateFormatter()
  formatter.dateStyle = .short
  return formatter.string(from: date)
}

struct Widget2EntryView : View {
    var entry: Provider.Entry
  
  @AppStorage("levelData",store: UserDefaults(suiteName: "group.sharedLevel"))
  var levelValue: GameStage = GameStage.gameOfLife
    
    var body: some View {
      HStack{
        VStack{
          Text("Quotes for life on \(dateFormat(date:entry.date))").foregroundColor(Color(.systemGreen))
          Spacer()
          ForEach(0..<levelValue.rawValue+1) {levelValue in
            Text(entry.quotes[levelValue])
          }
          
        }
        Spacer()
      }.padding(.all,10)
      .background(
          LinearGradient(
            gradient: Gradient(colors: [
              Color(red: 3 / 255, green: 3 / 255, blue: 3 / 255),
              Color(red: 114 / 255, green: 114 / 255, blue: 131 / 255),
            ]),
            startPoint: .top, endPoint: .bottom
          ))
    }
}

@main
struct Widget2: Widget {
    let kind: String = "Widget2"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            Widget2EntryView(entry: entry)
        }
        .configurationDisplayName("Game of Life Widget")
        .description("Some wholesome quotes for you to stay in the game")
    }
}

struct Widget2_Previews: PreviewProvider {
    static var previews: some View {
        Widget2EntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), quotes: ["\"Starting over is harder than starting up\"","\"Swift never runs around and deserts you\"",""]))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
      Widget2EntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), quotes: ["\"Starting over is harder than starting up\"","\"Swift never runs around and deserts you\"",""]))
          .previewContext(WidgetPreviewContext(family: .systemMedium))
      Widget2EntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), quotes: ["\"Starting over is harder than starting up\"","\"Swift never runs around and deserts you\"",""]))
          .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
