//
//  CaseViewController.swift
//  Flash Chat iOS13
//
//  Created by Abigail Thelin on 1/3/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import SwiftUI
import Firebase

struct CaseData: Identifiable, Codable {
    var id: String
    var caseName: String
    var caseNumber: String
    var sender: String
}

struct CaseViewController: View {
    @State var showCreateCaseModalView: Bool = false
    
    var options = ["Cases", "Archive", "Locations"]
    @State private var pickerValue = "Cases"
    
    @ObservedObject var caseGetter = CaseGetter()
    

    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .white
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.systemGray], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
    }


    var body: some View {
        VStack {
            HStack(alignment: .center) {
//                Image(systemName: "person.crop.circle")
//                    .resizable()
//                    .frame(width: 30, height: 30)
//                    .foregroundColor(Color(red: 0.79, green: 0.74, blue: 1.00))
//                    .padding(.trailing, 10)
                Text("Cases").foregroundColor(.white).font(.system(size: 36, weight: .bold))
                Spacer()
                Button(action:{
                    print("hit the search button")
                })
                {
                    Image("search").resizable().frame(width: 18, height: 18)
                }
            }
            .padding(.top, 30)
            
            VStack{
                Picker("", selection: $pickerValue) {
                    ForEach(options, id: \.self){
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.bottom, 10)
                if pickerValue == "Cases" {
                    if caseGetter.cases.isEmpty {
                        Spacer()
                        Text("You have 0 Cases").foregroundColor(.white)
                        Spacer()
                    } else {
                        ScrollView {
                          ForEach(caseGetter.cases) { details in
                            VStack(alignment: .leading){
                                CaseListItem(caseName: details.caseName, caseNumber: .constant(details.caseNumber)).frame(height:80)
                            }
                            .padding(.top, 10)
                          }
                            .background(Color.black)
                            .edgesIgnoringSafeArea(.all)
                        }
                        Spacer()
                    }
                }
                if pickerValue == "Archive" {
                    Spacer()
                    Text("You have 0 Archived").foregroundColor(.white)
                    Spacer()
                }
                if pickerValue == "Locations" {
                    Spacer()
                    Text("You have 0 Locations").foregroundColor(.white)
                    Spacer()
                }
                Spacer()
            }
            
            HStack {
                Spacer()
                Button(action:{
                    showCreateCaseModalView = true
                })
                {
                    Label("Add Case", systemImage: "plus.circle")
                        .foregroundColor(.black)
                        .padding(10)
                }
                .background(Color(red: 0.79, green: 0.74, blue: 1.00))
                .cornerRadius(15)
            }
            .onAppear{
                caseGetter.fetchAllCases()
            }
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showCreateCaseModalView) {
            CreateCaseUI().navigationBarHidden(true)
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .padding(30)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct CaseViewController_Previews: PreviewProvider {
    @State static var caseData = [["caseName": "lehi", "date": 1635196214.231723, "sender": "1@2.com", "caseNumber": 2468, "id": 1111]]
    static var previews: some View {
        CaseViewController()
    }
}

