import SwiftUI

struct PracticeView: View {
    @EnvironmentObject var storage: StorageService
    @State private var selectedScenario: Scenario?
    @State private var currentStep: Int = 0
    @State private var selectedOption: String?
    @State private var showResult: Bool = false
    @State private var correctAnswers: Int = 0
    @Binding var selectedTab: AppTab
    
    var body: some View {
        if let scenario = selectedScenario {
            ScenarioDetailView(
                scenario: scenario,
                currentStep: $currentStep,
                selectedOption: $selectedOption,
                showResult: $showResult,
                correctAnswers: $correctAnswers,
                onBack: { resetAndClose() },
                onComplete: {
                    if correctAnswers == scenario.steps.count {
                        storage.markScenarioCompleted(scenario.id)
                    }
                    resetAndClose()
                }
            )
        } else {
            scenariosList
        }
    }
    
    func resetAndClose() {
        selectedScenario = nil
        currentStep = 0
        selectedOption = nil
        showResult = false
        correctAnswers = 0
    }
    
    var scenariosList: some View {
        ScrollView {
            VStack(spacing: 16) {
                HeaderView(title: "Practice", subtitle: "Interactive Simulations", showBack: true) {
                    selectedTab = .home
                }
                
                ForEach(ContentData.scenarios) { scenario in
                    ScenarioCard(
                        scenario: scenario,
                        isCompleted: storage.progress.completedScenarios.contains(scenario.id)
                    ) {
                        selectedScenario = scenario
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 20)
        }
        .background(Theme.backgroundGradient.ignoresSafeArea())
    }
}

struct ScenarioCard: View {
    let scenario: Scenario
    let isCompleted: Bool
    let action: () -> Void
    
    var icon: some View {
        Group {
            switch scenario.icon {
            case "target": TargetIcon(size: 36, color: Theme.iceBlue)
            case "emergency": EmergencyIcon(size: 36, color: Theme.emergencyRed)
            case "warning": WarningIcon(size: 36, color: Theme.warningOrange)
            case "chart": ChartIcon(size: 36, color: Theme.iceBlue)
            case "info": InfoIcon(size: 36, color: Theme.iceBlue)
            case "gear": GearIcon(size: 36, color: Theme.textSecondary)
            case "snowflake": SnowflakeIcon(size: 36, color: Theme.iceBlueLight)
            default: TargetIcon(size: 36, color: Theme.iceBlue)
            }
        }
    }
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    icon
                    Spacer()
                    DifficultyBadge(difficulty: scenario.difficulty)
                    if isCompleted {
                        CheckmarkIcon(size: 24, color: Theme.successGreen)
                    }
                }
                
                Text(scenario.title)
                    .font(Theme.headlineFont())
                    .foregroundColor(Theme.textPrimary)
                
                Text(scenario.description)
                    .font(Theme.captionFont())
                    .foregroundColor(Theme.textSecondary)
            }
            .padding(Theme.cardPadding)
            .frame(maxWidth: .infinity, alignment: .leading)
            .cardStyle()
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

struct ScenarioDetailView: View {
    let scenario: Scenario
    @Binding var currentStep: Int
    @Binding var selectedOption: String?
    @Binding var showResult: Bool
    @Binding var correctAnswers: Int
    let onBack: () -> Void
    let onComplete: () -> Void
    
    var currentStepData: ScenarioStep {
        scenario.steps[currentStep]
    }
    
    var isCorrect: Bool {
        selectedOption == currentStepData.correctOptionId
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(title: scenario.title, subtitle: "Step \(currentStep + 1) of \(scenario.steps.count)", showBack: true, backAction: onBack)
            
            ScrollView {
                VStack(spacing: 20) {
                    // Progress
                    ProgressBarView(progress: Double(currentStep) / Double(scenario.steps.count) * 100, color: Theme.iceBlue)
                        .padding(.horizontal)
                    
                    // Situation
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Situation")
                            .font(Theme.captionFont())
                            .foregroundColor(Theme.iceBlue)
                        
                        Text(currentStepData.situation)
                            .font(Theme.bodyFont())
                            .foregroundColor(Theme.textPrimary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(Theme.cardPadding)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .cardStyle()
                    .padding(.horizontal)
                    
                    // Options
                    VStack(spacing: 10) {
                        ForEach(currentStepData.options) { option in
                            OptionButton(
                                option: option,
                                isSelected: selectedOption == option.id,
                                isCorrect: option.id == currentStepData.correctOptionId,
                                showResult: showResult
                            ) {
                                if !showResult {
                                    selectedOption = option.id
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // Result explanation
                    if showResult {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                if isCorrect {
                                    CheckmarkIcon(size: 24, color: Theme.successGreen)
                                    Text("Correct!")
                                        .font(Theme.headlineFont())
                                        .foregroundColor(Theme.successGreen)
                                } else {
                                    EmergencyIcon(size: 24, color: Theme.emergencyRed)
                                    Text("Not quite")
                                        .font(Theme.headlineFont())
                                        .foregroundColor(Theme.emergencyRed)
                                }
                            }
                            
                            Text(currentStepData.explanation)
                                .font(Theme.bodyFont())
                                .foregroundColor(Theme.textSecondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(Theme.cardPadding)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: Theme.cornerRadius)
                                .fill(isCorrect ? Theme.successGreen.opacity(0.15) : Theme.emergencyRed.opacity(0.15))
                        )
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom, 100)
            }
            
            // Action button
            VStack {
                if showResult {
                    Button(currentStep < scenario.steps.count - 1 ? "Next" : "Finish") {
                        if currentStep < scenario.steps.count - 1 {
                            currentStep += 1
                            selectedOption = nil
                            showResult = false
                        } else {
                            onComplete()
                        }
                    }
                    .buttonStyle(PrimaryButtonStyle(color: Theme.iceBlue))
                } else if selectedOption != nil {
                    Button("Submit Answer") {
                        if isCorrect {
                            correctAnswers += 1
                        }
                        showResult = true
                    }
                    .buttonStyle(PrimaryButtonStyle(color: Theme.successGreen))
                }
            }
            .padding()
            .background(Theme.backgroundDark)
        }
        .background(Theme.backgroundGradient.ignoresSafeArea())
    }
}

struct OptionButton: View {
    let option: ScenarioOption
    let isSelected: Bool
    let isCorrect: Bool
    let showResult: Bool
    let action: () -> Void
    
    var backgroundColor: Color {
        if showResult {
            if isCorrect {
                return Theme.successGreen.opacity(0.2)
            } else if isSelected {
                return Theme.emergencyRed.opacity(0.2)
            }
        }
        return isSelected ? Theme.iceBlue.opacity(0.2) : Theme.backgroundLight
    }
    
    var borderColor: Color {
        if showResult {
            if isCorrect {
                return Theme.successGreen
            } else if isSelected {
                return Theme.emergencyRed
            }
        }
        return isSelected ? Theme.iceBlue : Color.clear
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(option.text)
                    .font(Theme.bodyFont())
                    .foregroundColor(Theme.textPrimary)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                if showResult && isCorrect {
                    CheckmarkIcon(size: 20, color: Theme.successGreen)
                }
            }
            .padding(Theme.cardPadding)
            .background(
                RoundedRectangle(cornerRadius: Theme.cornerRadius)
                    .fill(backgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: Theme.cornerRadius)
                            .stroke(borderColor, lineWidth: 2)
                    )
            )
        }
        .buttonStyle(ScaleButtonStyle())
        .disabled(showResult)
    }
}
