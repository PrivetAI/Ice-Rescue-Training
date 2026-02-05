import SwiftUI

enum AppTab {
    case home
    case learn
    case practice
    case test
    case emergency
    case settings
    case progress
    case knowledge
    case checklist
}

struct ContentView: View {
    @State private var selectedTab: AppTab = .home
    
    var body: some View {
        ZStack {
            switch selectedTab {
            case .home:
                HomeView(selectedTab: $selectedTab)
            case .learn:
                LearnView(selectedTab: $selectedTab)
            case .practice:
                PracticeView(selectedTab: $selectedTab)
            case .test:
                TestView(selectedTab: $selectedTab)
            case .emergency:
                EmergencyView(selectedTab: $selectedTab)
            case .settings:
                SettingsView(selectedTab: $selectedTab)
            case .progress:
                MyProgressView(selectedTab: $selectedTab)
            case .knowledge:
                KnowledgeView(selectedTab: $selectedTab)
            case .checklist:
                ChecklistView(selectedTab: $selectedTab)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: selectedTab)
    }
}
