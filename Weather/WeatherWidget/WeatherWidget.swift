//
//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by Adeel Tahir on 16/12/2022.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    typealias Entry = WeatherEntry
    let viewModel = WeatherViewModel()
    
    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry(date: Date(), viewModel: WeatherViewModel())
    }

    func getSnapshot(in context: Context, completion: @escaping (WeatherEntry) -> ()) {
        let entry = WeatherEntry(date: Date(), viewModel: WeatherViewModel())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [WeatherEntry] = []

        let currentDate = Date()
        
        let entryDate = Calendar.current.date(byAdding: .hour, value: 5, to: currentDate)!
        viewModel.fetchWeather { viewModel in
            let entry = WeatherEntry(date: entryDate, viewModel: viewModel)
            entries.append(entry)
            let timeline = Timeline(entries: entries, policy: .after(entryDate))
            completion(timeline)
        }
    }
}

struct WeatherEntry: TimelineEntry {
    let date: Date
    let viewModel: WeatherViewModel!
}

struct WeatherWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(uiColor: UIColor.init(hex: "#1F3568")!), Color(uiColor: UIColor(hex: "#495E92")!), Color(uiColor: UIColor(hex: "#B1886E")!)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            switch family {
            case .systemSmall:
                WeatherWidgetSmallView(viewModel: entry.viewModel)
            case .systemMedium:
                VStack {
                    Text("Medium Widget View")
                    Spacer()
                    Text("Medium Widget View Part 2")
                }
            case .systemLarge:
                WeatherWidgetLargeView(viewModel: entry.viewModel)

            @unknown default:
                fatalError()
            }
        }
    }
}

@main
struct WeatherWidget: Widget {
    let kind: String = "WeatherWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WeatherWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Weather Widget")
        .description("This widget displays current weather for CA")
        .supportedFamilies([.systemSmall, .systemLarge])
    }
}

struct WeatherWidget_Previews: PreviewProvider {
    static var previews: some View {
        WeatherWidgetEntryView(entry: WeatherEntry(date: Date(), viewModel: WeatherViewModel()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
