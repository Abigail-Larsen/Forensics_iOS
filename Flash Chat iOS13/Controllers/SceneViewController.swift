//
//  SceneViewController.swift
//  Flash Chat iOS13
//
//  Created by Abigail Thelin on 10/31/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation
import UIKit
import SceneKit
import ARKit
import RealityKit

class SceneViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var myARSCNView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.sceneReconstruction = .meshWithClassification

        configuration.environmentTexturing = .manual
        myARSCNView.session.run(configuration)
         
        let scene = SCNScene(named: "mesh.obj", inDirectory: "assets.scnassets")
        let ship = scene?.rootNode.childNode(withName: "ship", recursively: true)
//        let temp = ARS
//        let tempScene = ARSCN(named: "art.scnassets/cat/cat.obj")!
//       modelNode = tempScene.rootNode
//       modelNode.simdPosition = float3(0, 0, 0.5)
//       sceneView.scene.rootNode.addChildNode(modelNode)

        print("ship", scene)
//        ship?.simdPosition = float3(0, 0, -0.5)
//        // half a meter in front of the *initial* camera position
//        myARSCNView.scene.rootNode.addChildNode(ship!)
        print("HIT SCENE VIEW CONTROLLER")
    }
    
}
