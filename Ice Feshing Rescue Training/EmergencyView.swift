import SwiftUI

struct EmergencyView: View {
    @Binding var selectedTab: AppTab
    @State private var selectedSection: Int = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HeaderView(title: "Emergency", subtitle: "Quick Reference Guide", showBack: true) {
                    selectedTab = .home
                }
                
                // Tabs
                HStack(spacing: 0) {
                    TabButton(title: "Self-Rescue", isSelected: selectedSection == 0) {
                        selectedSection = 0
                    }
                    TabButton(title: "Hypothermia", isSelected: selectedSection == 1) {
                        selectedSection = 1
                    }
                }
                .padding(.horizontal)
                
                if selectedSection == 0 {
                    selfRescueSection
                } else {
                    hypothermiaSection
                }
            }
            .padding(.bottom, 20)
        }
        .background(Theme.backgroundGradient.ignoresSafeArea())
    }
    
    var selfRescueSection: some View {
        VStack(spacing: 12) {
            ForEach(ContentData.emergencySteps) { step in
                EmergencyStepCard(step: step)
            }
        }
        .padding(.horizontal)
    }
    
    var hypothermiaSection: some View {
        VStack(spacing: 16) {
            ForEach(ContentData.hypothermiaSigns) { sign in
                HypothermiaCard(sign: sign)
            }
            
            // Warning card
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    WarningIcon(size: 24, color: Theme.emergencyRed)
                    Text("Do NOT")
                        .font(Theme.headlineFont())
                        .foregroundColor(Theme.emergencyRed)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    DontItem(text: "Rub arms or legs")
                    DontItem(text: "Give alcohol")
                    DontItem(text: "Put in hot bath")
                    DontItem(text: "Apply heat to extremities first")
                }
            }
            .padding(Theme.cardPadding)
            .background(
                RoundedRectangle(cornerRadius: Theme.cornerRadius)
                    .fill(Theme.emergencyRed.opacity(0.15))
                    .overlay(
                        RoundedRectangle(cornerRadius: Theme.cornerRadius)
                            .stroke(Theme.emergencyRed.opacity(0.3), lineWidth: 1)
                    )
            )
        }
        .padding(.horizontal)
    }
}

struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Theme.captionFont())
                .foregroundColor(isSelected ? Theme.textPrimary : Theme.textMuted)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isSelected ? Theme.iceBlue.opacity(0.2) : Color.clear)
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct EmergencyStepCard: View {
    let step: EmergencyStep
    
    var icon: some View {
        Group {
            switch step.icon {
            case "info": InfoIcon(size: 28, color: Theme.iceBlue)
            case "target": TargetIcon(size: 28, color: Theme.iceBlue)
            case "book": BookIcon(size: 28, color: Theme.iceBlue)
            case "warning": WarningIcon(size: 28, color: Theme.warningOrange)
            case "emergency": EmergencyIcon(size: 28, color: Theme.emergencyRed)
            default: InfoIcon(size: 28, color: Theme.iceBlue)
            }
        }
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            ZStack {
                Circle()
                    .fill(step.isWarning ? Theme.emergencyRed : Theme.iceBlue)
                    .frame(width: 36, height: 36)
                
                Text("\(step.stepNumber)")
                    .font(Theme.headlineFont())
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(step.title)
                    .font(Theme.headlineFont())
                    .foregroundColor(step.isWarning ? Theme.emergencyRed : Theme.textPrimary)
                
                Text(step.description)
                    .font(Theme.bodyFont())
                    .foregroundColor(Theme.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(Theme.cardPadding)
        .background(
            RoundedRectangle(cornerRadius: Theme.cornerRadius)
                .fill(step.isWarning ? Theme.emergencyRed.opacity(0.1) : Theme.backgroundLight)
                .overlay(
                    RoundedRectangle(cornerRadius: Theme.cornerRadius)
                        .stroke(step.isWarning ? Theme.emergencyRed.opacity(0.3) : Theme.iceBlue.opacity(0.2), lineWidth: 1)
                )
        )
    }
}

struct HypothermiaCard: View {
    let sign: HypothermiaSign
    
    var severityColor: Color {
        switch sign.severity {
        case .mild: return Theme.successGreen
        case .moderate: return Theme.warningOrange
        case .severe: return Theme.emergencyRed
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(sign.stage)
                    .font(Theme.headlineFont())
                    .foregroundColor(severityColor)
                
                Spacer()
                
                Text(sign.temperature)
                    .font(Theme.captionFont())
                    .foregroundColor(Theme.textMuted)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                ForEach(sign.signs, id: \.self) { symptom in
                    HStack(spacing: 8) {
                        Circle()
                            .fill(severityColor)
                            .frame(width: 6, height: 6)
                        Text(symptom)
                            .font(Theme.bodyFont())
                            .foregroundColor(Theme.textSecondary)
                    }
                }
            }
        }
        .padding(Theme.cardPadding)
        .background(
            RoundedRectangle(cornerRadius: Theme.cornerRadius)
                .fill(severityColor.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: Theme.cornerRadius)
                        .stroke(severityColor.opacity(0.3), lineWidth: 1)
                )
        )
    }
}

struct DontItem: View {
    let text: String
    
    var body: some View {
        HStack(spacing: 8) {
            Path { path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: 10, y: 10))
                path.move(to: CGPoint(x: 10, y: 0))
                path.addLine(to: CGPoint(x: 0, y: 10))
            }
            .stroke(Theme.emergencyRed, style: StrokeStyle(lineWidth: 2, lineCap: .round))
            .frame(width: 10, height: 10)
            
            Text(text)
                .font(Theme.bodyFont())
                .foregroundColor(Theme.textPrimary)
        }
    }
}
