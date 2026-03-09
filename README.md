## Template & Injector (SwiftUI for LiveContainer)

This is a minimal SwiftUI-based iOS "Template & Injector" app intended for use inside LiveContainer.

### Features

- **App Builder tab**: 
  - Text editor that holds a SwiftUI snippet (for reference).
  - A few simple templates (text, colored card, counter) with controls so you can see how stateful views render live.
- **Templates tab**:
  - **App Opener**: Launch other apps via URL schemes using `UIApplication.shared.open`.
  - **To-Do List**: In-memory list of tasks backed by `@StateObject` (`TodoViewModel`) so data persists for the lifetime of the process.
- **Live State tab**:
  - Dashboard that shows uptime ticks, current to-do counts, and a RAM-only scratchpad.

### Structure

- `TemplateInjectorApp.swift` – App entry point
- `Models/` – `TodoItem`, `TodoViewModel`, `LiveStateModel`
- `Views/` – `ContentView` + feature views

You can drop this source into an Xcode iOS app target (minimum iOS 16 recommended for `NavigationStack`) and wire it up to a GitHub Actions workflow that runs `xcodebuild` against your chosen scheme.

