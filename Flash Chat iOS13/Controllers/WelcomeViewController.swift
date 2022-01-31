import UIKit
import CLTypingLabel
import SwiftUI

class WelcomeViewController: UIViewController {

//    @IBOutlet weak var SwiftUILoginBtn: UIButton!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var titleLabel: CLTypingLabel!
    @IBOutlet weak var welcomeLabel: CLTypingLabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        logInBtn.layer.cornerRadius = 7
        logInBtn.backgroundColor = UIColor.clear
        logInBtn.layer.borderColor = UIColor(red: 74/255, green: 218/255, blue: 163/225, alpha: 1).cgColor
        
        logInBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
    }

    @IBAction func SwiftUILogin(_ sender: UIButton) {
        let hostingController = UIHostingController(rootView: SwiftUILoginView())
        navigationController?.pushViewController(hostingController, animated: true)
    }

}
