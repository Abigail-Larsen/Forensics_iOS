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
    var caseDescription: String
    var body: some View {
        Color.black.ignoresSafeArea().overlay(
            HStack {
                Image("folder").resizable().frame(width: 23, height: 17).padding(.leading, 25).padding(.trailing, 30 )
                VStack(alignment: .leading) {
                    Text(caseName).foregroundColor(.white).font(.system(size:15, weight: .heavy))
                    Text(caseDescription).foregroundColor(.white).font(.system(size:12, weight: .light))
                }
                Spacer()
                Image("downArrow").frame(width: 33, height: 33).padding(.trailing, 30)
            }
        ).overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white, lineWidth: 2)
        )
    }
}

struct CaseListItem_Previews: PreviewProvider {
    static var previews: some View {
        CaseListItem(caseName: "Testing", caseDescription: "case description").previewLayout(.fixed(width: 350, height: 75
        ))
    }
}
