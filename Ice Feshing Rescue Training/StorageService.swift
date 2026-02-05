import Foundation

class StorageService: ObservableObject {
    static let shared = StorageService()
    
    private let progressKey = "userProgress"
    private let checklistKey = "checkedEquipment"
    
    @Published var progress: UserProgress {
        didSet { saveProgress() }
    }
    
    @Published var checkedEquipment: Set<String> {
        didSet { saveChecklist() }
    }
    
    private init() {
        if let data = UserDefaults.standard.data(forKey: progressKey),
           let decoded = try? JSONDecoder().decode(UserProgress.self, from: data) {
            progress = decoded
        } else {
            progress = UserProgress()
        }
        
        if let items = UserDefaults.standard.stringArray(forKey: checklistKey) {
            checkedEquipment = Set(items)
        } else {
            checkedEquipment = []
        }
    }
    
    private func saveProgress() {
        if let encoded = try? JSONEncoder().encode(progress) {
            UserDefaults.standard.set(encoded, forKey: progressKey)
        }
    }
    
    private func saveChecklist() {
        UserDefaults.standard.set(Array(checkedEquipment), forKey: checklistKey)
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
    
    // MARK: - Checklist Methods
    func toggleEquipment(_ itemId: String) {
        if checkedEquipment.contains(itemId) {
            checkedEquipment.remove(itemId)
        } else {
            checkedEquipment.insert(itemId)
        }
    }
    
    func resetChecklist() {
        checkedEquipment = []
    }
}
