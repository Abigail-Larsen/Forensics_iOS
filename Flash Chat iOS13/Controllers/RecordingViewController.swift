//
//  RecordingViewController.swift
//  Flash Chat iOS13
//
//  Created by Abigail Thelin on 10/25/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

import SceneKit
import ARKit

class RecordingViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    
    override func viewDidLoad() {
           super.viewDidLoad()
           
           // Set the view's delegate
           sceneView.delegate = self
           self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
           sceneView.autoenablesDefaultLighting = true

   }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           
           if let touch = touches.first {
               
               let touchLocation = touch.location(in: sceneView)
               
               let results = sceneView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
               
               print("HIT THIS ONCE", touchLocation, results)
//               if let hitResult = results.first {

                   // Create a new scene
//                   let diceScene = SCNScene(named: "art.scnassets/diceCollada.scn")!

//                   if let diceNode = diceScene.rootNode.childNode(withName: "Dice", recursively: true) {
//
//                       diceNode.position = SCNVector3(
//                           x: hitResult.worldTransform.columns.3.x,
//                           y: hitResult.worldTransform.columns.3.y + diceNode.boundingSphere.radius,
//                           z: hitResult.worldTransform.columns.3.z
//                       )
//
//                       sceneView.scene.rootNode.addChildNode(diceNode)
//
//                       let randomX = Float((arc4random_uniform(4) + 1)) * (Float.pi/2)
//                       //        let randomY = Double((arc4random_uniform(10) + 11)) * (Double.pi/2)
//                       let randomZ = Float((arc4random_uniform(4) + 1)) * (Float.pi/2)
//
//                       diceNode.runAction(SCNAction.rotateBy(x: CGFloat(randomX * 5), y: 0, z: CGFloat(randomZ * 5), duration: 0.5))
//
//                   }
                   
//               }
               
           }
       }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        if anchor is ARPlaneAnchor {
            
            print("plane detected")
            
            let planeAnchor = anchor as! ARPlaneAnchor

            let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
            
            let gridMaterial = SCNMaterial()
            gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
            plane.materials = [gridMaterial]
            
            let planeNode = SCNNode()

            planeNode.geometry = plane
            planeNode.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
            
//            node.addChildNode(planeNode)
            
        } else {
            return
        }
    }
    
}
