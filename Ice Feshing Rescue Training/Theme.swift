import SwiftUI

struct Theme {
    // MARK: - Colors
    static let backgroundDark = Color(red: 0.05, green: 0.08, blue: 0.13)
    static let backgroundMedium = Color(red: 0.10, green: 0.16, blue: 0.23)
    static let backgroundLight = Color(red: 0.15, green: 0.22, blue: 0.30)
    
    static let iceBlue = Color(red: 0.31, green: 0.76, blue: 0.97)
    static let iceBlueDark = Color(red: 0.20, green: 0.55, blue: 0.75)
    static let iceBlueLight = Color(red: 0.55, green: 0.85, blue: 0.98)
    
    static let emergencyRed = Color(red: 0.95, green: 0.30, blue: 0.25)
    static let warningOrange = Color(red: 1.0, green: 0.44, blue: 0.26)
    static let successGreen = Color(red: 0.30, green: 0.78, blue: 0.45)
    
    static let textPrimary = Color.white
    static let textSecondary = Color(white: 0.7)
    static let textMuted = Color(white: 0.5)
    
    // MARK: - Gradients
    static let backgroundGradient = LinearGradient(
        colors: [backgroundDark, backgroundMedium],
        startPoint: .top,
        endPoint: .bottom
    )
    
    static let cardGradient = LinearGradient(
        colors: [backgroundLight, backgroundMedium],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let iceGradient = LinearGradient(
        colors: [iceBlue, iceBlueDark],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let emergencyGradient = LinearGradient(
        colors: [emergencyRed, warningOrange],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    // MARK: - Dimensions
    static let cornerRadius: CGFloat = 16
    static let cardPadding: CGFloat = 16
    static let spacing: CGFloat = 12
    static let iconSize: CGFloat = 32
    
    // MARK: - Fonts
    static func titleFont() -> Font {
        .system(size: 28, weight: .bold, design: .rounded)
    }
    
    static func headlineFont() -> Font {
        .system(size: 20, weight: .semibold, design: .rounded)
    }
    
    static func bodyFont() -> Font {
        .system(size: 16, weight: .regular, design: .rounded)
    }
    
    static func captionFont() -> Font {
        .system(size: 14, weight: .medium, design: .rounded)
    }
    
    static func smallFont() -> Font {
        .system(size: 12, weight: .regular, design: .rounded)
    }
}

// MARK: - View Modifiers
struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Theme.cardGradient)
            .cornerRadius(Theme.cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.cornerRadius)
                    .stroke(Theme.iceBlue.opacity(0.2), lineWidth: 1)
            )
    }
}

struct GlassStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Theme.backgroundLight.opacity(0.6))
            .cornerRadius(Theme.cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.cornerRadius)
                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
            )
    }
}

extension View {
    func cardStyle() -> some View {
        modifier(CardStyle())
    }
    
    func glassStyle() -> some View {
        modifier(GlassStyle())
    }
}
