import SwiftUI

struct ContentView: View {

    @ObservedObject private var mainService: MainService

    init(mainService: MainService) {
        self.mainService = mainService
    }

    var body: some View {
        mainView()
            .task({
                mainService.didSucceedChangeQuantityOfBasketItemStream.subs
            })
    }

    private func mainView() -> some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }

}

#Preview {
    ContentView(mainService: MainService())
}
