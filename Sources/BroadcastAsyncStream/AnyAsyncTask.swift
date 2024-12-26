import Foundation

public final class AnyAsyncTask {

    private let cancelTaskBlock: () -> Void
    private let isTaskCancelledBlock: () -> Bool

    // MARK: - Initialization

    internal init<S, E>(_ task: Task<S, E>) {
        cancelTaskBlock = { () -> Void in
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

    public func eraseToAnyTask() -> AnyAsyncTask {
        return AnyAsyncTask(self)
    }

}
