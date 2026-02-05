import SwiftUI

// MARK: - Menu Button
struct MenuButton: View {
    let title: String
    let subtitle: String
    let icon: AnyView
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                icon
                    .frame(width: 50, height: 50)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(Theme.headlineFont())
                        .foregroundColor(Theme.textPrimary)
                    
                    Text(subtitle)
                        .font(Theme.captionFont())
                        .foregroundColor(Theme.textSecondary)
                }
                
                Spacer()
                
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: 8, y: 10))
                    path.addLine(to: CGPoint(x: 0, y: 20))
                }
                .stroke(Theme.textMuted, style: StrokeStyle(lineWidth: 2, lineCap: .round))
                .frame(width: 8, height: 20)
            }
            .padding(Theme.cardPadding)
            .background(
                RoundedRectangle(cornerRadius: Theme.cornerRadius)
                    .fill(Theme.cardGradient)
                    .overlay(
                        RoundedRectangle(cornerRadius: Theme.cornerRadius)
                            .stroke(color.opacity(0.3), lineWidth: 1)
                    )
            )
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

// MARK: - Progress Bar
struct ProgressBarView: View {
    let progress: Double
    let color: Color
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Theme.backgroundLight)
                    .frame(height: 8)
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(color)
                    .frame(width: geo.size.width * min(progress / 100, 1), height: 8)
            }
        }
        .frame(height: 8)
    }
}

// MARK: - Card View
struct CardView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding(Theme.cardPadding)
            .cardStyle()
    }
}

// MARK: - Header View
struct HeaderView: View {
    let title: String
    let subtitle: String?
    let showBack: Bool
    let backAction: (() -> Void)?
    
    init(title: String, subtitle: String? = nil, showBack: Bool = false, backAction: (() -> Void)? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.showBack = showBack
        self.backAction = backAction
    }
    
    var body: some View {
        HStack {
            if showBack {
                Button(action: { backAction?() }) {
                    BackArrowIcon(size: 24)
                }
                .padding(.trailing, 8)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(Theme.titleFont())
                    .foregroundColor(Theme.textPrimary)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(Theme.captionFont())
                        .foregroundColor(Theme.textSecondary)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

// MARK: - Button Styles
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    var color: Color = Theme.iceBlue
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Theme.headlineFont())
            .foregroundColor(.white)
            .padding(.horizontal, 24)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: Theme.cornerRadius)
                    .fill(color)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}

// MARK: - Step Card
struct StepCardView: View {
    let stepNumber: Int
    let title: String
    let content: String
    let isCompleted: Bool
    let isCurrent: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                Circle()
                    .fill(isCompleted ? Theme.successGreen : (isCurrent ? Theme.iceBlue : Theme.backgroundLight))
                    .frame(width: 32, height: 32)
                
                if isCompleted {
                    Path { path in
                        path.move(to: CGPoint(x: 8, y: 16))
                        path.addLine(to: CGPoint(x: 13, y: 21))
                        path.addLine(to: CGPoint(x: 24, y: 10))
                    }
                    .stroke(Color.white, style: StrokeStyle(lineWidth: 2, lineCap: .round))
                    .frame(width: 32, height: 32)
                } else {
                    Text("\(stepNumber)")
                        .font(Theme.captionFont())
                        .foregroundColor(isCurrent ? .white : Theme.textMuted)
                }
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(Theme.headlineFont())
                    .foregroundColor(isCurrent ? Theme.iceBlue : Theme.textPrimary)
                
                Text(content)
                    .font(Theme.bodyFont())
                    .foregroundColor(Theme.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(Theme.cardPadding)
        .background(
            RoundedRectangle(cornerRadius: Theme.cornerRadius)
                .fill(isCurrent ? Theme.backgroundLight : Theme.backgroundMedium)
                .overlay(
                    RoundedRectangle(cornerRadius: Theme.cornerRadius)
                        .stroke(isCurrent ? Theme.iceBlue.opacity(0.5) : Color.clear, lineWidth: 1)
                )
        )
    }
}

// MARK: - Difficulty Badge
struct DifficultyBadge: View {
    let difficulty: Scenario.Difficulty
    
    var color: Color {
        switch difficulty {
        case .easy: return Theme.successGreen
        case .medium: return Theme.warningOrange
        case .hard: return Theme.emergencyRed
        }
    }
    
    var body: some View {
        Text(difficulty.rawValue)
            .font(Theme.smallFont())
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
                Capsule().fill(color)
            )
    }
}
