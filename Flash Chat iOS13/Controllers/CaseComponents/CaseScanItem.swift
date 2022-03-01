//
//  CaseScanItem.swift
//  Flash Chat iOS13
//
//  Created by Abigail Thelin on 2/28/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import SwiftUI

struct CaseScanItem: View {
    @Binding var caseNumber: String
    @Binding var date: String
    
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading) {
                    Text("Scan:")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .bold))
                    Text("Untitled Scan")
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .light))
                        .padding(.leading, 20)
                    Text("\(String(date))")
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .light))
                        .padding(.leading, 20)

                }
                .padding(.leading, 20)
                .padding(.top, 10)
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.black)
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
            }
        }
        .frame(width: 370, height: 130)
        .cornerRadius(30)
        .background(
            RoundedRectangle(
                cornerRadius: 20,
                style: .continuous
            )
                .fill(Color(red: 0.79, green: 0.74, blue: 1.00))
        )
    }
}

struct CaseScanItem_Previews: PreviewProvider {
    static var previews: some View {
        CaseScanItem( caseNumber: .constant("2468"), date: .constant("LOL"))
    }
}
