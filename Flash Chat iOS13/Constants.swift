struct K {
    static let appName = "DGM Forensics"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let loginSegue = "LoginToForensics"
    static let caseDetails = "CaseDetails"
    let activeCaseNumber = ""
    
    struct BrandColors {
        static let gold = "BrandGold"
    }
    
    struct FStore {
        static let collectionName = "cases"
        static let senderField = "sender"
        static let caseName = "caseName"
        static let caseNumber = "caseNumber"
        static let dateField = "date"
    }
    
    struct FStoreObjs {
        static let collectionName = "meshObjects"
        static let senderField = "sender"
        static let caseNumber = "caseNumber"
        static let mesh = "mesh"
    }
}
//bodyField
