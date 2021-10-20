import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet var addIcon: [UIImageView]!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    @IBOutlet weak var AddCaseBtn: UIImageView!
    let db = Firestore.firestore()
    
    var messages: [Cases] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        title = "My Cases"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]; navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.hidesBackButton = true
        loadMessages()
    }
//    
//    @IBAction func AddCase(_ sender: UIButton) {
////        let vc = AddCaseController()
//        
//        self.performSegue(withIdentifier: "ChatViewController", sender: self)
//    }
    
    func loadMessages () {
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener{(QuerySnapshot, error) in
            self.messages = []
            if let e = error {
                print("Error retrieving data from firestore", e)
            } else {
                if let snapshotDocuments = QuerySnapshot?.documents{
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        print(data)
                        if let sender = data[K.FStore.senderField] as? String,  let message = data[K.FStore.bodyField] as? String, let id = data[K.FStore.id] as? String{
                            let newMessage = Cases(sender: sender, body: message, id: id)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func logOutPress(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out", signOutError)
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.bodyField: messageBody,
                K.FStore.senderField: messageSender,
                K.FStore.dateField: Date().timeIntervalSince1970,
                K.FStore.id: "123456789"
            ]) { (error) in
                if let e = error {
                    print("ERROR", e)
                } else {
                    print("Succesfully saved data")
                    self.messageTextfield.text = ""
                }

            }
        }
    }
}


extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.projectTitle?.text = messages[indexPath.row].body
        return cell
    }
}



extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = CaseDetailsController()
                vc.caseNumber = messages[indexPath.row].id
                vc.caseName = messages[indexPath.row].body
                print("row: \( messages[indexPath.row])")
                navigationController?.pushViewController(vc, animated: false)
    }

}
