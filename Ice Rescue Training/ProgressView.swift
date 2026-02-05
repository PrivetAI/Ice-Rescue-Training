import SwiftUI

struct MyProgressView: View {
    @EnvironmentObject var storage: StorageService
    @Binding var selectedTab: AppTab
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HeaderView(title: "My Progress", showBack: true) {
                    selectedTab = .home
                }
                
                // Overall Progress
                VStack(spacing: 16) {
                    ZStack {
                        Circle()
                            .stroke(Theme.backgroundLight, lineWidth: 12)
                            .frame(width: 120, height: 120)
                        
                        Circle()
                            .trim(from: 0, to: storage.progress.overallProgress / 100)
                            .stroke(Theme.iceBlue, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                            .frame(width: 120, height: 120)
                            .rotationEffect(.degrees(-90))
                        
                        VStack {
                            Text("\(Int(storage.progress.overallProgress))%")
                                .font(Theme.titleFont())
                                .foregroundColor(Theme.iceBlue)
                            Text("Complete")
                                .font(Theme.smallFont())
                                .foregroundColor(Theme.textMuted)
                        }
                    }
                    
                    Text("Knowledge Level: \(storage.progress.knowledgeLevel.rawValue)")
                        .font(Theme.headlineFont())
                        .foregroundColor(Theme.textPrimary)
                }
                .padding(24)
                .frame(maxWidth: .infinity)
                .cardStyle()
                .padding(.horizontal)
                
                // Stats
                HStack(spacing: 12) {
                    StatCard(
                        value: "\(storage.progress.completedLessons.count)",
                        label: "Lessons",
                        total: "6",
                        color: Theme.iceBlue
                    )
                    StatCard(
                        value: "\(storage.progress.completedScenarios.count)",
                        label: "Scenarios",
                        total: "8",
                        color: Theme.successGreen
                    )
                    StatCard(
                        value: "\(storage.progress.testResults.filter { $0.passed }.count)",
                        label: "Tests Passed",
                        total: nil,
                        color: Theme.warningOrange
                    )
                }
                .padding(.horizontal)
                
                // Lessons Progress
                VStack(alignment: .leading, spacing: 12) {
                    Text("Lessons")
                        .font(Theme.headlineFont())
                        .foregroundColor(Theme.textPrimary)
                    
                    ForEach(ContentData.lessons) { lesson in
                        HStack {
                            Text(lesson.title)
                                .font(Theme.bodyFont())
                                .foregroundColor(Theme.textSecondary)
                            Spacer()
                            if storage.progress.completedLessons.contains(lesson.id) {
                                CheckmarkIcon(size: 20, color: Theme.successGreen)
                            } else {
                                Circle()
                                    .stroke(Theme.textMuted, lineWidth: 2)
                                    .frame(width: 20, height: 20)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .padding(Theme.cardPadding)
                .cardStyle()
                .padding(.horizontal)
                
                // Scenarios Progress
                VStack(alignment: .leading, spacing: 12) {
                    Text("Scenarios")
                        .font(Theme.headlineFont())
                        .foregroundColor(Theme.textPrimary)
                    
                    ForEach(ContentData.scenarios) { scenario in
                        HStack {
                            Text(scenario.title)
                                .font(Theme.bodyFont())
                                .foregroundColor(Theme.textSecondary)
                            Spacer()
                            DifficultyBadge(difficulty: scenario.difficulty)
                            if storage.progress.completedScenarios.contains(scenario.id) {
                                CheckmarkIcon(size: 20, color: Theme.successGreen)
                            }
                        }
                        .padding(.vertical, 6)
                    }
                }
                .padding(Theme.cardPadding)
                .cardStyle()
                .padding(.horizontal)
            }
            .padding(.bottom, 20)
        }
        .background(Theme.backgroundGradient.ignoresSafeArea())
    }
}

struct StatCard: View {
    let value: String
    let label: String
    let total: String?
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            if let total = total {
                Text("\(value)/\(total)")
                    .font(Theme.titleFont())
                    .foregroundColor(color)
            } else {
                Text(value)
                    .font(Theme.titleFont())
                    .foregroundColor(color)
            }
            Text(label)
                .font(Theme.smallFont())
                .foregroundColor(Theme.textMuted)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .glassStyle()
    }
}
