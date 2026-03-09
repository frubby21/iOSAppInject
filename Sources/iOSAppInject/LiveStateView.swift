import SwiftUI

struct LiveStateView: View {
    @EnvironmentObject private var liveState: LiveStateModel
    @EnvironmentObject private var todoViewModel: TodoViewModel

    @State private var scratchNote: String = ""

    private var uptimeInterval: TimeInterval {
        liveState.lastUpdated.timeIntervalSince(liveState.startDate)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    GroupBox("Process Lifetime (RAM-backed)") {
                        VStack(alignment: .leading, spacing: 8) {
                            labeledRow(title: "Uptime (approx.)") {
                                Text("\(uptimeInterval, specifier: "%.0f") s")
                                    .monospacedDigit()
                            }
                            labeledRow(title: "Ticks") {
                                Text("\(liveState.tickCount)")
                                    .monospacedDigit()
                            }
                            Text("These values reset when the process is killed, which matches LiveContainer's in-RAM behavior.")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                                .padding(.top, 4)
                        }
                    }

                    GroupBox("In-Memory To-Do State") {
                        VStack(alignment: .leading, spacing: 8) {
                            labeledRow(title: "Tasks in memory") {
                                Text("\(todoViewModel.items.count)")
                                    .monospacedDigit()
                            }
                            labeledRow(title: "Completed") {
                                let completed = todoViewModel.items.filter { $0.isCompleted }.count
                                Text("\(completed)")
                                    .monospacedDigit()
                            }

                            Text("Tasks are stored using @StateObject and are not written to disk. They live only as long as this process does.")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                                .padding(.top, 4)
                        }
                    }

                    GroupBox("Scratchpad (RAM only)") {
                        VStack(alignment: .leading, spacing: 8) {
                            TextEditor(text: $scratchNote)
                                .frame(minHeight: 80)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.secondary.opacity(0.2))
                                )
                            Text("This text is never persisted to disk; it will disappear when the app is restarted.")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Live State")
        }
    }

    @ViewBuilder
    private func labeledRow(title: String, value: () -> Text) -> some View {
        HStack {
            Text(title)
                .foregroundColor(.secondary)
            Spacer()
            value()
                .font(.body.weight(.medium))
        }
    }
}

struct LiveStateView_Previews: PreviewProvider {
    static var previews: some View {
        LiveStateView()
            .environmentObject(LiveStateModel())
            .environmentObject(TodoViewModel())
    }
}

