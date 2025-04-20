import SwiftUI

@main
struct RoadmapApp: App {
    @StateObject private var appData = AppData()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(appData)
        }
    }
}
