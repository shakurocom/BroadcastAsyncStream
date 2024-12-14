import SwiftUI

struct DetailsWithViewModelView: View {

    @StateObject private var viewModel: DetailsViewModel

    init(mainService: MainService) {
        self._viewModel = StateObject(wrappedValue: DetailsViewModel(mainService: mainService))
    }

    var body: some View {
        mainView()
    }

    private func mainView() -> some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(viewModel.valueText)
        }
        .padding()
    }

}

#Preview {
    DetailsWithViewModelView(mainService: MainService())
}
