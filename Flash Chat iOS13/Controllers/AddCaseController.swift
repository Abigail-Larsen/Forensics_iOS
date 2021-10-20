import Foundation
import UIKit

class AddCaseController: UIViewController {
    
    @IBOutlet weak var caseName: UITextField!
    @IBOutlet weak var caseNumber: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("one time")
        datePicker.layer.backgroundColor = CGColor.init(red: 0.5, green: CGFloat.pi, blue: CGFloat.pi, alpha: CGFloat.pi)
//        print("caseName")
    }
    
//    @IBAction func saveCase(_ sender: UIButton) {
//        if let name = caseName.text, let number = caseNumber.text {
//            print("clicked saved button", sender)
//            
//        }
//    }
}
