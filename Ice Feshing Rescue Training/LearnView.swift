import SwiftUI

struct LearnView: View {
    @EnvironmentObject var storage: StorageService
    @State private var selectedLesson: Lesson?
    @State private var currentSection: Int = 0
    @State private var currentStep: Int = 0
    @Binding var selectedTab: AppTab
    
    var body: some View {
        if let lesson = selectedLesson {
            LessonDetailView(
                lesson: lesson,
                currentSection: $currentSection,
                currentStep: $currentStep,
                onBack: { selectedLesson = nil },
                onComplete: {
                    storage.markLessonCompleted(lesson.id)
                    selectedLesson = nil
                }
            )
        } else {
            lessonsList
        }
    }
    
    var lessonsList: some View {
        ScrollView {
            VStack(spacing: 16) {
                HeaderView(title: "Learn", subtitle: "Safety Rules & Techniques", showBack: true) {
                    selectedTab = .home
                }
                
                ForEach(ContentData.lessons) { lesson in
                    LessonCard(
                        lesson: lesson,
                        isCompleted: storage.progress.completedLessons.contains(lesson.id)
                    ) {
                        currentSection = 0
                        currentStep = 0
                        selectedLesson = lesson
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 20)
        }
        .background(Theme.backgroundGradient.ignoresSafeArea())
    }
}

struct LessonCard: View {
    let lesson: Lesson
    let isCompleted: Bool
    let action: () -> Void
    
    var icon: some View {
        Group {
            switch lesson.icon {
            case "book": BookIcon(size: 36, color: Theme.iceBlue)
            case "target": TargetIcon(size: 36, color: Theme.iceBlue)
            case "emergency": EmergencyIcon(size: 36, color: Theme.emergencyRed)
            case "gear": GearIcon(size: 36, color: Theme.textSecondary)
            case "snowflake": SnowflakeIcon(size: 36, color: Theme.iceBlueLight)
            case "warning": WarningIcon(size: 36, color: Theme.warningOrange)
            default: BookIcon(size: 36, color: Theme.iceBlue)
            }
        }
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                icon
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(lesson.title)
                        .font(Theme.headlineFont())
                        .foregroundColor(Theme.textPrimary)
                    
                    Text(lesson.subtitle)
                        .font(Theme.captionFont())
                        .foregroundColor(Theme.textSecondary)
                }
                
                Spacer()
                
                if isCompleted {
                    CheckmarkIcon(size: 24, color: Theme.successGreen)
                } else {
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: 0))
                        path.addLine(to: CGPoint(x: 8, y: 10))
                        path.addLine(to: CGPoint(x: 0, y: 20))
                    }
                    .stroke(Theme.textMuted, style: StrokeStyle(lineWidth: 2, lineCap: .round))
                    .frame(width: 8, height: 20)
                }
            }
            .padding(Theme.cardPadding)
            .cardStyle()
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

struct LessonDetailView: View {
    let lesson: Lesson
    @Binding var currentSection: Int
    @Binding var currentStep: Int
    let onBack: () -> Void
    let onComplete: () -> Void
    
    var currentSectionData: LessonSection {
        lesson.sections[currentSection]
    }
    
    var currentStepData: LessonStep {
        currentSectionData.steps[currentStep]
    }
    
    var isLastStep: Bool {
        currentSection == lesson.sections.count - 1 && currentStep == currentSectionData.steps.count - 1
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(title: lesson.title, subtitle: currentSectionData.title, showBack: true, backAction: onBack)
            
            ScrollView {
                VStack(spacing: 20) {
                    // Progress
                    VStack(spacing: 8) {
                        let totalSteps = lesson.sections.reduce(0) { $0 + $1.steps.count }
                        let completedSteps = lesson.sections.prefix(currentSection).reduce(0) { $0 + $1.steps.count } + currentStep
                        ProgressBarView(progress: Double(completedSteps) / Double(totalSteps) * 100, color: Theme.iceBlue)
                        Text("Step \(completedSteps + 1) of \(totalSteps)")
                            .font(Theme.smallFont())
                            .foregroundColor(Theme.textMuted)
                    }
                    .padding(.horizontal)
                    
                    // Current Step
                    VStack(alignment: .leading, spacing: 16) {
                        if currentStepData.important {
                            HStack {
                                WarningIcon(size: 20, color: Theme.warningOrange)
                                Text("Important")
                                    .font(Theme.captionFont())
                                    .foregroundColor(Theme.warningOrange)
                            }
                        }
                        
                        Text(currentStepData.title)
                            .font(Theme.headlineFont())
                            .foregroundColor(Theme.textPrimary)
                        
                        Text(currentStepData.content)
                            .font(Theme.bodyFont())
                            .foregroundColor(Theme.textSecondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(Theme.cardPadding)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .cardStyle()
                    .padding(.horizontal)
                }
                .padding(.bottom, 100)
            }
            
            // Navigation buttons
            HStack(spacing: 16) {
                if currentSection > 0 || currentStep > 0 {
                    Button("Previous") {
                        goBack()
                    }
                    .buttonStyle(SecondaryButtonStyle())
                }
                
                Button(isLastStep ? "Complete" : "Next") {
                    if isLastStep {
                        onComplete()
                    } else {
                        goNext()
                    }
                }
                .buttonStyle(PrimaryButtonStyle(color: isLastStep ? Theme.successGreen : Theme.iceBlue))
            }
            .padding()
            .padding(.bottom, 20)
        }
        .background(Theme.backgroundGradient.ignoresSafeArea())
    }
    
    func goNext() {
        if currentStep < currentSectionData.steps.count - 1 {
            currentStep += 1
        } else if currentSection < lesson.sections.count - 1 {
            currentSection += 1
            currentStep = 0
        }
    }
    
    func goBack() {
        if currentStep > 0 {
            currentStep -= 1
        } else if currentSection > 0 {
            currentSection -= 1
            currentStep = lesson.sections[currentSection].steps.count - 1
        }
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Theme.headlineFont())
            .foregroundColor(Theme.textSecondary)
            .padding(.horizontal, 24)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: Theme.cornerRadius)
                    .stroke(Theme.textMuted, lineWidth: 1)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}
