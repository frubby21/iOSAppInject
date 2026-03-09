import SwiftUI

struct TodoListView: View {
    @EnvironmentObject private var viewModel: TodoViewModel

    var body: some View {
        VStack(spacing: 0) {
            List {
                ForEach(viewModel.items) { item in
                    Button {
                        viewModel.toggleCompletion(for: item)
                    } label: {
                        HStack {
                            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(item.isCompleted ? .green : .secondary)
                            Text(item.title)
                                .strikethrough(item.isCompleted, color: .secondary)
                                .foregroundColor(item.isCompleted ? .secondary : .primary)
                        }
                    }
                    .buttonStyle(.plain)
                }
                .onDelete(perform: viewModel.removeItems)
            }

            Divider()

            HStack {
                TextField("New task", text: $viewModel.newTaskTitle)
                    .textFieldStyle(.roundedBorder)

                Button {
                    viewModel.addTask()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                }
                .disabled(viewModel.newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            .padding()
            .background(.ultraThinMaterial)
        }
        .navigationTitle("To-Do List")
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TodoListView()
        }
        .environmentObject(TodoViewModel())
    }
}

