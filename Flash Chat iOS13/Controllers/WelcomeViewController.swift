import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var titleLabel: CLTypingLabel!
    @IBOutlet weak var welcomeLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logInBtn.layer.cornerRadius = 10
        logInBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
    }
    

}
