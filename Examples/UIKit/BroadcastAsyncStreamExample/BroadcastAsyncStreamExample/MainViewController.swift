import BroadcastAsyncStream
import UIKit

class MainViewController: UIViewController {

    @IBOutlet private var label: UILabel!

    private var mainService: MainService = MainService()

    private var subscription: AnyAsyncTask?

    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = "Value is \(mainService.value)"

        subscription = mainService.didSucceedChangeValueStream.subscribe({ [weak self] (value) in
            self?.label.text = "Value is \(value)"
        })
    }


}

