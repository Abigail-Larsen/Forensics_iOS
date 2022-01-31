//
//  CaseViewController.swift
//  Flash Chat iOS13
//
//  Created by Abigail Thelin on 1/3/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import SwiftUI
import Firebase

struct CaseViewController: View {
    @State var showCreateCaseModalView: Bool = false
    
    var options = ["Cases", "Archive", "Locations"]
    @State private var pickerValue = "Cases"

    let db = Firestore.firestore()
    @State private var casesList: [Case] = []
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(red: 0.79, green: 0.74, blue: 1.00, alpha: 1.00)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.systemGray], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
    }


    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(red: 0.79, green: 0.74, blue: 1.00))
                    .padding(.trailing, 10)
                Text("Cases").foregroundColor(.white).font(.system(size: 24))
                Spacer()
                Button(action:{
                    print("hit the search button")
                })
                {
                    Image("search").resizable().frame(width: 18, height: 18)
                }
            }
            
            VStack{
                Picker("", selection: $pickerValue) {
                    ForEach(options, id: \.self){
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(20)
                // CaseList()
                Spacer()
                if pickerValue == "Cases" {
                    Text("You have 0 Cases").foregroundColor(.white)
                }
                if pickerValue == "Archive" {
                    Text("You have 0 Archived").foregroundColor(.white)
                }
                if pickerValue == "Locations" {
                    Text("You have 0 Locations").foregroundColor(.white)
                }
                Spacer()
            }
            
            HStack {
                Spacer()
                Button(action:{
                    showCreateCaseModalView = true
                })
                {
                    Image(systemName: "plus.app.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color(red: 0.79, green: 0.74, blue: 1.00))
                }
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            loadCases()
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
        
    
    func loadCases () {
           db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener{(QuerySnapshot, error) in
               casesList = []
               if let e = error {
                   print("Error retrieving data from firestore", e)
               } else {
                   if let snapshotDocuments = QuerySnapshot?.documents{
                       for doc in snapshotDocuments {
                           let data = doc.data()
                           print(data)
                           if let sender = data[K.FStore.senderField] as? String, let caseName = data[K.FStore.caseName] as? String, let caseNumber = data[K.FStore.caseNumber] as? String{
                               
                               print(data)
                               let newCase = Case(sender: sender, caseName: caseName, caseNumber: caseNumber,  caseDescription: "description", id: 123)
                               self.casesList.append(newCase)
                               
//                               DispatchQueue.main.async {
//                                   self.tableView.reloadData()
//                               }
                           }
                       }
                   }
               }
           }
       }
    
    
    
}

struct CaseViewController_Previews: PreviewProvider {
    static var previews: some View {
        CaseViewController()
    }
}

