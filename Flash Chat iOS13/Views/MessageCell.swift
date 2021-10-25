import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var MessageBubble: UIView!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var caseDate: UILabel!
    @IBOutlet weak var caseNumber: UILabel!
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var caseView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        caseView.layer.borderWidth = 1
        caseView.layer.borderColor = UIColor.gray.cgColor
        caseView.layer.cornerRadius = 10
    }
}
