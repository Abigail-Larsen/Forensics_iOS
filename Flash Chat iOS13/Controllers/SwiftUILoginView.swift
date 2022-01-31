//
//  SwiftUILoginView.swift
//  Flash Chat iOS13
//
//  Created by Abigail Thelin on 1/30/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import SwiftUI


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
    
    @State private var username: String = "USER12345!"
    @State private var password: String = "123456"
    
    var body: some View {
        Color.black.ignoresSafeArea().overlay(
            VStack(spacing: 50) {
                
                Text("Login").foregroundColor(.white).font(.system(size: 36, weight: .bold))
                
                VStack(spacing: 15){
                    TextField("Username", text: $username, prompt: Text("UserName..."))
                        .foregroundColor(.white)
                        .textFieldStyle(OvalTextFieldStyled())
                    
                    TextField("Password", text: $password, prompt: Text("Password..."))
                        .foregroundColor(.white)
                        .textFieldStyle(OvalTextFieldStyled())
                }
                
                
                NavigationLink(
                    destination: CaseViewController().navigationBarHidden(true)
                ) {
                    Text("Sign In")
                        .foregroundColor(.black)
                        .padding(10)
                        .background(Color(red: 0.79, green: 0.74, blue: 1.00))
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
                Spacer()

            }
                .padding(30)
                .padding(.top, 60)
        )
    }
}

struct SwiftUILoginView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUILoginView()
    }
}
