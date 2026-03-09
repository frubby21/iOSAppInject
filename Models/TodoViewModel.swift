import Foundation

final class TodoViewModel: ObservableObject {
    @Published var items: [TodoItem] = []
    @Published var newTaskTitle: String = ""

    func addTask() {
        let trimmed = newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        let item = TodoItem(title: trimmed)
        items.append(item)
        newTaskTitle = ""
    }

    func removeItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }

    func toggleCompletion(for item: TodoItem) {
        guard let index = items.firstIndex(of: item) else { return }
        items[index].isCompleted.toggle()
    }
}

