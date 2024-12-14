import SwiftUI

struct ContentView: View {

    private var mainService: MainService

    init(mainService: MainService) {
        self.mainService = mainService
    }

    var body: some View {
        NavigationView(content: {
            List(content: {
                NavigationLink(destination: {
                    DetailsView(mainService: mainService)
                }, label: {
                    Text("Details")
                })
                NavigationLink(destination: {
                    DetailsWithViewModelView(mainService: mainService)
                }, label: {
                    Text("Details with view model")
                })
            })
            .navigationTitle("Content")
            .navigationBarTitleDisplayMode(.inline)
        })
    }

}

#Preview {
    ContentView(mainService: MainService())
}
