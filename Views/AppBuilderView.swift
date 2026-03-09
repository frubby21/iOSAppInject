import SwiftUI

/// A lightweight "template & injector" that lets you play with
/// small SwiftUI view snippets in a safe, sandboxed way.
///
/// This is not a full Swift compiler; instead, it offers a set of
/// simple presets and lets you bind text/values into them so you can
/// see how they render live in LiveContainer.
struct AppBuilderView: View {
    enum SnippetTemplate: String, CaseIterable, Identifiable {
        case simpleText = "Simple Text"
        case coloredCard = "Colored Card"
        case counter = "Counter"

        var id: String { rawValue }
    }

    @State private var selectedTemplate: SnippetTemplate = .simpleText
    @State private var sourceCode: String = AppBuilderView.defaultSource(for: .simpleText)
    @State private var previewText: String = "Hello, LiveContainer!"
    @State private var selectedColor: Color = .blue
    @State private var counterValue: Int = 0

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                // Template picker
                Picker("Template", selection: $selectedTemplate) {
                    ForEach(SnippetTemplate.allCases) { template in
                        Text(template.rawValue).tag(template)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: selectedTemplate) { _, newValue in
                    sourceCode = Self.defaultSource(for: newValue)
                }

                // "Injected" Swift source (text only – for reference)
                GroupBox("Injected Swift Snippet") {
                    TextEditor(text: $sourceCode)
                        .font(.system(.footnote, design: .monospaced))
                        .frame(minHeight: 140)
                }

                // Simple parameter controls backing the preview below
                parameterControls

                Divider()

                // Live Preview area – this is what your snippet "represents"
                GroupBox("Live Preview") {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemBackground))
                            .shadow(radius: 3)

                        previewView
                            .padding()
                    }
                    .frame(maxWidth: .infinity, minHeight: 180)
                }
            }
            .padding()
            .navigationTitle("App Builder")
        }
    }

    @ViewBuilder
    private var parameterControls: some View {
        switch selectedTemplate {
        case .simpleText:
            TextField("Preview text", text: $previewText)
                .textFieldStyle(.roundedBorder)
        case .coloredCard:
            VStack(alignment: .leading, spacing: 8) {
                Text("Card Title")
                TextField("Title", text: $previewText)
                    .textFieldStyle(.roundedBorder)

                Text("Accent Color")
                HStack {
                    colorCircle(.blue)
                    colorCircle(.green)
                    colorCircle(.orange)
                    colorCircle(.pink)
                }
            }
        case .counter:
            HStack {
                Button("-") {
                    counterValue = max(0, counterValue - 1)
                }
                .buttonStyle(.bordered)

                Text("\(counterValue)")
                    .font(.title2)
                    .monospacedDigit()
                    .frame(minWidth: 60)

                Button("+") {
                    counterValue += 1
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }

    @ViewBuilder
    private var previewView: some View {
        switch selectedTemplate {
        case .simpleText:
            Text(previewText)
                .font(.title3)
        case .coloredCard:
            VStack(spacing: 8) {
                Text(previewText.isEmpty ? "Card Title" : previewText)
                    .font(.headline)
                Text("This content lives only in memory.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(selectedColor.opacity(0.12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(selectedColor, lineWidth: 1)
            )
            .cornerRadius(12)
        case .counter:
            VStack(spacing: 12) {
                Text("Live Counter")
                    .font(.headline)
                Text("\(counterValue)")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .monospacedDigit()
                Text("This is a simple in-RAM stateful view.")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
    }

    private func colorCircle(_ color: Color) -> some View {
        Circle()
            .fill(color)
            .frame(width: 26, height: 26)
            .overlay(
                Circle()
                    .stroke(Color.primary.opacity(selectedColor == color ? 0.8 : 0.15), lineWidth: 2)
            )
            .onTapGesture {
                selectedColor = color
            }
    }

    private static func defaultSource(for template: SnippetTemplate) -> String {
        switch template {
        case .simpleText:
            return """
            struct SimpleTextView: View {
                var body: some View {
                    Text("Hello, LiveContainer!")
                        .font(.title)
                }
            }
            """
        case .coloredCard:
            return """
            struct ColoredCardView: View {
                var title: String

                var body: some View {
                    VStack {
                        Text(title)
                            .font(.headline)
                        Text("Card content goes here")
                            .font(.subheadline)
                    }
                    .padding()
                    .background(.blue.opacity(0.1))
                    .cornerRadius(12)
                }
            }
            """
        case .counter:
            return """
            struct CounterView: View {
                @State private var count = 0

                var body: some View {
                    VStack {
                        Text("Count: \\(count)")
                        Button("Increment") {
                            count += 1
                        }
                    }
                }
            }
            """
        }
    }
}

struct AppBuilderView_Previews: PreviewProvider {
    static var previews: some View {
        AppBuilderView()
    }
}

