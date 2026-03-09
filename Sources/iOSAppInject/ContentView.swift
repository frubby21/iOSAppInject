import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            AppBuilderView()
                .tabItem {
                    Label("App Builder", systemImage: "hammer.fill")
                }

            TemplatesView()
                .tabItem {
                    Label("Templates", systemImage: "square.grid.2x2.fill")
                }

            LiveStateView()
                .tabItem {
                    Label("Live State", systemImage: "memorychip")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TodoViewModel())
            .environmentObject(LiveStateModel())
    }
}

