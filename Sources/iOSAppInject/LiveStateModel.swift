import Foundation
import Combine

final class LiveStateModel: ObservableObject {
    @Published var startDate: Date = Date()
    @Published var lastUpdated: Date = Date()
    @Published var tickCount: Int = 0
    @Published var inMemoryNote: String = "This text only lives in RAM."

    private var timer: AnyCancellable?

    init() {
        timer = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                self.tickCount += 1
                self.lastUpdated = Date()
            }
    }
}

