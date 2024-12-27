import Foundation

@MainActor
public final class BroadcastAsyncStream<Element> {

    private var store: [String: AsyncStream<Element>.Continuation]

    // MARK: - Initialization

    public init() {
        self.store = [:]
    }

    // MARK: - Public

    public func send(_ element: Element) {
        store.forEach({ $1.yield(element) })
    }

    public func finish() {
        store.forEach({ $1.finish() })
    }

    public func makeAsyncStream() -> AsyncStream<Element> {
        let (stream, continuation) = AsyncStream<Element>.makeStream()
        let key = UUID().uuidString
        store[key] = continuation
        continuation.onTermination = { [weak self] (_) in
            _Concurrency.Task(operation: { @MainActor [weak self] in
                self?.store.removeValue(forKey: key)
            })
        }
        return stream
    }

}

@MainActor
extension AsyncStream {

    // MARK: - Public

    public func subscribe(_ onEvent: @escaping @MainActor (Element) -> Void) async {
        for await element in self {
            onEvent(element)
        }
    }

    public func subscribe(_ onEvent: @escaping @MainActor (Element) -> Void) -> AnyAsyncTask {
        let task = _Concurrency.Task(operation: {
            for await element in self {
                onEvent(element)
            }
        })
        return task.eraseToAnyTask()
    }

    public func subscribe(store: inout [AnyAsyncTask], onEvent: @escaping @MainActor (Element) -> Void) {
        let task = subscribe(onEvent)
        store.append(task)
    }

}
