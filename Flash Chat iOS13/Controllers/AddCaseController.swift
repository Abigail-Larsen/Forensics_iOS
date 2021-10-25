import Foundation
import UIKit
import Firebase

class AddCaseController: UIViewController {
    
    @IBOutlet weak var caseNumber: UITextField!
    @IBOutlet weak var caseName: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.layer.backgroundColor = CGColor.init(red: 0.5, green: CGFloat.pi, blue: CGFloat.pi, alpha: CGFloat.pi)
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let name = caseName.text, let number = caseNumber.text, let messageSender = Auth.auth().currentUser?.email {
                db.collection(K.FStore.collectionName).addDocument(data: [
                    K.FStore.caseName: name,
                    K.FStore.caseNumber: number,
                    K.FStore.senderField: messageSender,
                    K.FStore.dateField: Date().timeIntervalSince1970,
                ]) { (error) in
                    if let e = error {
                        print("ERROR", e)
                    } else {
                        print("Succesfully saved data")
                        self.caseName.text = ""
                        self.caseNumber.text = ""
                    }

                }
            }
        
    }
}
