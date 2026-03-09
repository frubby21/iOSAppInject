import SwiftUI

@main
struct TemplateInjectorApp: App {
    @StateObject private var todoViewModel = TodoViewModel()
    @StateObject private var liveStateModel = LiveStateModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(todoViewModel)
                .environmentObject(liveStateModel)
        }
    }
}

