import Foundation
import UIKit
import Firebase

class CaseDetailsController: UIViewController {
    
    @IBOutlet weak var caseTitleUI: UILabel!
    var caseNumber = ""
    var caseName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Case #" + caseNumber
        caseTitleUI.text = caseName
        print("shit", caseNumber, caseName)
    }
}
