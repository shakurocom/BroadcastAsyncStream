import Combine
import BroadcastAsyncStream

@MainActor
final class MainService: ObservableObject {

    internal var didSucceedChangeValueStream: AsyncStream<Int> { didSucceedChangeValue.makeAsyncStream() }

    private var didSucceedChangeValue = BroadcastAsyncStream<Int>()

    private var increaseValueTask: AnyAsyncTask?

    var value: Int = 0

    init() {
        increaseValue()
    }

    private func increaseValue() {
        increaseValueTask = Task(operation: { @MainActor [weak self] in
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            self?.value += 1
            self?.didSucceedChangeValue.send(self?.value ?? 0)
            self?.increaseValue()
        }).eraseToAnyTask
    }

}

