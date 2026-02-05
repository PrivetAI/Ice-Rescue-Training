import SwiftUI

@main
struct IceRescueTrainingApp: App {
    @StateObject private var storage = StorageService.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(storage)
                .preferredColorScheme(.dark)
        }
    }
}
