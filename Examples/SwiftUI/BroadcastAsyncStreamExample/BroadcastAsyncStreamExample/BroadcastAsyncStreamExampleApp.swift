import SwiftUI

@main
struct BroadcastAsyncStreamExampleApp: App {

    @StateObject private var mainService: MainService

    init() {
        self._mainService = StateObject(wrappedValue: MainService())
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

}
