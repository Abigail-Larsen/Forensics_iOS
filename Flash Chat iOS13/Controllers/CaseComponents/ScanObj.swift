//
//  ScanObj.swift
//  Flash Chat iOS13
//
//  Created by Abigail Thelin on 3/9/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import SwiftUI
import SceneKit


enum FeatureState {
    case Bathroom
    case Office
}

struct ScanObj: View {
    @ObservedObject var caseGetter = CaseGetter()
    @Binding var caseNumber: String
    @Binding var caseName: String
    @State private var isEditingText = false
    var OfficeScene = SCNScene(named: "iphone 12 pro versionMESH.obj")
    var BathroomScene = SCNScene(named: "BathroomMesh.obj")
    var LivingRoom = SCNScene(named: "Living Room Mesh.obj")

    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                
                Button(action: {
                    isEditingText.toggle()
                }, label:{
                    HStack{
                        Spacer()
                        Text(caseName)
                            .foregroundColor(.white)
                            .font(.system(size: 28, weight: .bold))
                            .padding(.top, 16)
                            .padding(.bottom, 5)
                            .truncationMode(.tail)
                            .lineLimit(1)
                        Spacer()
                        Image(systemName: "pencil")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(Color(red: 0.79, green: 0.74, blue: 1.00))
                            .padding(.top, 8)
                    }
                })
                Spacer()
                
            }
            VStack{
                
                if caseName == "Bathroom" {
                    SceneView(scene: BathroomScene,
                              options: [.allowsCameraControl, .autoenablesDefaultLighting]
                    )
                        .foregroundColor(.white)
                } else if caseName == "Office" {
                    SceneView(scene: OfficeScene,
                              options: [.allowsCameraControl, .autoenablesDefaultLighting]
                    )
                } else if caseName == "Living Room" {
                    SceneView(scene: LivingRoom,
                              options: [.allowsCameraControl, .autoenablesDefaultLighting]
                    )
                } else {
                    SceneView(scene: OfficeScene,
                              options: [.allowsCameraControl, .autoenablesDefaultLighting]
                    )
                }
                VStack{
                    Spacer()
                    Text("No Tags for this scan")
                        .foregroundColor(.white)
                    Spacer()
                }
            }
        }
        .background(.black)
        .onAppear{
            caseGetter.fetchMesh(caseNumber: "2468")
        }
    }
}

struct ScanObj_Previews: PreviewProvider {
    static var previews: some View {
        ScanObj( caseNumber: .constant("2468"), caseName: .constant("LOL"))
    }
}


//https://firebasestorage.googleapis.com/v0/b/flashchat-7e52f.appspot.com/o/meshObj.obj?alt=media&token=5fd819f7-62a3-47a8-ad13-9aa18ac361a9
