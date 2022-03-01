//
//  SwiftUILoginView.swift
//  Flash Chat iOS13
//
//  Created by Abigail Thelin on 1/30/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import SwiftUI
import Firebase
import Combine

struct OvalTextFieldStyled: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(Color(red: 0.25, green: 0.25, blue: 0.25))
            .border(.white)
            .cornerRadius(5)
    }
}


struct SwiftUILoginView: View {
    @State var isLinkActive = false
    @State private var username: String = "1@3.gmail.com";
    @State private var password: String = "123456";
    @State private var caseNumber: String = "2468";
    

    var body: some View {
        Color.black.ignoresSafeArea().overlay(
            VStack(spacing: 50) {
                
                Text("Login").foregroundColor(.white).font(.system(size: 36, weight: .bold))
                
                VStack(spacing: 15){
                    TextField("Username", text: $username, prompt: Text("UserName..."))
                        .foregroundColor(.white)
                        .textFieldStyle(OvalTextFieldStyled())
                    
                    SecureField("Password", text: $password, prompt: Text("Password..."))
                        .foregroundColor(.white)
                        .textFieldStyle(OvalTextFieldStyled())
                }
                
                
                NavigationLink(
                    destination: CaseViewController().navigationBarHidden(true),
//                    destination: CaseDetailsUI(caseNumber: $caseNumber),
                    isActive: $isLinkActive
                ) {
                    Button(action: { login() }) {
                        Text("Sign In")
                            .foregroundColor(.black)
                            .padding(10)
                            .background(Color(red: 0.79, green: 0.74, blue: 1.00))
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                }
                Spacer()

            }
                .padding(30)
                .padding(.top, 60)
        )
    }
    
    func login() {
           Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
               if error != nil {
                   print("ERROR",error?.localizedDescription ?? "")
               } else {
                   print("success")
                   self.isLinkActive = true
               }
           }
       }
}

struct SwiftUILoginView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUILoginView()
    }
}

