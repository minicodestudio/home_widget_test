import WidgetKit
import SwiftUI

private let widgetGroupId = "group.flutter_mcs_group"

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), title: "Placeholder Title", description: "Placeholder Message")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let data = UserDefaults(suiteName: widgetGroupId)
        
        let entry = SimpleEntry(date: Date(), title: data?.string(forKey: "title") ?? "No Title Set", description: data?.string(forKey: "description") ?? "No Message Set")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        var entries: [SimpleEntry] = []

        // 현재 날짜와 시간을 가져옵니다.
        let currentDate = Date()
        
        // 15분마다 새 항목을 추가하여 5개의 항목을 생성합니다.
        for minuteOffset in 0..<5 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset * 15, to: currentDate)!
            let data = UserDefaults(suiteName: widgetGroupId)
            let entry = SimpleEntry(date: entryDate, title: data?.string(forKey: "title") ?? "No Title Set", description: data?.string(forKey: "description") ?? "No Message Set")
            entries.append(entry)
        }

        // 타임라인을 생성하고 completion 핸들러를 통해 반환합니다.
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let title: String
    let description: String
}

struct test_home_screenEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.date, style: .time)
            Text(entry.title)
                .font(.headline)
            Text(entry.description)
                .font(.subheadline)
        }
        .padding()
    }
}

struct test_home_screen: Widget {
    let kind: String = "test_home_screen"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            test_home_screenEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct test_home_screen_Previews: PreviewProvider {
    static var previews: some View {
        test_home_screenEntryView(entry: SimpleEntry(date: Date(), title: "Preview Title", description: "Preview Message"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
