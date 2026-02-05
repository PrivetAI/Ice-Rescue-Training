import SwiftUI

// MARK: - Custom Icons using Shape
struct BookIcon: View {
    var size: CGFloat = 32
    var color: Color = Theme.iceBlue
    
    var body: some View {
        ZStack {
            // Book cover
            RoundedRectangle(cornerRadius: 3)
                .fill(color)
                .frame(width: size * 0.8, height: size)
            
            // Pages
            VStack(spacing: size * 0.08) {
                ForEach(0..<3, id: \.self) { _ in
                    Rectangle()
                        .fill(Color.white.opacity(0.9))
                        .frame(width: size * 0.5, height: size * 0.06)
                }
            }
            
            // Spine
            Rectangle()
                .fill(color.opacity(0.7))
                .frame(width: size * 0.08, height: size)
                .offset(x: -size * 0.36)
        }
        .frame(width: size, height: size)
    }
}

struct TargetIcon: View {
    var size: CGFloat = 32
    var color: Color = Theme.iceBlue
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(color, lineWidth: size * 0.08)
                .frame(width: size, height: size)
            Circle()
                .stroke(color, lineWidth: size * 0.08)
                .frame(width: size * 0.6, height: size * 0.6)
            Circle()
                .fill(color)
                .frame(width: size * 0.25, height: size * 0.25)
        }
        .frame(width: size, height: size)
    }
}

struct CheckmarkIcon: View {
    var size: CGFloat = 32
    var color: Color = Theme.successGreen
    
    var body: some View {
        ZStack {
            Circle()
                .fill(color)
                .frame(width: size, height: size)
            
            Path { path in
                path.move(to: CGPoint(x: size * 0.25, y: size * 0.5))
                path.addLine(to: CGPoint(x: size * 0.42, y: size * 0.68))
                path.addLine(to: CGPoint(x: size * 0.75, y: size * 0.32))
            }
            .stroke(Color.white, style: StrokeStyle(lineWidth: size * 0.1, lineCap: .round, lineJoin: .round))
        }
        .frame(width: size, height: size)
    }
}

struct EmergencyIcon: View {
    var size: CGFloat = 32
    var color: Color = Theme.emergencyRed
    
    var body: some View {
        ZStack {
            Circle()
                .fill(color)
                .frame(width: size, height: size)
            
            // Cross
            Rectangle()
                .fill(Color.white)
                .frame(width: size * 0.5, height: size * 0.18)
            Rectangle()
                .fill(Color.white)
                .frame(width: size * 0.18, height: size * 0.5)
        }
        .frame(width: size, height: size)
    }
}

struct GearIcon: View {
    var size: CGFloat = 32
    var color: Color = Theme.textSecondary
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(color, lineWidth: size * 0.12)
                .frame(width: size * 0.45, height: size * 0.45)
            
            ForEach(0..<8, id: \.self) { i in
                Rectangle()
                    .fill(color)
                    .frame(width: size * 0.12, height: size * 0.22)
                    .offset(y: -size * 0.38)
                    .rotationEffect(.degrees(Double(i) * 45))
            }
        }
        .frame(width: size, height: size)
    }
}

struct ChartIcon: View {
    var size: CGFloat = 32
    var color: Color = Theme.iceBlue
    
    var body: some View {
        HStack(alignment: .bottom, spacing: size * 0.1) {
            Rectangle().fill(color.opacity(0.6)).frame(width: size * 0.18, height: size * 0.4)
            Rectangle().fill(color.opacity(0.8)).frame(width: size * 0.18, height: size * 0.7)
            Rectangle().fill(color).frame(width: size * 0.18, height: size * 0.55)
            Rectangle().fill(color.opacity(0.9)).frame(width: size * 0.18, height: size * 0.9)
        }
        .frame(width: size, height: size, alignment: .bottom)
    }
}

struct InfoIcon: View {
    var size: CGFloat = 32
    var color: Color = Theme.iceBlue
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(color, lineWidth: size * 0.08)
                .frame(width: size, height: size)
            
            VStack(spacing: size * 0.08) {
                Circle()
                    .fill(color)
                    .frame(width: size * 0.12, height: size * 0.12)
                Rectangle()
                    .fill(color)
                    .frame(width: size * 0.1, height: size * 0.35)
            }
            .offset(y: size * 0.05)
        }
        .frame(width: size, height: size)
    }
}

struct BackArrowIcon: View {
    var size: CGFloat = 24
    var color: Color = Theme.iceBlue
    
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: size * 0.6, y: size * 0.2))
            path.addLine(to: CGPoint(x: size * 0.25, y: size * 0.5))
            path.addLine(to: CGPoint(x: size * 0.6, y: size * 0.8))
        }
        .stroke(color, style: StrokeStyle(lineWidth: size * 0.12, lineCap: .round, lineJoin: .round))
        .frame(width: size, height: size)
    }
}

struct SnowflakeIcon: View {
    var size: CGFloat = 32
    var color: Color = Theme.iceBlueLight
    
    var body: some View {
        ZStack {
            ForEach(0..<6, id: \.self) { i in
                VStack {
                    Rectangle()
                        .fill(color)
                        .frame(width: size * 0.06, height: size * 0.45)
                }
                .rotationEffect(.degrees(Double(i) * 30))
            }
            Circle()
                .fill(color)
                .frame(width: size * 0.15, height: size * 0.15)
        }
        .frame(width: size, height: size)
    }
}

struct WarningIcon: View {
    var size: CGFloat = 32
    var color: Color = Theme.warningOrange
    
    var body: some View {
        ZStack {
            Triangle()
                .fill(color)
                .frame(width: size, height: size * 0.9)
            
            VStack(spacing: size * 0.05) {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: size * 0.1, height: size * 0.3)
                Circle()
                    .fill(Color.white)
                    .frame(width: size * 0.1, height: size * 0.1)
            }
            .offset(y: size * 0.08)
        }
        .frame(width: size, height: size)
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}
