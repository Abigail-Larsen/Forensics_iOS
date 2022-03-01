//////
//////  CoachingOverlay.swift
//////  Flash Chat iOS13
//////
//////  Created by Abigail Thelin on 10/27/21.
//////  Copyright © 2021 Angela Yu. All rights reserved.
//////
////
//import Foundation
//import UIKit
//import ARKit
//
//extension ARView: ARCoachingOverlayViewDelegate {
//
//    func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) {
////        scanButton.isHidden = true
//    }
//
//    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
////        scanButton.isHidden = false
//    }
//
//    func setupCoachingOverlay() {
////         Set up coaching view
//        print("SETTING UP COACHING OVERLAY")
//        coachingOverlay.session = arView.session
//        coachingOverlay.delegate = self
//
//        coachingOverlay.translatesAutoresizingMaskIntoConstraints = false
//        arView.addSubview(coachingOverlay)
//
//        NSLayoutConstraint.activate([
//            coachingOverlay.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            coachingOverlay.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            coachingOverlay.widthAnchor.constraint(equalTo: view.widthAnchor),
//            coachingOverlay.heightAnchor.constraint(equalTo: view.heightAnchor)
//        ])
//    }
//}
