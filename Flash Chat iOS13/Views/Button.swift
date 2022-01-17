//
//  Button.swift
//  Flash Chat iOS13
//
//  Created by Abigail Thelin on 11/9/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

class ButtonView: UIViewController {
    @IBOutlet var roundedCornerButton: UIButton!
    private func updateAppearance() {
        roundedCornerButton.layer.cornerRadius = 10
        roundedCornerButton.setTitleColor(UIColor.systemPink, for: UIControl.State.normal)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        roundedCornerButton.layer.cornerRadius = 9
        roundedCornerButton.setTitleColor(UIColor.systemPink, for: UIControl.State.normal)
    }
}
