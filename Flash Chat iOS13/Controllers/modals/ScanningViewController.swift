//
//  ScanningViewController.swift
//  Flash Chat iOS13
//
//  Created by Abigail Thelin on 2/17/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import SwiftUI
import ARKit
import RealityKit

struct ScanningViewController: View {
    @Binding var caseNumber: String
    @State var recording = true
    @State var someText = "Start Recording"
    
    
    @ObservedObject var caseUpdater = CaseUpdater()
    
    var body: some View {
        ZStack {
           NavigationIndicator()
           VStack {
              Spacer()
              Spacer()
               Button(action: {
                   if (recording) {
                       recording.toggle()
                       self.someText = "Stop Recording"
                   } else {
                       self.someText = "Finished Recording"
                           caseUpdater.addScan(caseNumber: caseNumber)
                   }
                   }) {
                       Text(self.someText)

                   }
                  .padding()
                  .background(RoundedRectangle(cornerRadius: 10)
                  .foregroundColor(Color.white).opacity(0.7))
           }
        }
    }
}

struct ScanningViewController_Previews: PreviewProvider {
    static var previews: some View {
        ScanningViewController(caseNumber: .constant("2468"))
    }
}


// MARK: - NavigationIndicator
struct NavigationIndicator: UIViewControllerRepresentable {
   typealias UIViewControllerType = ARView
   func makeUIViewController(context: Context) -> ARView {
      return ARView()
   }
   func updateUIViewController(_ uiViewController:
   NavigationIndicator.UIViewControllerType, context:
   UIViewControllerRepresentableContext<NavigationIndicator>) { }
}

//struct RealityKitView: UIViewControllerRepresentable {
////    typealias UIViewControllerType = ARView
//    
//    func makeUIViewController(context: Context) -> ARView {
//        var view: ARView = ARView()
//
//                // Start AR session
//        let session = view.session
//        let config = ARWorldTrackingConfiguration()
//        config.planeDetection = [.horizontal,.vertical]
//        config.environmentTexturing = .automatic
//        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh){
//            config.sceneReconstruction = .mesh
//        }
//        view.session.delegate = context.coordinator
//        view.session.run(config)
//
//                // Add coaching overlay
//        let coachingOverlay = ARCoachingOverlayView()
//        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        coachingOverlay.session = session
//        coachingOverlay.goal = .horizontalPlane
//        return view
//    }
//    
//    func updateUIViewController(_ uiViewController: ARView, context: Context) {
//        print("updateUIViewController", context)
//    }
//    func didFailWithError() {
//        print("ERROR BITCH")
//    }
//    
//}
