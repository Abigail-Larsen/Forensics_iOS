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

    let db = Firestore.firestore()
    @State private var casesList: [Case] = []

    var body: some View {
        Color.black.ignoresSafeArea().overlay(
            VStack {
                HStack(alignment: .center) {
                    Text("menu").foregroundColor(.white)
                    Spacer()
                    Text("My Cases").foregroundColor(.white).font(.system(size: 30))
                    Spacer()
                    Image("search").resizable().frame(width: 31, height: 31)
                }
                
                VStack{
                    CaseList()
                }
                
                HStack {
                    Spacer()
                    Button(action:{
                        print("hit the add button")
                    })
                    {
                        Image("AddIcon").resizable().frame(width: 60, height: 60)
                    }

                   
                }
            }
            .onAppear {
                loadCases()
            }
        )
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

