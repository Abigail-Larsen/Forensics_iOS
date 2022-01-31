//
//  CaseDetailsUI.swift
//  Flash Chat iOS13
//
//  Created by Abigail Thelin on 1/3/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import SwiftUI

struct CaseDetailsUI: View {
    @Binding var caseNumber: String
    var body: some View {
        NavigationView{
                VStack{
                    HStack {
                        NavigationLink(destination: CaseViewController().navigationBarHidden(true)) {
                            Image(systemName: "arrow.backward").foregroundColor(.white)
                        }
                        Spacer()
                        Text(caseNumber).foregroundColor(.white).font(.system(size: 24))
                        Spacer()
                        Button(action:{
                            print("hit the search button")
                        })
                        {
                            Image("search").resizable().frame(width: 18, height: 18)
                        }
                    }
                    
                    VStack{

                        Spacer()
                        Text("No info").foregroundColor(.white)
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
//                        NavigationLink(
//                            destination: nil
//                        ) {
//                            Image(systemName: "plus.app.fill")
//                                   .resizable()
//                                   .frame(width: 30, height: 30)
//                                   .foregroundColor(Color(red: 0.79, green: 0.74, blue: 1.00))
//
//                        }
                        Button(action:{
                            print("ADDING")
                        })
                        {
                            Image(systemName: "plus.app.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color(red: 0.79, green: 0.74, blue: 1.00))
                        }
                    }
                
                .navigationTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                .padding(20)
            }
                .background(.black)
                .navigationTitle("")
                .navigationBarHidden(true)
        }
    }
}

struct CaseDetailsUI_Previews: PreviewProvider {
    static var previews: some View {
        CaseDetailsUI(caseNumber: .constant("123"))
.previewInterfaceOrientation(.portrait)
    }
}
