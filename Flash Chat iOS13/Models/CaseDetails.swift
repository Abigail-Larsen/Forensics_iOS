//
//  CaseDetails.swift
//  Flash Chat iOS13
//
//  Created by Abigail Thelin on 1/3/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct Case: Identifiable {
    var sender: String
    var caseName: String
    var caseNumber: String
    var caseDescription: String
    var id: Int
}

var casesTESTING = [
    Case(sender: "me", caseName: "Lehi", caseNumber: "12345", caseDescription: "Vandalism", id: 123),
    Case(sender: "George", caseName: "SLC", caseNumber: "12345", caseDescription: "Hit and Run", id: 1234)
]
