//
//  CaseList.swift
//  Flash Chat iOS13
//
//  Created by Abigail Thelin on 1/3/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import SwiftUI
import Foundation
import UIKit

struct CaseList: View {

    var body: some View {
        NavigationView {
            List(casesTESTING) {
                currentPlayer in
//                NavigationLink(destination: CaseDetailsUI()) {÷
                    CaseListItem(caseName: "currentCase.caseName", caseDescription: "currentCase.caseDescription").frame(height:60)
//                }
            }.navigationBarTitle(Text("NBA Finals Players"))
        }
        
        
        
        
//        NavigationView{
//            ZStack {
//                Color.black.edgesIgnoringSafeArea(.all)
//                ScrollView {
//                    List(casesTESTING) {
//                        currentCase in
//                        CaseListItem(caseName: "currentCase.caseName", caseDescription: "currentCase.caseDescription").frame(height: 75).padding(10)
//                    }
//                }
//            }
//            List(casesTESTING) {
//                currentCase in
//                CaseListItem(caseName: currentCase.caseName, caseDescription:currentCase.caseDescription).frame(height: 75).padding(10)
//            }
//            Spacer()
//        }
    }
}

struct CaseList_Previews: PreviewProvider {
    static var previews: some View {
        CaseList()
    }
}
