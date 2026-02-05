import Foundation

class StorageService: ObservableObject {
    static let shared = StorageService()
    
    private let progressKey = "userProgress"
    
    @Published var progress: UserProgress {
        didSet { saveProgress() }
    }
    
    private init() {
        if let data = UserDefaults.standard.data(forKey: progressKey),
           let decoded = try? JSONDecoder().decode(UserProgress.self, from: data) {
            progress = decoded
        } else {
            progress = UserProgress()
        }
    }
    
    private func saveProgress() {
        if let encoded = try? JSONEncoder().encode(progress) {
            UserDefaults.standard.set(encoded, forKey: progressKey)
        }
    }
    
    func markLessonCompleted(_ lessonId: String) {
        progress.completedLessons.insert(lessonId)
        updateLevel()
    }
    
    func markScenarioCompleted(_ scenarioId: String) {
        progress.completedScenarios.insert(scenarioId)
        progress.scenariosPassed = progress.completedScenarios.count
        updateLevel()
    }
    
    func saveTestResult(_ result: TestResult) {
        progress.testResults.append(result)
        if result.passed { progress.totalScore += result.score }
        updateLevel()
    }
    
    private func updateLevel() {
        let done = progress.completedLessons.count + progress.completedScenarios.count
        let tests = progress.testResults.filter { $0.passed }.count
        if done >= 12 && tests >= 3 { progress.knowledgeLevel = .expert }
        else if done >= 8 && tests >= 2 { progress.knowledgeLevel = .advanced }
        else if done >= 4 || tests >= 1 { progress.knowledgeLevel = .intermediate }
        else { progress.knowledgeLevel = .beginner }
    }
    
    func resetProgress() { progress = UserProgress() }
}
