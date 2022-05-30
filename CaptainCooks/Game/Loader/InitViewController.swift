

import UIKit

class InitViewController: BaseVC {
    
    @IBOutlet weak var loaderProgressBar: LoaderProgressBar!
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkWithChecker()
        makeSequence()
    }

    private func makeSequence() {
        var i = 0

        let numbers = LoaderSequence()
        for number in numbers {
            i += 1
            loaderProgressBar.progress = number
            if i == 10 { break }
        }
    }
    
    private func checkWithChecker() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.openGame()
        })
    }

    private func openGame() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
}
