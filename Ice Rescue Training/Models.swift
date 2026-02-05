import Foundation

// MARK: - Lesson Model
struct Lesson: Identifiable, Codable {
    let id: String
    let title: String
    let subtitle: String
    let icon: String
    let sections: [LessonSection]
    
    var totalSteps: Int {
        sections.reduce(0) { $0 + $1.steps.count }
    }
}

struct LessonSection: Identifiable, Codable {
    let id: String
    let title: String
    let steps: [LessonStep]
}

struct LessonStep: Identifiable, Codable {
    let id: String
    let title: String
    let content: String
    let important: Bool
}

// MARK: - Scenario Model
struct Scenario: Identifiable, Codable {
    let id: String
    let title: String
    let description: String
    let icon: String
    let difficulty: Difficulty
    let steps: [ScenarioStep]
    
    enum Difficulty: String, Codable {
        case easy = "Easy"
        case medium = "Medium"
        case hard = "Hard"
        
        var color: String {
            switch self {
            case .easy: return "green"
            case .medium: return "orange"
            case .hard: return "red"
            }
        }
    }
}

struct ScenarioStep: Identifiable, Codable {
    let id: String
    let situation: String
    let options: [ScenarioOption]
    let correctOptionId: String
    let explanation: String
}

struct ScenarioOption: Identifiable, Codable {
    let id: String
    let text: String
}

// MARK: - Question Model
struct Question: Identifiable, Codable {
    let id: String
    let text: String
    let options: [QuestionOption]
    let correctOptionId: String
    let explanation: String
    let category: String
}

struct QuestionOption: Identifiable, Codable {
    let id: String
    let text: String
}

// MARK: - User Progress Model
struct UserProgress: Codable {
    var completedLessons: Set<String>
    var completedScenarios: Set<String>
    var lessonProgress: [String: Int] // lessonId: currentStep
    var scenarioProgress: [String: Int] // scenarioId: currentStep
    var testResults: [TestResult]
    var totalScore: Int
    var scenariosPassed: Int
    var knowledgeLevel: KnowledgeLevel
    
    init() {
        completedLessons = []
        completedScenarios = []
        lessonProgress = [:]
        scenarioProgress = [:]
        testResults = []
        totalScore = 0
        scenariosPassed = 0
        knowledgeLevel = .beginner
    }
    
    var overallProgress: Double {
        let totalItems = 14 // 6 lessons + 8 scenarios
        let completed = completedLessons.count + completedScenarios.count
        return Double(completed) / Double(totalItems) * 100
    }
    
    enum KnowledgeLevel: String, Codable {
        case beginner = "Beginner"
        case intermediate = "Intermediate"
        case advanced = "Advanced"
        case expert = "Expert"
    }
}

struct TestResult: Identifiable, Codable {
    let id: String
    let date: Date
    let score: Int
    let totalQuestions: Int
    let passed: Bool
    
    var percentage: Int {
        guard totalQuestions > 0 else { return 0 }
        return (score * 100) / totalQuestions
    }
}

// MARK: - Emergency Info Model
struct EmergencyStep: Identifiable {
    let id: String
    let stepNumber: Int
    let title: String
    let description: String
    let icon: String
    let isWarning: Bool
}

struct HypothermiaSign: Identifiable {
    let id: String
    let stage: String
    let signs: [String]
    let temperature: String
    let severity: Severity
    
    enum Severity: String {
        case mild = "Mild"
        case moderate = "Moderate"
        case severe = "Severe"
    }
}
