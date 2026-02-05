import SwiftUI

struct TestView: View {
    @EnvironmentObject var storage: StorageService
    @State private var isTestActive = false
    @State private var questions: [Question] = []
    @State private var currentIndex: Int = 0
    @State private var selectedOption: String?
    @State private var showResult: Bool = false
    @State private var correctCount: Int = 0
    @State private var showFinalResult: Bool = false
    @Binding var selectedTab: AppTab
    
    var body: some View {
        if showFinalResult {
            TestResultView(
                score: correctCount,
                total: questions.count,
                onRetry: { startNewTest() },
                onBack: { resetTest() }
            )
        } else if isTestActive {
            TestQuestionView(
                question: questions[currentIndex],
                currentIndex: currentIndex,
                totalQuestions: questions.count,
                selectedOption: $selectedOption,
                showResult: $showResult,
                isCorrect: selectedOption == questions[currentIndex].correctOptionId,
                onSubmit: {
                    if selectedOption == questions[currentIndex].correctOptionId {
                        correctCount += 1
                    }
                    showResult = true
                },
                onNext: {
                    if currentIndex < questions.count - 1 {
                        currentIndex += 1
                        selectedOption = nil
                        showResult = false
                    } else {
                        let result = TestResult(
                            id: UUID().uuidString,
                            date: Date(),
                            score: correctCount,
                            totalQuestions: questions.count,
                            passed: correctCount >= Int(Double(questions.count) * 0.8)
                        )
                        storage.saveTestResult(result)
                        showFinalResult = true
                    }
                },
                onBack: { resetTest() }
            )
        } else {
            testIntro
        }
    }
    
    func startNewTest() {
        questions = Array(ContentData.questions.shuffled().prefix(10))
        currentIndex = 0
        selectedOption = nil
        showResult = false
        correctCount = 0
        showFinalResult = false
        isTestActive = true
    }
    
    func resetTest() {
        isTestActive = false
        showFinalResult = false
        questions = []
        currentIndex = 0
        correctCount = 0
    }
    
    var testIntro: some View {
        ScrollView {
            VStack(spacing: 24) {
                HeaderView(title: "Test", subtitle: "Knowledge Assessment", showBack: true) {
                    selectedTab = .home
                }
                
                VStack(spacing: 20) {
                    CheckmarkIcon(size: 64, color: Theme.warningOrange)
                    
                    Text("Ready to Test?")
                        .font(Theme.titleFont())
                        .foregroundColor(Theme.textPrimary)
                    
                    Text("10 random questions about ice safety. You need 80% to pass.")
                        .font(Theme.bodyFont())
                        .foregroundColor(Theme.textSecondary)
                        .multilineTextAlignment(.center)
                }
                .padding(24)
                .cardStyle()
                .padding(.horizontal)
                
                // Previous results
                if !storage.progress.testResults.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Previous Results")
                            .font(Theme.headlineFont())
                            .foregroundColor(Theme.textPrimary)
                        
                        ForEach(storage.progress.testResults.suffix(5).reversed()) { result in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("\(result.score)/\(result.totalQuestions)")
                                        .font(Theme.headlineFont())
                                        .foregroundColor(result.passed ? Theme.successGreen : Theme.emergencyRed)
                                    Text(formatDate(result.date))
                                        .font(Theme.smallFont())
                                        .foregroundColor(Theme.textMuted)
                                }
                                Spacer()
                                Text(result.passed ? "Passed" : "Failed")
                                    .font(Theme.captionFont())
                                    .foregroundColor(result.passed ? Theme.successGreen : Theme.emergencyRed)
                            }
                            .padding(12)
                            .glassStyle()
                        }
                    }
                    .padding(.horizontal)
                }
                
                Button("Start Test") {
                    startNewTest()
                }
                .buttonStyle(PrimaryButtonStyle(color: Theme.warningOrange))
                .padding(.top, 10)
            }
            .padding(.bottom, 20)
        }
        .background(Theme.backgroundGradient.ignoresSafeArea())
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct TestQuestionView: View {
    let question: Question
    let currentIndex: Int
    let totalQuestions: Int
    @Binding var selectedOption: String?
    @Binding var showResult: Bool
    let isCorrect: Bool
    let onSubmit: () -> Void
    let onNext: () -> Void
    let onBack: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(title: "Question \(currentIndex + 1)", subtitle: "of \(totalQuestions)", showBack: true, backAction: onBack)
            
            ScrollView {
                VStack(spacing: 20) {
                    ProgressBarView(progress: Double(currentIndex) / Double(totalQuestions) * 100, color: Theme.warningOrange)
                        .padding(.horizontal)
                    
                    Text(question.text)
                        .font(Theme.headlineFont())
                        .foregroundColor(Theme.textPrimary)
                        .multilineTextAlignment(.center)
                        .padding(Theme.cardPadding)
                        .frame(maxWidth: .infinity)
                        .cardStyle()
                        .padding(.horizontal)
                    
                    VStack(spacing: 10) {
                        ForEach(question.options) { option in
                            TestOptionButton(
                                option: option,
                                isSelected: selectedOption == option.id,
                                isCorrect: option.id == question.correctOptionId,
                                showResult: showResult
                            ) {
                                if !showResult {
                                    selectedOption = option.id
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    if showResult {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(isCorrect ? "Correct!" : "Incorrect")
                                .font(Theme.headlineFont())
                                .foregroundColor(isCorrect ? Theme.successGreen : Theme.emergencyRed)
                            Text(question.explanation)
                                .font(Theme.bodyFont())
                                .foregroundColor(Theme.textSecondary)
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
            
            VStack {
                if showResult {
                    Button(currentIndex < totalQuestions - 1 ? "Next Question" : "See Results") {
                        onNext()
                    }
                    .buttonStyle(PrimaryButtonStyle(color: Theme.iceBlue))
                } else if selectedOption != nil {
                    Button("Submit") {
                        onSubmit()
                    }
                    .buttonStyle(PrimaryButtonStyle(color: Theme.warningOrange))
                }
            }
            .padding()
            .padding(.bottom, 20)
        }
        .background(Theme.backgroundGradient.ignoresSafeArea())
    }
}

struct TestOptionButton: View {
    let option: QuestionOption
    let isSelected: Bool
    let isCorrect: Bool
    let showResult: Bool
    let action: () -> Void
    
    var backgroundColor: Color {
        if showResult {
            if isCorrect { return Theme.successGreen.opacity(0.2) }
            else if isSelected { return Theme.emergencyRed.opacity(0.2) }
        }
        return isSelected ? Theme.warningOrange.opacity(0.2) : Theme.backgroundLight
    }
    
    var borderColor: Color {
        if showResult {
            if isCorrect { return Theme.successGreen }
            else if isSelected { return Theme.emergencyRed }
        }
        return isSelected ? Theme.warningOrange : Color.clear
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
                    .overlay(RoundedRectangle(cornerRadius: Theme.cornerRadius).stroke(borderColor, lineWidth: 2))
            )
        }
        .buttonStyle(ScaleButtonStyle())
        .disabled(showResult)
    }
}

struct TestResultView: View {
    let score: Int
    let total: Int
    let onRetry: () -> Void
    let onBack: () -> Void
    
    var passed: Bool { score >= Int(Double(total) * 0.8) }
    var percentage: Int { (score * 100) / total }
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            if passed {
                CheckmarkIcon(size: 80, color: Theme.successGreen)
            } else {
                EmergencyIcon(size: 80, color: Theme.emergencyRed)
            }
            
            Text(passed ? "Congratulations!" : "Keep Learning")
                .font(Theme.titleFont())
                .foregroundColor(Theme.textPrimary)
            
            Text("\(score)/\(total) correct (\(percentage)%)")
                .font(Theme.headlineFont())
                .foregroundColor(passed ? Theme.successGreen : Theme.emergencyRed)
            
            Text(passed ? "You have demonstrated solid knowledge of ice rescue safety." : "Review the lessons and try again. You need 80% to pass.")
                .font(Theme.bodyFont())
                .foregroundColor(Theme.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            
            Spacer()
            
            VStack(spacing: 12) {
                Button("Try Again") { onRetry() }
                    .buttonStyle(PrimaryButtonStyle(color: Theme.iceBlue))
                
                Button("Back to Menu") { onBack() }
                    .buttonStyle(SecondaryButtonStyle())
            }
            .padding(.bottom, 40)
        }
        .frame(maxWidth: .infinity)
        .background(Theme.backgroundGradient.ignoresSafeArea())
    }
}
