# DGM-Forensics

## Our Goal

The UVU Forensics Department would like to look into the possibility of Lidar technology being used to document a crime scene. Currently, 3d laser scanners are used for this purpose. These machines are very expensive and not always immediately available. First responders having an app that allows them to document a crime scene quickly and effectively could be a game-changer.

The Utah Valley University Forensics Department is in need of a more cost effective and overall efficient way of capturing a three-dimensional model of crime scenes. Currently, students have access to one MacBook Pro, one iPad Pro, one iPhone 12, and one iPhone 12 Pro Max. All mobile devices have the technology necessary for LiDar capture, and the MacBook Pro contains Xcode to develop LiDar applications with Swift UI. There currently exists a prototype built in Figma which contains a style guide, initial designs, wireframes, low-fidelity surface comps, and mid-fidelity surface comps/prototype. In addition to these assets, LiDar captures have been made on each of the mobile devices using three applications recommended by Continuum (3D Scanner App, Canvas, and Matterport).  The proposed solution for the client is to take the prototype that is in phase one (design) and bring it over phases two (testing) and three (development). This means that the UI, the previous group formulated, will be refreshed and the light prototype will also be remastered and renovated as to match the updated UI. The forensics group will be responsible for a journey map as to show us exactly what we need to implement into the UI and prototype so that we can then move onto the testing and development phases. Our objective is to exploit this technology by building an app for enforcement personnel as to eliminate the expensive and heavy equipment used during crime scenes in replacement for an iPhone or iPad with Lidar technology. Furthermore, being able to document the scene easily by using this app. We are only focused with finalizing the functionality of the app with user testing, prototyping and then transferring into the beginning of development.

# Important Links

![Figma](https://www.figma.com/file/Bz728RX2a5lp9skQ6t4L7f/Forensics-App-Lidar_Jordan-Taylor_Spencer-Wright?node-id=0%3A1)


# Constants

```
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
        static let bodyField = "body"
        static let dateField = "date"
        static let id = "id"
    }
}

```

![End Banner](Documentation/readme-end-banner.png)
