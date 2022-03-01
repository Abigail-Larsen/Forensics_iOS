//
//  CaseListItem.swift
//  Flash Chat iOS13
//
//  Created by Abigail Thelin on 1/3/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import SwiftUI

struct CaseListItem: View {
    
    var caseName: String
    @Binding var caseNumber: String
    
    var body: some View {
            HStack {
                
                NavigationLink(
                    destination: CaseDetailsUI(caseNumber: $caseNumber)
                ) {
                    Image(systemName: "folder.fill")
                        .foregroundColor(.white)
                        .padding(.leading, 25)
                    
                    VStack(alignment: .leading) {
                        Text(caseNumber)
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .medium))
                        Text(caseName)
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .light))
                    }.padding(15)
                    Spacer()
                }
            }
            .frame(width: 370, height: 80)
            .background(
                RoundedRectangle(
                    cornerRadius: 10,
                    style: .continuous
                )
                .fill(Color(red: 0.11, green: 0.11, blue: 0.11))
            )
    }
}

struct CaseListItem_Previews: PreviewProvider {
    static var previews: some View {
        CaseListItem(caseName: "Downtown Case", caseNumber:.constant("CW321456789"))
    }
}
