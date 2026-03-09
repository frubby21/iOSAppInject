import SwiftUI

struct AppOpenerView: View {
    @State private var urlScheme: String = "myapp://"
    @State private var lastResultMessage: String = ""
    @State private var showAlert: Bool = false

    var body: some View {
        Form {
            Section(header: Text("Target URL Scheme")) {
                TextField("example: twitter:// or myapp://", text: $urlScheme)
                    .keyboardType(.URL)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }

            Section {
                Button {
                    openApp()
                } label: {
                    Label("Open App", systemImage: "arrow.up.right.square")
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity, alignment: .center)
            }

            if !lastResultMessage.isEmpty {
                Section(header: Text("Last Result")) {
                    Text(lastResultMessage)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("App Opener")
        .alert("Invalid URL", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please enter a valid URL scheme, like twitter:// or myapp://path.")
        }
    }

    private func openApp() {
        let trimmed = urlScheme.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let url = URL(string: trimmed) else {
            showAlert = true
            return
        }

        #if os(iOS)
        UIApplication.shared.open(url, options: [:]) { success in
            DispatchQueue.main.async {
                if success {
                    lastResultMessage = "Successfully requested open for \(trimmed)"
                } else {
                    lastResultMessage = "Failed to open \(trimmed). The app may not be installed or the scheme may be invalid."
                }
            }
        }
        #else
        lastResultMessage = "URL opening is only available on iOS."
        #endif
    }
}

struct AppOpenerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AppOpenerView()
        }
    }
}

