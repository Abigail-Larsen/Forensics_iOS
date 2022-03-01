//
//  CreateCaseUI.swift
//  Flash Chat iOS13
//
//  Created by Abigail Thelin on 1/30/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import SwiftUI

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(Color(red: 0.25, green: 0.25, blue: 0.25))
            .cornerRadius(5)
    }
}

struct CreateCaseUI: View {
    @State private var caseName: String = ""
    @State private var caseNumber: String = ""
    @ObservedObject var caseUpdater = CaseUpdater()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Create Case").foregroundColor(.white).font(.system(size: 24, weight: .bold))
                
                TextField("Case Name", text: $caseName, prompt: Text("Case Name..."))
                    .foregroundColor(.white)
                    .textFieldStyle(OvalTextFieldStyle())
                
                TextField("Case Number", text: $caseNumber, prompt: Text("Case Number..."))
                    .foregroundColor(.white)
                    .textFieldStyle(OvalTextFieldStyle())
                
                
                NavigationLink(
                    destination: CaseDetailsUI(caseNumber: $caseNumber).navigationBarHidden(true)
                ) {
                    Button(action:{
                        caseUpdater.addCase(caseName: caseName, caseNumber: caseNumber)
                    })
                    {
                        Label("Add Case", systemImage: "")
                            .foregroundColor(.black)
                            .padding(15)
                            .background(Color(red: 0.79, green: 0.74, blue: 1.00))
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                }
                Spacer()
            }
                .navigationTitle("")
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
                .padding(30)
                .background(Color(red: 0.18, green: 0.18, blue: 0.18))
                .edgesIgnoringSafeArea(.all)
        }

    }
}

struct CreateCaseUI_Previews: PreviewProvider {
    static var previews: some View {
        CreateCaseUI()
    }
}
