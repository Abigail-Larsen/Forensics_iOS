//
//  ScanObj.swift
//  Flash Chat iOS13
//
//  Created by Abigail Thelin on 3/9/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import SwiftUI
import SceneKit

struct ScanObj: View {

    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            SceneView(scene: SCNScene(named: "toy_robot_vintage.usdz"), options: .autoenablesDefaultLighting)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/1.5)
        }
    }
}

struct ScanObj_Previews: PreviewProvider {
    static var previews: some View {
        ScanObj()
    }
}

