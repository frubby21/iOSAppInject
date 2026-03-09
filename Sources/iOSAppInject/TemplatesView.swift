import SwiftUI

struct TemplatesView: View {
    private enum Template: String, CaseIterable, Identifiable {
        case appOpener = "App Opener"
        case todoList = "To-Do List"

        var id: String { rawValue }
        var systemImage: String {
            switch self {
            case .appOpener: return "link"
            case .todoList: return "checklist"
            }
        }
        var description: String {
            switch self {
            case .appOpener:
                return "Launch other apps via URL schemes."
            case .todoList:
                return "A simple in-memory task list."
            }
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(Template.allCases) { template in
                    NavigationLink(value: template) {
                        HStack(spacing: 12) {
                            Image(systemName: template.systemImage)
                                .font(.title3)
                                .frame(width: 32, height: 32)
                                .foregroundColor(.accentColor)

                            VStack(alignment: .leading, spacing: 4) {
                                Text(template.rawValue)
                                    .font(.headline)
                                Text(template.description)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationDestination(for: Template.self) { template in
                switch template {
                case .appOpener:
                    AppOpenerView()
                case .todoList:
                    TodoListView()
                }
            }
            .navigationTitle("Templates")
        }
    }
}

struct TemplatesView_Previews: PreviewProvider {
    static var previews: some View {
        TemplatesView()
            .environmentObject(TodoViewModel())
    }
}

