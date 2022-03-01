//
//  ARView.swift
//  Flash Chat iOS13
//
//  Created by Abigail Thelin on 2/17/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import Foundation
import ARKit
import SwiftUI


// MARK: - ARViewIndicator
struct ARViewIndicator: UIViewControllerRepresentable {
   typealias UIViewControllerType = ARView
   
   func makeUIViewController(context: Context) -> ARView {
      return ARView()
   }
   func updateUIViewController(_ uiViewController:
   ARViewIndicator.UIViewControllerType, context:
   UIViewControllerRepresentableContext<ARViewIndicator>) { }
}



class ARView: UIViewController, ARSCNViewDelegate {
    
    
    var arView: ARSCNView {
       return self.view as! ARSCNView
    }
    override func loadView() {
      self.view = ARSCNView(frame: .zero)
    }
    override func viewDidLoad() {
       super.viewDidLoad()
       arView.scene = SCNScene()
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.sceneReconstruction = .meshWithClassification
        
        configuration.environmentTexturing = .manual
        arView.session.run(configuration)
        arView.delegate = self
        print("FUCKING FU K", arView)
    }
    
    
    
    // MARK: - Functions for standard AR view handling
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.sceneReconstruction = .meshWithClassification
        
        print("FUCK", configuration)
        configuration.environmentTexturing = .manual
        arView.session.run(configuration)
        arView.delegate = self
    }
    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       arView.session.pause()
    }
    // MARK: - ARSCNViewDelegate
    func sessionWasInterrupted(_ session: ARSession) {}
    
    func sessionInterruptionEnded(_ session: ARSession) {}
    
    func session(_ session: ARSession, didFailWithError error: Error)
    {print("FAILED WITH ERROR")}
    
    func session(_ session: ARSession, cameraDidChangeTrackingState
    camera: ARCamera) {
        print("CAMER DID CHANGE TRACKING STATE",camera)
    }


}
