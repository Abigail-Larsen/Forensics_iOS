//
//  EditImgInfo.swift
//  Flash Chat iOS13
//
//  Created by Abigail Thelin on 2/12/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct EditImgInfo: View {
    @Binding var imgName: String
    @Binding var caseNumber: String
    @Binding var imgTitle: String
    @Binding var imgDescription: String
    
    
    @State var isLinkActive = false
    @State private var newDescription = ""
    @State private var newTitle = ""
    
    
    @ObservedObject var caseUpdater = CaseUpdater()

    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                TextField("Image Title", text: $newTitle )
                    .foregroundColor(.white)
                    .textFieldStyle(OvalTextFieldStyle())
                
                ZStack {
                    TextEditor(text: $newDescription)
                        .textFieldStyle(OvalTextFieldStyle())
                    Text(newDescription).opacity(0).padding(.all, 8)
                }
                NavigationLink(
                    destination: CaseDetailsUI(caseNumber: $caseNumber).navigationBarHidden(true),
                    isActive: $isLinkActive

                ) {
                    
                    Button(action: {
                        caseUpdater.updateImgInfo(newTitle: newTitle, newDescription: newDescription, caseNumber: caseNumber, imgName: imgName)
                        
                        self.isLinkActive = true
                    }) {
                        
                        Text("Save")
                            .foregroundColor(.black)
                            .padding(15)
                            .background(Color(red: 0.79, green: 0.74, blue: 1.00))
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                    
                }
                Spacer()
            }
            .padding(.leading,30)
            .padding(.trailing,30)
            .background(Color(red: 0.18, green: 0.18, blue: 0.18))
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear{
            self.newDescription = imgDescription
            self.newTitle = imgTitle
        }

    }
}

struct EditImgInfo_Previews: PreviewProvider {
    static var previews: some View {
        EditImgInfo(imgName: .constant("testImg.png"), caseNumber: .constant("2468"), imgTitle: .constant("Untitled"), imgDescription: .constant("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."))
    }
}
