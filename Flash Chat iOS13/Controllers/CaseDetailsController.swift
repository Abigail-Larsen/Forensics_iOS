import Foundation
import UIKit

class CaseDetailsController: UIViewController {
    @IBOutlet weak var caseTitle: UILabel!
    
    var caseNumber = ""
    var caseName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Case #" + caseNumber
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]; navigationController?.navigationBar.titleTextAttributes = textAttributes

//        caseTitle?.text = caseName
        print(caseName)
    }
}
