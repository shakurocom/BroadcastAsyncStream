import BroadcastAsyncStream
import SwiftUI

@MainActor
final class DetailsViewModel: ObservableObject {

    @Published var valueText: String

    private var subscriptionTasks: [AnyAsyncTask] = []

    init(mainService: MainService) {
        valueText = "Value is \(mainService.value)"
        mainService.didSucceedChangeValueStream.subscribe(store: &subscriptionTasks, onEvent: { [weak self] (value) in
            self?.valueText = "Value is \(value)"
        })
    }

    deinit {
        print("DetailsViewModel deinit")
    }

}
