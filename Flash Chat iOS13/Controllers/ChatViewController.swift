//import UIKit
//import Firebase
//
//class ChatViewController: UIViewController {
//
//    @IBOutlet var addIcon: [UIImageView]!
//    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var messageTextfield: UITextField!
//    @IBOutlet weak var AddCaseBtn: UIImageView!
//    let db = Firestore.firestore()
//
//    var casesList: [Case] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
//        tableView.dataSource = self
//        tableView.delegate = self
//        title = "My Cases"
//        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]; navigationController?.navigationBar.titleTextAttributes = textAttributes
//        navigationItem.hidesBackButton = true
//        loadCases()
//    }
//
//    func loadCases () {
//        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener{(QuerySnapshot, error) in
//            self.casesList = []
//            if let e = error {
//                print("Error retrieving data from firestore", e)
//            } else {
//                if let snapshotDocuments = QuerySnapshot?.documents{
//                    for doc in snapshotDocuments {
//                        let data = doc.data()
//                        print(data)
//                        if let sender = data[K.FStore.senderField] as? String, let caseName = data[K.FStore.caseName] as? String, let caseNumber = data[K.FStore.caseNumber] as? String{
//
//                            print(data)
//                            let newCase = Case(sender: sender, caseName: caseName, caseNumber: caseNumber, caseDescription: "description", id: 123)
//                            self.casesList.append(newCase)
//
//                            DispatchQueue.main.async {
//                                self.tableView.reloadData()
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//
//    @IBAction func logOutPress(_ sender: Any) {
//        let firebaseAuth = Auth.auth()
//        do {
//            try firebaseAuth.signOut()
//            navigationController?.popToRootViewController(animated: true)
//        } catch let signOutError as NSError {
//            print("Error signing out", signOutError)
//        }
//    }
//}
//
//
//extension ChatViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return casesList.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
//        cell.projectTitle?.text = casesList[indexPath.row].caseName
//        cell.caseNumber?.text = casesList[indexPath.row].caseNumber
//        cell.caseDate?.text = ""
//        return cell
//    }
//}
//
//
//
//extension ChatViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("row: \( casesList[indexPath.row])")
////        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "CaseDetailsController") as! CaseDetailsController
//
////        secondViewController.caseNumber = casesList[indexPath.row].caseNumber
//        secondViewController.caseName = casesList[indexPath.row].caseName
////
////        self.navigationController?.pushViewController(secondViewController, animated: true)
//    }
//
//}
