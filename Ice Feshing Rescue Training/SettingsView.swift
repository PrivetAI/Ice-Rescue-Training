import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var storage: StorageService
    @Binding var selectedTab: AppTab
    @State private var showResetAlert = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HeaderView(title: "Settings", showBack: true) {
                    selectedTab = .home
                }
                
                // App Info
                VStack(spacing: 16) {
                    SnowflakeIcon(size: 48, color: Theme.iceBlue)
                    
                    Text("Ice Feshing Rescue Training")
                        .font(Theme.headlineFont())
                        .foregroundColor(Theme.textPrimary)
                    
                    Text("Version 1.0")
                        .font(Theme.captionFont())
                        .foregroundColor(Theme.textMuted)
                }
                .padding(24)
                .frame(maxWidth: .infinity)
                .cardStyle()
                .padding(.horizontal)
                
                // Reset Progress
                VStack(alignment: .leading, spacing: 16) {
                    Text("Data")
                        .font(Theme.headlineFont())
                        .foregroundColor(Theme.textPrimary)
                    
                    Button(action: { showResetAlert = true }) {
                        HStack {
                            Text("Reset All Progress")
                                .font(Theme.bodyFont())
                                .foregroundColor(Theme.emergencyRed)
                            Spacer()
                        }
                        .padding(Theme.cardPadding)
                        .glassStyle()
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
                .padding(.horizontal)
                
                // About
                VStack(alignment: .leading, spacing: 16) {
                    Text("About")
                        .font(Theme.headlineFont())
                        .foregroundColor(Theme.textPrimary)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("This app teaches critical ice rescue skills that could save lives. Every year, people fall through thin ice. Knowing what to do can mean the difference between life and death.")
                            .font(Theme.bodyFont())
                            .foregroundColor(Theme.textSecondary)
                        
                        Text("Practice the scenarios, learn the techniques, and be prepared.")
                            .font(Theme.bodyFont())
                            .foregroundColor(Theme.iceBlue)
                    }
                    .padding(Theme.cardPadding)
                    .cardStyle()
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 20)
        }
        .background(Theme.backgroundGradient.ignoresSafeArea())
        .alert(isPresented: $showResetAlert) {
            Alert(
                title: Text("Reset Progress"),
                message: Text("This will delete all your progress, completed lessons, scenarios, and test results. This cannot be undone."),
                primaryButton: .destructive(Text("Reset")) {
                    storage.resetProgress()
                },
                secondaryButton: .cancel()
            )
        }
    }
}
