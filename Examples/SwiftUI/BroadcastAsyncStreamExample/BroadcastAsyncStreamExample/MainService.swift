import Combine
import BroadcastAsyncStream

@MainActor
final class MainService: ObservableObject {

    internal var didSucceedChangeQuantityOfBasketItemStream: AsyncStream<Void> { didSucceedChangeQuantityOfBasketItem.makeAsyncStream() }

    private var didSucceedChangeQuantityOfBasketItem = BroadcastAsyncStream<Void>()

}

