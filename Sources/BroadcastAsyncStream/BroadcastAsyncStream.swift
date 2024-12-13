//
//
//

import Foundation

// TODO: move to library (create new)
public final class AnyAsyncTask {

    private let cancelTaskBlock: () -> Void
    private let isTaskCancelledBlock: () -> Bool

    // MARK: - Initialization

    internal init<S, E>(_ task: Task<S, E>) {
        cancelTaskBlock = {
            task.cancel()
        }
        isTaskCancelledBlock = { () -> Bool in
            return task.isCancelled
        }
    }

    deinit {
        if !isTaskCancelledBlock() {
            cancelTaskBlock()
        }
    }

    // MARK: - Public

    public func isCancelled() -> Bool {
        return isTaskCancelledBlock()
    }

    public func cancel() {
        if !isTaskCancelledBlock() {
            cancelTaskBlock()
        }
    }

}

extension Task {

    public var eraseToAnyTask: AnyAsyncTask {
        return AnyAsyncTask(self)
    }

}

@MainActor
public final class AnyBroadcastAsyncStream<Element: Sendable> {

    private let broadcastAsyncStream: BroadcastAsyncStream<Element>

    // MARK: - Initialization

    internal init(_ broadcastAsyncStream: BroadcastAsyncStream<Element>) {
        self.broadcastAsyncStream = broadcastAsyncStream
    }

    // MARK: - Public

    public func subscribe(_ onEvent: @escaping @MainActor (Element) -> Void) async {
        let stream = broadcastAsyncStream.makeAsyncStream()
        for await element in stream {
            onEvent(element)
        }
    }

    public func subscribe(_ onEvent: @escaping @MainActor (Element) -> Void) -> AnyAsyncTask {
        let asyncStream = broadcastAsyncStream.makeAsyncStream()
        return _Concurrency.Task(operation: {
            for await element in asyncStream {
                onEvent(element)
            }
            // TODO: implement
            print("TODO: implement - check finished!!!! - remove from broadcastAsyncStream by UUID from store")
        }).eraseToAnyTask
    }

    public func subscribe(store: inout [AnyAsyncTask], onEvent: @escaping @MainActor (Element) -> Void) {
        let task = subscribe(onEvent)
        store.append(task)
    }

}

@MainActor
public final class BroadcastAsyncStream<Element: Sendable> {

    private var store: [String: AsyncStream<Element>.Continuation]

    public init() {
        self.store = [:]
    }

    // MARK: - Public

    public func eraseToAnyStream() -> AnyBroadcastAsyncStream<Element> {
        return AnyBroadcastAsyncStream(self)
    }

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
