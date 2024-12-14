import SwiftUI

struct DetailsView: View {

    @State private var valueText: String = ""

    private var mainService: MainService

    init(mainService: MainService) {
        self.mainService = mainService
    }

    var body: some View {
        mainView()
            .onAppear(perform: {
                updateValueText(value: mainService.value)
            })
            .task({
                await mainService.didSucceedChangeValueStream.subscribe({ (value) in
                    updateValueText(value: value)
                })
            })
    }

    private func mainView() -> some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(valueText)
        }
        .padding()
    }

    // MARK: - Private

    private func updateValueText(value: Int) {
        valueText = "Value is \(value)"
    }

}

#Preview {
    DetailsView(mainService: MainService())
}
