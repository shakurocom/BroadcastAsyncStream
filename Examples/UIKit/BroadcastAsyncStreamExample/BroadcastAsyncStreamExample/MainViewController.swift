import UIKit

class MainViewController: UIViewController {

    @IBOutlet private var label: UILabel!

    private var mainService: MainService = MainService()

    override func viewDidLoad() {
        super.viewDidLoad()

        mainService.didSucceedChangeValueStream.subscribe({ [weak self] (value) in
            self?.label.text = "Value is \(value)"
        })
    }


}

