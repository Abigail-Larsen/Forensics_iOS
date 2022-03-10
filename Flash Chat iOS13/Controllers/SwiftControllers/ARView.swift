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
import RealityKit

// MARK: - ARViewIndicator
struct ARViewIndicator: UIViewControllerRepresentable {
   typealias UIViewControllerType = ARView
   
   func makeUIViewController(context: Context) -> ARView {
       let view = ARView()
       
       return view
   }
   func updateUIViewController(_ uiViewController:
   ARViewIndicator.UIViewControllerType, context:
   UIViewControllerRepresentableContext<ARViewIndicator>) { }
}

class ARView: UIViewController, ARSCNViewDelegate {

    let colorizer = Colorizer()
    var modelsForClassification: [ARMeshClassification: ModelEntity] = [:]

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
        configuration.planeDetection = [.horizontal, .vertical]
        arView.debugOptions.insert(.showSkeletons)

        arView.session.run(configuration)
        arView.delegate = self

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        arView.addGestureRecognizer(tapRecognizer)
    }

    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        guard let meshAnchor = anchor as? ARMeshAnchor else {
            return nil
        }
        let geometry = SCNGeometry(arGeometry: meshAnchor.geometry)
        
        let classification = meshAnchor.geometry.classificationOf(faceWithIndex: 0)
        let defaultMaterial = SCNMaterial()
        defaultMaterial.fillMode = .lines
        defaultMaterial.diffuse.contents = colorizer.assignColor(to: meshAnchor.identifier, classification: classification)
        geometry.materials = [defaultMaterial]
        let node = SCNNode()
        node.geometry = geometry
        return node
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let meshAnchor = anchor as? ARMeshAnchor else {
            return
        }
        
        let newGeometry = SCNGeometry(arGeometry: meshAnchor.geometry)
        
        let classification = meshAnchor.geometry.classificationOf(faceWithIndex: 0)
        let defaultMaterial = SCNMaterial()
        defaultMaterial.fillMode = .lines
        defaultMaterial.diffuse.contents = colorizer.assignColor(to: meshAnchor.identifier, classification: classification)
        newGeometry.materials = [defaultMaterial]
        node.geometry = newGeometry
    }
    
        func saveButtonTapped() {
            print("Saving is executing...")

            guard let device = MTLCreateSystemDefaultDevice() else {
                print("Unable to create MTLDevice")
                return
            }

            guard let meshAnchors = arView.session.currentFrame?.anchors.compactMap({ $0 as? ARMeshAnchor }) else { return }


            let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0];
            let filename = directory.appendingPathComponent("MyFirstMesh.obj");

            do {
                try meshAnchors.save(to: filename, device: device)
                print("meshAnchors", meshAnchors)
                let activityViewController = UIActivityViewController(activityItems: [filename], applicationActivities: nil)
//                activityViewController.popoverPresentationController?.sourceView = scanButton
                present(activityViewController, animated: true, completion: nil)
            } catch {
                print("Unable to save mesh")
            }
        }


        @objc
        func handleTap(_ sender: UITapGestureRecognizer) {
            // 1. Perform a ray cast against the mesh.
            // Note: Ray-cast option ".estimatedPlane" with alignment ".any" also takes the mesh into account.
            let tapLocation = sender.location(in: arView)
            guard let meshAnchors = arView.session.currentFrame?.anchors.compactMap({ $0 as? ARMeshAnchor }) else { return }
            saveButtonTapped()
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
        configuration.planeDetection = [.horizontal, .vertical]
//        arView.environment.sceneUnderstanding.options.insert(.occlusion)
        arView.session.run(configuration)
        arView.delegate = self
    }
    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       arView.session.pause()
    }
    
    func sessionWasInterrupted(_ session: ARSession) {}

    func sessionInterruptionEnded(_ session: ARSession) {}

    func session(_ session: ARSession, didFailWithError error: Error)
    { }

    func session(_ session: ARSession, cameraDidChangeTrackingState
    camera: ARCamera) {
    }
}
