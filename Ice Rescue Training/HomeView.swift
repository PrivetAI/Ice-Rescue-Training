import SwiftUI

struct HomeView: View {
    @EnvironmentObject var storage: StorageService
    @Binding var selectedTab: AppTab
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 8) {
                    SnowflakeIcon(size: 48, color: Theme.iceBlue)
                    
                    Text("Ice Rescue Training")
                        .font(Theme.titleFont())
                        .foregroundColor(Theme.textPrimary)
                    
                    Text("Learn. Practice. Save Lives.")
                        .font(Theme.captionFont())
                        .foregroundColor(Theme.textSecondary)
                }
                .padding(.top, 20)
                
                // Progress Card
                VStack(spacing: 12) {
                    HStack {
                        Text("Your Progress")
                            .font(Theme.headlineFont())
                            .foregroundColor(Theme.textPrimary)
                        Spacer()
                        Text("\(Int(storage.progress.overallProgress))%")
                            .font(Theme.headlineFont())
                            .foregroundColor(Theme.iceBlue)
                    }
                    
                    ProgressBarView(progress: storage.progress.overallProgress, color: Theme.iceBlue)
                    
                    HStack {
                        ProgressStat(value: "\(storage.progress.completedScenarios.count)/8", label: "Scenarios")
                        Spacer()
                        ProgressStat(value: storage.progress.knowledgeLevel.rawValue, label: "Level")
                    }
                }
                .padding(Theme.cardPadding)
                .cardStyle()
                .padding(.horizontal)
                
                // Main Menu
                VStack(spacing: 12) {
                    MenuButton(
                        title: "Learn Safety Rules",
                        subtitle: "Step-by-step guides",
                        icon: AnyView(BookIcon(size: 40, color: Theme.iceBlue)),
                        color: Theme.iceBlue
                    ) {
                        selectedTab = .learn
                    }
                    
                    MenuButton(
                        title: "Practice Scenarios",
                        subtitle: "Interactive simulations",
                        icon: AnyView(TargetIcon(size: 40, color: Theme.successGreen)),
                        color: Theme.successGreen
                    ) {
                        selectedTab = .practice
                    }
                    
                    MenuButton(
                        title: "Test Your Knowledge",
                        subtitle: "Quiz & certification",
                        icon: AnyView(CheckmarkIcon(size: 40, color: Theme.warningOrange)),
                        color: Theme.warningOrange
                    ) {
                        selectedTab = .test
                    }
                    
                    MenuButton(
                        title: "Emergency Info",
                        subtitle: "Quick access guide",
                        icon: AnyView(EmergencyIcon(size: 40, color: Theme.emergencyRed)),
                        color: Theme.emergencyRed
                    ) {
                        selectedTab = .emergency
                    }
                    
                    MenuButton(
                        title: "Knowledge Base",
                        subtitle: "Safety information & guides",
                        icon: AnyView(LibraryIcon(size: 40, color: Theme.iceBlueLight)),
                        color: Theme.iceBlueLight
                    ) {
                        selectedTab = .knowledge
                    }
                    
                    MenuButton(
                        title: "Equipment Checklist",
                        subtitle: "Prepare for ice safety",
                        icon: AnyView(ClipboardIcon(size: 40, color: Theme.successGreen)),
                        color: Theme.successGreen
                    ) {
                        selectedTab = .checklist
                    }
                }
                .padding(.horizontal)
                
                // Bottom buttons
                HStack(spacing: 16) {
                    SmallButton(icon: AnyView(GearIcon(size: 24)), label: "Settings") {
                        selectedTab = .settings
                    }
                    SmallButton(icon: AnyView(ChartIcon(size: 24)), label: "Progress") {
                        selectedTab = .progress
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
        .background(Theme.backgroundGradient.ignoresSafeArea())
    }
}

struct ProgressStat: View {
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(Theme.headlineFont())
                .foregroundColor(Theme.iceBlue)
            Text(label)
                .font(Theme.smallFont())
                .foregroundColor(Theme.textMuted)
        }
    }
}

struct SmallButton: View {
    let icon: AnyView
    let label: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                icon
                Text(label)
                    .font(Theme.smallFont())
                    .foregroundColor(Theme.textSecondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .glassStyle()
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
